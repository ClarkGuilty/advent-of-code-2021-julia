function answer1()
    former = -1
    ans = -1
    open("input") do file
        for line in eachline(file)
            # println(line, " ", ans)
            actual = parse(Int,line)
            if actual > former
                ans += 1
            end
            former = actual
        end
    end
    ans
end
@show answer1()

using DelimitedFiles
using Statistics
"This time is better to simply load the numbers into an array"
function answer2()
    former = -1
    ans = -1
    input = readdlm("input", Int)
    for i in eachindex(input[1:end-2])
        actual = mean(input[i:i+2])
        if actual > former
            ans += 1
        end
        former = actual
    end
    ans
end
@show answer2()