using BenchmarkTools


function answer1(input = "input0")
    numtotal = 0
    for line in readlines(input)
        line = split.(line,"")
        last_opened = 5
        opened = []
        for character in line
            if character == "("
                last_opened = 1
                append!(opened,1)
            elseif character == "["
                last_opened = 2
                append!(opened,2)
            elseif character == "{"
                last_opened = 3
                append!(opened,3)
            elseif character == "<"
                last_opened = 4
                append!(opened,4)
            elseif character == ")"
                if opened[end] != 1
                    numtotal +=3
                    break
                else
                    pop!(opened)
                end
            elseif character == "]"
                if opened[end] != 2
                    numtotal +=57
                    break
                else
                    pop!(opened)
                end
            elseif character == "}"
                if opened[end] != 3
                    numtotal +=1197
                    break
                else
                    pop!(opened)
                end
            elseif character == ">"
                if opened[end] != 4
                    numtotal +=25137
                    break
                else
                    pop!(opened)
                end
            end
        end
    end
    numtotal
end
@show answer1("input")

using Statistics

function answer2(input = "input0")
    numtotal = 0
    autocomplete_score = []
    for line in readlines(input)
        line = split.(line,"")
        last_opened = 5
        opened = []
        line_autocomplete_score = 0
        corrupted = false
        for character in line
            if character == "("
                last_opened = 1
                append!(opened,1)
            elseif character == "["
                last_opened = 2
                append!(opened,2)
            elseif character == "{"
                last_opened = 3
                append!(opened,3)
            elseif character == "<"
                last_opened = 4
                append!(opened,4)
            elseif character == ")"
                if opened[end] != 1
                    numtotal +=3
                    corrupted = true
                    break
                else
                    pop!(opened)
                end
            elseif character == "]"
                if opened[end] != 2
                    numtotal +=57
                    corrupted = true
                    break
                else
                    pop!(opened)
                end
            elseif character == "}"
                if opened[end] != 3
                    numtotal +=1197
                    corrupted = true
                    break
                else
                    pop!(opened)
                end
            elseif character == ">"
                if opened[end] != 4
                    numtotal +=25137
                    corrupted = true
                    break
                else
                    pop!(opened)
                end
            end
        end
        if !corrupted
            for missing_character in reverse(opened)
                # @show missing_character
                line_autocomplete_score = line_autocomplete_score*5 + missing_character
            end
        append!(autocomplete_score, line_autocomplete_score)
        end
    end
    Int(median(autocomplete_score))
end


@show answer2("input")