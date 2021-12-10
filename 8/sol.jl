using BenchmarkTools


function answer1(input = "input0")
    total = 0
    for line in readlines(input)
        code, output = split(line," | ")
        outputs = split(output," ")
        for i in [2,3,4,7]
            total += sum(sizeof.(outputs) .== i)
        end
    end
    total
end

@show answer1("input")

"I don't want to compare entire arrays, thus this function can give 9 or 3 with incorrect input"
function screen(decoded)
    if sum(decoded) == 2
        return 1
    elseif sum(decoded) == 3
        return 7
    elseif sum(decoded) == 4
        return 4
    elseif sum(decoded) == 7
        return 8
    elseif sum(decoded) == 5
        if decoded[2] == 1
            return 5
        elseif decoded[5] == 1
            return 2
        else 
            return 3
        end
    elseif sum(decoded) == 6
        if decoded[4] == 0
            return 0
        elseif decoded[3] == 0
            return 6
        else
            return 9
        end
    end
    -1
end
"Takes vector and returns the corresponding array for input to screen."
function todecodedarray(vectortodecode::Vector{Char})
    answer = zeros(Int, 7)
    indexes = Int.(vectortodecode .- 96)
    answer[indexes] .= 1
    answer
end

"Clearly not the most elegant way. I solved it on paper and then translated the operations to Julia.
it is probably easier to keep operating until you have isolated all the numbers, but I got first the
function relating the mixed up input with the actual input"
function answer2(input="input0")
    i = 1
    total = 0
    for line in readlines(input)
        key = repeat(['.'],7)
        real_key = ['a','b','c','d','e','f','g']
        code, output = split(line," | ")
        outputs = split(output," ")
        codes = split.(code," ")
        s1 = only.(split(codes[length.(codes) .== 2][1], ""))
        s3 = [""]
        s4 = only.(split(codes[length.(codes) .== 4][1], ""))
        s6 = [""]
        s7 = only.(split(codes[length.(codes) .== 3][1], ""))
        s8 = only.(split(codes[length.(codes) .== 7][1], ""))
        
        key[1] = setdiff(s7,s1)[1]
        codes6 = codes[length.(codes) .== 6]
        for i in eachindex(codes6)
            next = mod((i+1),3) + 1
            prev = mod((i+2),3) + 1
            i = mod(i,3) + 1
            code = codes6[i]
            compare = setdiff(s8,only.(split(code, "")))
            if length( compare ) == 1 && compare[1] ∈ s1
                key[3] = compare[1]
                key[6] = setdiff(s1,compare)[1]
                s6 = split(code, "")
                codes6 = [codes6[next],codes6[prev]]
                code
                break
            end
        end
        codes5 = codes[length.(codes) .== 5]
        
        for i in eachindex(codes5)
            next = mod((i+1),3) + 1
            prev = mod((i+2),3) + 1
            i = mod(i,3) + 1
            codes5[i],codes5[next],codes5[prev]
            joined = union(setdiff(codes5[i],codes5[next]),setdiff(codes5[i],codes5[prev]))
            if sum(in(joined).(s1)) == 2
                s3 = codes5[i]
                codes5 = [codes5[next],codes5[prev]]
                break
            end
        end
        key[4] = setdiff(intersect(s3,s4),s1)[1]
        key[7] = setdiff(s3,key)[1]
        key[2] = setdiff(s4,key)[1]
        key[5] = setdiff(real_key,key)[1]
        decryptDict = Dict(key .=> real_key)
        decrypt(c) = decryptDict[c]
        for (i,encryptedNumber) in enumerate(outputs)
            total += screen(todecodedarray(map(decrypt,only.(split(encryptedNumber,""))))) * 10 ^(4-i)
        end
    end
    total
end

@show answer2("input")