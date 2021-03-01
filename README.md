# custom scripts for phylogenetic network and SNiPloid analyses


This code repository includes custom R, JULIA, and BASH scripts used in Karbstein et al. (submitted) to calculate phylogenetic networks among sexual progenitor species and polyploid apomictic derivates and to infer genome evolution of allopolyploids with SNiPloid based on different datasets (RADseq, target enrichment). The scripts can be directly applied. 

These are exemplary scripts to perform these kind of analyses, and you have to adjust the local directory paths to your own system or install required packages. 

1) 'converting_ustr_to_txt_for_SNPstoCF_function.R'. This R function is required to convert RADseq *ustr IPYRAD output files into appropriate input files for SNPstoCF.R function vers. 1.2 (see Olave et al., 2020, doi: 10.1093/sysbio/syaa005, github: https://github.com/melisaolave/SNPs2CF). We used the R vers. 4.0.3 for running the script on Windows/Mac OSs. Simply double-click on the R script, edit the details, and run the code. After converting, the file may need some additional manual editing.

2) 'scriptJulia_*.jl'. These JULIA (vers. 1.4.1) functions were used to create phylogenetic networks based on RADseq and target enrichment aligments (accessions of sexual progenitor species + one apomictic polyploid). We used Linux as OS. After loading the required packages (PhyloNetworks vers. 0.12.0, PhyloPlots vers. 0.2.1), you can run the code in JULIA by 'julia scriptJulia_*.jl'.

3) 'script_sniploid.sh'. This bash script was used to create result files for and to perform SNiPloid analyses on a linux-based high performance cluster (HPC). We applied the SNiPloid of 17th March 2016. Versions of all programs are given in the bash script. You can submit the bash script by 'sbatch script_sniploid.sh' on the HPC (Slurm).


We hope that these exemplary script were useful for you to calculate phylogenetic networks and SNiPloid analyses. You can use aligments provided on Figshare (e.g., RADseq *ustr and converted files, https://doi.org/10.6084/m9.figshare.13352429) for exemplary runs. Please do not hesitate to contact me, also if you have improvement suggestions (https://www.uni-goettingen.de/de/staff/185774.html)!
