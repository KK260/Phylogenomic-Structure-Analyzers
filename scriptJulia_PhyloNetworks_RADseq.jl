

using Pkg
using PhyloNetworks
using CSV
using DataFrames
using PhyloPlots
using RCall

CF = readTableCF("SNPs2CF_all_min30_bspec_n_qu_hypothesis_10.csv")

file = "net1.networks"

netlist = readMultiTopology(file)

scoresInString = read(`sed -E 's/.+with -loglik ([0-9]+.[0-9]+).+/\1/' $file`, String)

scores = parse.(Float64, split(scoresInString))

res = for i in eachindex(netlist)
                 netlist[i].loglik = scores[i]
                 println("net $i in the list: score = ",scores[i])
              end


open("output_net1_likelihoods.txt", "w") do file
	end 


R"name = function(x) file.path('..', 'assets', 'figures', x)" # function to create file name in appropriate folder
R"svg(filename = 'net1_1.svg', width=4, height=3)" # starts image file
R"par"(mar=[0,0,0,0]) # to reduce margins (no margins at all here)
plot(netlist[1], :R, showGamma=true, showEdgeNumber=true); # network is plotted & sent to file
R"dev.off()"; # wrap up and save image file


R"name = function(x) file.path('..', 'assets', 'figures', x)" # function to create file name in appropriate folder
R"svg(filename = 'net1_2.svg', width=4, height=3)" # starts image file
R"par"(mar=[0,0,0,0]) # to reduce margins (no margins at all here)
plot(netlist[2], :R, showGamma=true, showEdgeNumber=true); # network is plotted & sent to file
R"dev.off()"; # wrap up and save image file

R"name = function(x) file.path('..', 'assets', 'figures', x)" # function to create file name in appropriate folder
R"svg(filename = 'net1_3.svg', width=4, height=3)" # starts image file
R"par"(mar=[0,0,0,0]) # to reduce margins (no margins at all here)
plot(netlist[3], :R, showGamma=true, showEdgeNumber=true); # network is plotted & sent to file
R"dev.off()"; # wrap up and save image file

R"name = function(x) file.path('..', 'assets', 'figures', x)" # function to create file name in appropriate folder
R"svg(filename = 'net1_4.svg', width=4, height=3)" # starts image file
R"par"(mar=[0,0,0,0]) # to reduce margins (no margins at all here)
plot(netlist[4], :R, showGamma=true, showEdgeNumber=true); # network is plotted & sent to file
R"dev.off()"; # wrap up and save image file

R"name = function(x) file.path('..', 'assets', 'figures', x)" # function to create file name in appropriate folder
R"svg(filename = 'net1_5.svg', width=4, height=3)" # starts image file
R"par"(mar=[0,0,0,0]) # to reduce margins (no margins at all here)
plot(netlist[5], :R, showGamma=true, showEdgeNumber=true); # network is plotted & sent to file
R"dev.off()"; # wrap up and save image file
