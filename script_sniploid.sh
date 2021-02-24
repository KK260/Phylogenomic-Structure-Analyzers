#!/bin/sh

#SBATCH -o ./out_sniploid.txt 
#SBATCH -e ./error_sniploid.txt 
#SBATCH --exclusive  
#SBATCH -p medium 
#SBATCH -t 2-00:00:00
#SBATCH -n 10 
#SBATCH -C scratch2 


# Preparation: use of ipyrad output [concatenated consensus loci] of  diploid 1` (parent1) as reference (REF) 
module load JAVA/jdk1.8.0_31
module load Samtools/1.9
module load BWA/0.7.12

mv DIPLOID1.consens REF.fasta					# transfer .consens to .fasta file

samtools faidx REF.fasta						 # build index fasta file with SAMTOOLS/1.9

bwa index -a is REF.fasta						 # index reference with 

#java -jar /usr/product/bioinfo/PICARD/2.20.2/picard.jar CreateSequenceDictionary R=REF.fasta O=REF.dict	 # Create Sequence Dictionary PICARD/2.20.2 	





# Mapping of filtered reads (after step 2 IPYRAD) to REF with BWA/0.7.12


bwa mem -M -t 12 R_cassubicifolius_sl_merged.fasta POLYPLOID.fastq > POLYPLOID_to_REF.sam

bwa mem -M -t 12 R_cassubicifolius_sl_merged.fasta DIPLOID2.fastq  > DIPLOID2_to_REF.sam



#SAM to BAM and adding of readgroups with PICARD/2.10.5 for both `polyploid' and `diploid 2' (parent2)

java -jar /usr/product/bioinfo/PICARD/2.20.2/picard.jar SortSam I=POLYPLOID_to_REF.sam O=POLYPLOID_to_REF.bam SO=coordinate

java -jar /usr/product/bioinfo/PICARD/2.20.2/picard.jar AddOrReplaceReadGroups I=POLYPLOID_to_REF.bam O=POLYPLOID_to_REF_RG.bam RGID=POLYPLOID_to_REF RGLB=POLYPLOID_to_REF RGPL=Illumina RGPU=POLYPLOID_to_REF RGSM=POLYPLOID_to_REF

java -Djava.io.tmpdir=`pwd`/tmp -jar /usr/product/bioinfo/PICARD/2.20.2/picard.jar SortSam I=DIPLOID2_to_REF.sam O=DIPLOID2_to_REF.bam SO=coordinate TMP_DIR=`pwd`/tmp

java -Djava.io.tmpdir=`pwd`/tmp2 -jar /usr/product/bioinfo/PICARD/2.20.2/picard.jar AddOrReplaceReadGroups I=DIPLOID2_to_REF.bam O=DIPLOID2_to_REF_RG.bam RGID=DIPLOID2_to_REF RGLB=DIPLOID2_to_REF RGPL=Illumina RGPU=DIPLOID2_to_REF RGSM=DIPLOID2_to_REF TMP_DIR=`pwd`/tmp2

#Indexing with Samtools/1.9
module load SAMTOOLS/1.9

samtools index -b POLYPLOID_to_REF_RG.bam

samtools index -b DIPLOID2_to_REF_RG.bam



# SNP calling (GATK/4.1.7.0) and coverage depth (GATK/3.8) toolkit for `polyploid' and `diploid2'
module load GATK/4.1.7.0


gatk HaplotypeCaller -R R_cassubicifolius_sl_merged.fasta -I POLYPLOID_to_REF_RG.bam -O POLYPLOID_to_REF_SNPs.vcf --allow-non-unique-kmers-in-ref true
java -jar /usr/product/bioinfo/SL_7.0/BIOINFORMATICS/GATK/3.8/GenomeAnalysisTK.jar -T DepthOfCoverage -R R_cassubicifolius_sl_merged.fasta -I POLYPLOID_to_REF_RG.bam -o POLYPLOID_to_REF_CovDep --intervals POLYPLOID_to_REF_SNPs.vcf

gatk HaplotypeCaller -R R_cassubicifolius_sl_merged.fasta -I DIPLOID2_to_REF_RG.bam -O DIPLOID2_to_REF_SNPs.vcf --allow-non-unique-kmers-in-ref true

java -jar /usr/product/bioinfo/SL_7.0/BIOINFORMATICS/GATK/3.8/GenomeAnalysisTK.jar -T DepthOfCoverage -R R_cassubicifolius_sl_merged.fasta -I DIPLOID2_to_REF_RG.bam -o DIPLOID2_to_REF_CovDep --intervals DIPLOID2_to_REF_SNPs.vcf
 
mv POLYPLOID_to_REF_SNPs.vcf polyploid.vcf
mv POLYPLOID_to_REF_CovDep polyploid_depth.txt
mv DIPLOID2_to_REF_SNPs.vcf diploid.vcf
mv DIPLOID2_to_REF_CovDep diploid_depth.txt


# SNiPLoid: subsequent outputs files *.vcf and *CovDep of `polyploid' and `diploid2' can be used as input for SNiPloid (read depth 20)

perl ../../sniploid/SNiPloid.pl --vp polyploid.vcf --vg1 diploid.vcf --cpp polyploid_depth.txt --cg1 diploid_depth.txt --dp 20 --dg1 20 --ref 1





