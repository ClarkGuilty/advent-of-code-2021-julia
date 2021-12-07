using DelimitedFiles
using StatsBase

function answer1()
    input = "input"
    initial_fish = parse.(Int,split(readline(input),","))
    fishes_now = copy(initial_fish)
    new_to_add = 0
    for day in 1:80
        # @show fishes_now
        new_to_add = 0
        for i in  eachindex(fishes_now)
            if fishes_now[i] == 0
                new_to_add +=1
                fishes_now[i] = 6
            else
                fishes_now[i] -=1
            end
        end
        append!(fishes_now, repeat([8],new_to_add))
    end
    fishes_now
end

@show answer1()

"Do not try to bruteforce part 2..."
function answer2()
    input = "input"
    initial_fish = parse.(Int,split(readline(input),","))
    fishes_now = zeros(Int,9)
    days = 256
    for fish in initial_fish
        fishes_now[fish+1] += 1
    end
    for day in 1:1:days
        fishes_to_add = fishes_now[1]
        for i in 2:1:9
            fishes_now[i-1] = copy(fishes_now[i])
        end
        fishes_now[7] += fishes_to_add
        fishes_now[9] = fishes_to_add
    end
    sum(fishes_now)
end

@show answer2()

