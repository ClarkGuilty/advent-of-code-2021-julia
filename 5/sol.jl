using DelimitedFiles
using StatsBase

function smartrange(start,stop)
    if(start>stop)
        return start:-1:stop
    end
    return start:1:stop
end
function answer1()
    input = "input"
    po,pf = 0,0
    borderSizex = -1
    borderSizey = -1
    points0 = 0
    for line in readlines(input)
        points = split(line," -> ")
        points = split.(points,",")
        points = map(x->parse.(Int,x), points)
        points = hcat(points...)
        if borderSizex < maximum(view(points,1,:))
            borderSizex = maximum(view(points,1,:))
        end
        if borderSizey < maximum(view(points,2,:))
            borderSizey = maximum(view(points,2,:))
        end
    end
    board = zeros(Int,borderSizex+1,borderSizey+1)
    for line in readlines(input)
        points = split(line," -> ")
        points = split.(points,",")
        points = map(x->parse.(Int,x), points)
        points = hcat(points...)
        points0 = copy(points)
        points = points .+ 1
        if size(unique(view(points,1,:)),1) == 1 #|| size(unique(view(points,2,:)),1) == 1
            # println(view(points,:,1))
            x = view(points,1,:)[1]
            # board[view(points,:,1)] .+= 1
            for y in smartrange(view(points,:,1)[2], view(points,:,2)[2])
                board[x,y] +=1
            end
        end
        if size(unique(view(points,2,:)),1) == 1
            # println(view(points,:,1))
            y = points[2,1]
            # board[view(points,:,1)] .+= 1
            println("x: ", view(points,:,1)[1]-1,"-", view(points,:,2)[1]-1,", y: ",y-1)
            @show points
            for x in smartrange(view(points,:,1)[1], view(points,:,2)[1])
                board[x,y] +=1
            end
        end
    end
    # board
    sum(board .>= 2)
end
# test = answer1()
@show answer1()
# points .-= 1
# sum(test .>= 2)
# show(stdout, "text/plain", test)
function direction(xo,yo,xf,yf)
    dir = [0,0]
    if xf>xo
        dir[1] = 1
    elseif xf<xo
        dir[1] = -1
    end
    if yf>yo
        dir[2] = 1
    elseif yf<yo
        dir[2] = -1
    end
    dir
end
function answer2()
    input = "input"
    po,pf = 0,0
    borderSizex = -1
    borderSizey = -1
    points0 = 0
    for line in readlines(input)
        points = split(line," -> ")
        points = split.(points,",")
        points = map(x->parse.(Int,x), points)
        points = hcat(points...)
        if borderSizex < maximum(view(points,1,:))
            borderSizex = maximum(view(points,1,:))
        end
        if borderSizey < maximum(view(points,2,:))
            borderSizey = maximum(view(points,2,:))
        end
    end
    board = zeros(Int,borderSizex+1,borderSizey+1)
    for line in readlines(input)
        points = split(line," -> ")
        points = split.(points,",")
        points = map(x->parse.(Int,x), points)
        points = hcat(points...)
        points0 = copy(points)
        points = points .+ 1

        x = points[1,1]
        xf = points[1,2]
        y = points[2,1]
        yf = points[2,2]
        dir = direction(x,y,xf,yf)
        while x != xf || y != yf
            board[x,y] +=1
            x += dir[1]
            y += dir[2]
        end
        board[xf,yf] +=1
    end
    # board
    sum(board .>= 2)
end
test = answer2()
show(stdout, "text/plain", test')
sum(test .>= 2)

@show answer2()