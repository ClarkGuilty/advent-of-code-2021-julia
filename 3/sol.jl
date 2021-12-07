using DelimitedFiles
using StatsBase

function to_decimal(binary_array)
    to_dec = collect(range(size(binary_array,1)-1,0,size(binary_array,1)))
    Int(sum(binary_array .*  2 .^to_dec))
end

function answer1()
    input = readdlm("input", String)
    
    data = split.(input,"")
    data = map(x->parse.(Int,x), data)
    data = hcat(data...)
    data
    mode(test)
    data = [data[i,:] for i in 1:size(data,1)]
    data = mode.(data)
    γrate = to_decimal(data)
    ϵrate = to_decimal(-1 .* (data .- 1))
    γrate, ϵrate, γrate * ϵrate
end
@show answer1()

using Statistics
function answer2()
    input = readdlm("input", String)
    input_in_use = copy(input)
    ninput = map(x->parse.(Int,x), input)
    
    i=0
    while size(input_in_use,1) > 1
        i += 1
        data_in_use = split.(input_in_use,"")
        data_in_use = map(x->parse.(Int,x), data_in_use)
        data_in_use = hcat(data_in_use...)
        data_in_use = data_in_use[i,:]
        # @show data_in_use
        # @show median(data_in_use)
        ninput = map(x->parse.(Int,x), input_in_use)
        if median(data_in_use) > 0
            ii = permutedims(hcat(split.(input_in_use, "")...))[: , i] .== "1"
        else
            ii = permutedims(hcat(split.(input_in_use, "")...))[: , i] .== "0"
        end
        # @show ii
        input_in_use = input_in_use[ii]
    end
    O2_rating = to_decimal(map(x->parse.(Int,x), split(input_in_use[1],"")))

    input_in_use = copy(input)
    ninput = map(x->parse.(Int,x), input)
    i=0
    while size(input_in_use,1) > 1
        i += 1
        data_in_use = split.(input_in_use,"")
        data_in_use = map(x->parse.(Int,x), data_in_use)
        data_in_use = hcat(data_in_use...)
        data_in_use = data_in_use[i,:]
        # @show data_in_use
        # @show median(data_in_use)
        ninput = map(x->parse.(Int,x), input_in_use)
        if median(data_in_use) > 0
            # ii = ninput .>= 10^(size(data,1)-i)
            ii = permutedims(hcat(split.(input_in_use, "")...))[: , i] .== "0"
        else
            ii = permutedims(hcat(split.(input_in_use, "")...))[: , i] .== "1"
        end
        # @show ii
        input_in_use = input_in_use[ii]
    end
    CO2_rating = to_decimal(map(x->parse.(Int,x), split(input_in_use[1],"")))
    
    O2_rating, CO2_rating, O2_rating * CO2_rating
end
test = answer2()
permutedims(hcat(split.(test, "")...))[: , 2] .== "1"