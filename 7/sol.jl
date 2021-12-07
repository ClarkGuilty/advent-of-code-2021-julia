using StatsBase
using Statistics

function fuel2pos(positions,finalposition)
    sum(abs.(positions .- finalposition))
end
function answer1()
    input = "input"
    crap_positions0 = parse.(Int,split(readline(input),","))
    test_final_position = median(crap_positions0)
    println("range: ", minimum(crap_positions0)," - ", maximum(crap_positions0))
    min = Inf
    minpos = -1
    for pos in minimum(crap_positions0):1:maximum(crap_positions0)
        distance = fuel2pos(crap_positions0,pos)
        if distance < min
            min = distance
            minpos = pos
        end
    end
    min
    # crap_positions0
end

@show answer1()

triangulardistance(n) = Int(n*(n+1)/2)
function fuel2pos2(positions,finalposition)
    sum(triangulardistance.(abs.(positions .- finalposition)))
end
function answer2()
    input = "input"
    crap_positions0 = parse.(Int,split(readline(input),","))
    println("range: ", minimum(crap_positions0)," - ", maximum(crap_positions0))
    min = Inf
    minpos = -1
    for pos in minimum(crap_positions0):1:maximum(crap_positions0)
        distance = fuel2pos2(crap_positions0,pos)
        if distance < min
            min = distance
            minpos = pos
        end
    end
    min
    # crap_positions0
end

@show answer2()