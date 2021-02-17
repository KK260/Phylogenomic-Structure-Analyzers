

using Pkg
using PhyloNetworks
using CSV
using DataFrames
#using PhyloPlots


CF = readTableCF("SNPs2CF_all_min30_bspec_n_qu_hypothesis_10.csv")

tree = readMultiTopology("SNPs2CF_all_min30_bspec_n_qu_hypothesis_10.csv.QMC.tre")[1]


net0 = snaq!(tree, CF, hmax=0, filename="net0", verbose=true, seed=1234)	#NET0

net1 = snaq!(net0, CF, hmax=1, filename="net1", verbose=true, seed=1234)		#NET1




