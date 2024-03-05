# Custom scripts for phylogenetic network and SNiPloid analyses

Custom scripts for phylogenetic network and SNiPloid analyses in taxonomically complex groups (TCGs), exemplified on the Ranunculus auricomus species complex.

This code repository includes custom R, JULIA, and BASH scripts used in Karbstein et al. 2022 (https://onlinelibrary.wiley.com/doi/10.1111/nph.18284) to calculate species delimitation analyses (STACEY), phylogenetic networks among sexual progenitor species and polyploid apomictic derivates, and to infer genome evolution of allopolyploids with SNiPloid, based on different datasets (RADseq, target enrichment). 

These are exemplary scripts, and you have to adjust the local directory paths to your system or install the required packages. 

1) 'Stacey_2_e9.xml'. This xml file is used for STACEY analyses. Please see the publication for more details.

2) 'converting_ustr_to_txt_for_SNPstoCF_function.R'. This R function is required to convert RADseq *ustr IPYRAD output files into appropriate input files for SNPstoCF.R function vers. 1.2 (see Olave et al., 2020, doi: 10.1093/sysbio/syaa005, github: https://github.com/melisaolave/SNPs2CF). We used the R vers. 4.0.3 for running the script on Windows/Mac OS. Simply edit the R script, and run the code. After conversion, the file may need some additional manual editing.

3) 'scriptJulia_*.jl'. The JULIA (vers. 1.4.1) functions are used to create phylogenetic networks based on RADseq and target enrichment alignments (accessions of sexual progenitor species + one apomictic polyploid). We used Linux as OS. You can run the code in JULIA with 'julia scriptJulia_*.jl' after loading the required packages (PhyloNetworks vers. 0.12.0, PhyloPlots vers. 0.2.1).

4) 'script_sniploid.sh'. This bash script is used to create result files to perform SNiPloid analyses on a Linux-based high-performance cluster (HPC). We applied the SNiPloid version of 17th March 2016. Versions of all programs are given in the bash script. You can submit the bash script by 'sbatch script_sniploid.sh' on the HPC (Slurm).


We hope that these exemplary scripts are useful to calculate phylogenetic networks and SNiPloid analyses. You can use alignments provided on Figshare (e.g., RADseq *ustr and converted files, https://doi.org/10.6084/m9.figshare.13352429) for exemplary runs. Please do not hesitate to contact me if you have suggestions for improvement.





If you use the code, please cite: Karbstein K, Tomasello S, Hodač L, Wagner N, Marincek P, Barke BH, Pätzold C, Hörandl E. Untying Gordian knots: Unraveling reticulate polyploid evolution by RRS genomic data using the large Ranunculus auricomus species complex. New Phytologist, 2022; 235; 2081-2098. https://doi.org/10.1111/nph.18284
