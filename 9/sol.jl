using BenchmarkTools
using DelimitedFiles


function chechNeighbors(array, position)
    x,y = size(array)
    x,y
    neighbors = []
    if position[1] == 1 && position[2] == 1
        neighbors = [[1,2],[2,1]]
        return (array[position...] < array[neighbors[1]...] && 
        array[position...] < array[neighbors[2]...])*(array[position...]+1)
    end
    if position[1] == 1 && position[2] == y
        neighbors = [[1,y-1],[2,y]]
        return (array[position...] < array[neighbors[1]...] && 
        array[position...] < array[neighbors[2]...])*(array[position...]+1)
    end
    if position[1] == x && position[2] == 1
        neighbors = [[x,2],[x-1,1]]
        return (array[position...] < array[neighbors[1]...] && 
        array[position...] < array[neighbors[2]...])*(array[position...]+1)
    end
    if position[1] == x && position[2] == y 
        neighbors = [[x-1,y],[x,y-1]]
        return (array[position...] < array[neighbors[1]...] && 
        array[position...] < array[neighbors[2]...])*(array[position...]+1)
    end
    if position[1] == 1
        neighbors = [[2,position[2]],[1,position[2]-1],[1,position[2]+1]]
        return (array[position...] < array[neighbors[1]...] && 
        array[position...] < array[neighbors[2]...] &&
        array[position...] < array[neighbors[3]...])*(array[position...]+1)
    end
    if position[1] == x
        neighbors = [[x-1,position[2]],[x,position[2]-1],[x,position[2]+1]]
        return (array[position...] < array[neighbors[1]...] && 
        array[position...] < array[neighbors[2]...] &&
        array[position...] < array[neighbors[3]...])*(array[position...]+1)
    end
    if position[2] == 1
        neighbors = [[position[1],2],[position[1]-1,1],[position[1]+1,1]]
        return (array[position...] < array[neighbors[1]...] && 
        array[position...] < array[neighbors[2]...] &&
        array[position...] < array[neighbors[3]...])*(array[position...]+1)
    end
    if position[2] == y
        neighbors = [[position[1],y-1],[position[1]-1,y],[position[1]+1,y]]
        return (array[position...] < array[neighbors[1]...] && 
        array[position...] < array[neighbors[2]...] &&
        array[position...] < array[neighbors[3]...])*(array[position...]+1)
    end
    neighbors = [[position[1]-1,position[2]],[position[1],position[2]-1],
                 [position[1]+1,position[2]],[position[1],position[2]+1]]
    return (array[position...] < array[neighbors[1]...] && 
    array[position...] < array[neighbors[2]...] &&
    array[position...] < array[neighbors[3]...] &&
    array[position...] < array[neighbors[4]...])*(array[position...]+1)
end

function answer1(input::String)
    elevations = vcat(map(x -> parse.(Int,x),split.(readlines(input),""))'...) #Easy way to read matrices without delimiters
    total = 0
    for i in 1:size(elevations,1)
        for j in 1:size(elevations,2)
        total += chechNeighbors(elevations,[i,j])
        end
    end
    total
end

@show answer1("input")

"Could have used circshift, but thought about it too late."
function calculateNeighbors(position, elevations)
    x,y = size(elevations)
    x,y
    neighbors = []
    if position[1] == 1 && position[2] == 1
        neighbors = [[1,2],[2,1]]
    elseif position[1] == 1 && position[2] == y
        neighbors = [[1,y-1],[2,y]]
    elseif position[1] == x && position[2] == 1
        neighbors = [[x,2],[x-1,1]]
    elseif position[1] == x && position[2] == y 
        neighbors = [[x-1,y],[x,y-1]]
    elseif position[1] == 1
        neighbors = [[2,position[2]],[1,position[2]-1],[1,position[2]+1]]
    elseif position[1] == x
        neighbors = [[x-1,position[2]],[x,position[2]-1],[x,position[2]+1]]
    elseif position[2] == 1
        neighbors = [[position[1],2],[position[1]-1,1],[position[1]+1,1]]
    elseif position[2] == y
        neighbors = [[position[1],y-1],[position[1]-1,y],[position[1]+1,y]]
    else
        neighbors = [[position[1]-1,position[2]],[position[1],position[2]-1],
                    [position[1]+1,position[2]],[position[1],position[2]+1]]
    end
    neighbors
end

"Recursive patching of the basins, this one should work regardless of the number of 
minima in each basin."
function whichBasinAmI!(history,toCheck,noBasins,elevations)
    total = 0
    if history[toCheck...] > 0
        return 0
    elseif elevations[toCheck...] == 9
        history[toCheck...] = 0
        return 0
    else 
        history[toCheck...] = noBasins
        total += 1
        for neighbor in calculateNeighbors(toCheck,elevations)
            total += whichBasinAmI!(history,neighbor,noBasins,elevations)
        end
        return total
    end
end

"Since there is at least one minimum in each basin, this works fine."
function answer2(input::String,returnBasins=false)
    elevations = vcat(map(x -> parse.(Int,x),split.(readlines(input),""))'...) #Easy way to read matrices without delimiters
    lowest_points = []
    basins = zeros(size(elevations)) .-1
    #Finds the minimum of each basin.
    for i in 1:size(elevations,1)
        for j in 1:size(elevations,2)
            if chechNeighbors(elevations,[i,j]) > 0
                append!(lowest_points,[[i,j]])
            end
        end
    end
    basinSizes = zeros(size(lowest_points))
    #Uses the basins as starting points to do BFS with the 9 as walls.
    for (i,position) in enumerate(lowest_points)
        basinSizes[i] = whichBasinAmI!(basins,position,i,elevations)
    end
    answer = Int(prod(partialsort(basinSizes,1:3,rev=true)))
    if returnBasins
        return basins, answer
    end
    answer
end


@show answer2("input")

# Uncomment to plot the basins.
# using Plots
# gr()
# heatmap(answer2("input",true)[1], yflip = true)
