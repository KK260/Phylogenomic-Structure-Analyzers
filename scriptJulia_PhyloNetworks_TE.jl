

using Pkg
using PhyloNetworks
using CSV
using DataFrames
#using PhyloPlots 
using RCall


genetrees = readMultiTopology("input_Phylonetwork_bootstraps")
astraltree = readMultiTopology("astral.tre")[1]


tm = DataFrame(CSV.File("mapping"))
taxonmap = Dict(tm[i,:allele] => tm[i,:species] for i in 1:13)		### 38 in questo caso è il numero di alleli nel mapping file (numero di righe meno 1 (quella in cui è scritto "allele" e "species"))


#### df_sp = writeTableCF(countquartetsintrees(genetrees, taxonmap)...)

#### CSV.write("tableCF_species.csv", df)				# to save the data frame to a file
#### d_sp = readTableCF("tableCF_species.csv")				# to get a "DataCF" object for use in snaq!.


#df_ind = writeTableCF(countquartetsintrees(genetrees)...) 		# no mapping here: so quartet CFs across individuals
### CSV.write("tableCF_individuals.csv", df)               		# to save to a file
#CSV.write("tableCF_individuals.csv", df_ind)
#df_sp = mapAllelesCFtable("mapping", "tableCF_individuals.csv");
#d_sp = readTableCF!(df_sp);

df_sp = writeTableCF(countquartetsintrees(genetrees, taxonmap)...)		#This time worked this (between-species 4-taxon sets)
CSV.write("tableCF_species.csv", df_sp)
d_sp = readTableCF("tableCF_species.csv") # to get a "DataCF" object for use in snaq!.


net0 = snaq!(astraltree, d_sp, hmax=0, filename="net0", seed=1234)	#NET0

net1 = snaq!(net0, d_sp, hmax=1, filename="net1", seed=1234)		#NET1

net2 = snaq!(net1, d_sp, hmax=2, filename="net2", seed=1234)		#NET1


R"name = function(x) file.path('..', 'assets', 'figures', x)"			### Salvare le Tabelle ###
R"svg(filename = 'net2_scores.svg',  width=5, height=5)"
R"par"(mar=[0,0,0,0]);
scores = [net0.loglik, net1.loglik, net2.loglik]
R"plot"(scores, type="b", ylab="network score", xlab="hmax", col="blue");
R"dev.off()";




### Salvare i Networks in Files ###

#R"name = function(x) file.path('..', 'assets', 'figures', x)"
#R"svg(filename = 'scores.svg',  width=5, height=5)"
#R"par"(mar=[0,0,0,0]);
#scores = [net0.loglik, net1.loglik, net2.loglik]
#R"plot"(scores, type="b", ylab="network score", xlab="hmax", col="blue");
#R"dev.off()";

#net = readMultiTopology("net1.networks")				# se il net1 `e quello col migliore score

#R"name = function(x) file.path('..', 'assets', 'figures', x)"
#R"svg(filename = 'net.svg',  width=13, height=10)"
#R"par"(mar=[0,0,0,0]);
#plot(net[2], showGamma=true, showEdgeNumber=true, :R);			# cambiare il nome del network e la posizione nel file
#R"dev.off()";

