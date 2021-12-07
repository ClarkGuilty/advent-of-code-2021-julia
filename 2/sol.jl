function answer1()
    h = 0
    v = 0
    open("input") do file
        for line in eachline(file)
            order = split(line)
            if order[1] == "forward"
                h += parse(Int, order[2])
            elseif order[1] == "up"
                v -= parse(Int, order[2])
            else
                v += parse(Int, order[2])
            end
        end
    end
    h, v, h*v
end
@show answer1()

function answer2()
    h = 0
    v = 0
    aim = 0
    open("input") do file
        for line in eachline(file)
            order = split(line)
            if order[1] == "down"
                aim += parse(Int, order[2])
            elseif order[1] == "up"
                aim -= parse(Int, order[2])
            else
                h += parse(Int, order[2])
                v += aim * parse(Int, order[2])
            end
        end
    end
    h, v, h*v
end
@show answer2()
