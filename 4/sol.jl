using DelimitedFiles
using StatsBase

"returns the index of the winner, or -1 in case there is no winner."
function winner(marked)
    for k in 1:1:size(marked,3)
        board = view(marked,:,:,k)
        for col in eachcol(board)
            if sum(col) == 5
                return k
            end
        end
        for row in eachrow(board)
            if sum(row) == 5
                return k
            end
        end
    end
    return -1
end
function answer1()
    input = "input"
    cardboards = permutedims((reshape(readdlm(input,Int,skipstart=2)', 5,5,:)),[2,1,3])
    ballots = parse.(Int,split(readline(input),","))
    marked = zeros(size(cardboards))

    for ballot in ballots
        marked .+= (cardboards .== ballot)
        first_winner = winner(marked)
        if first_winner > 0
            # @show first_winner, ballot
            # sum(-1 .* (marked[:,:,first_winner] .- 1) .* cardboards[:,:,first_winner])*ballot
            return Int(sum(-1 .* (marked[:,:,first_winner] .- 1) .* cardboards[:,:,first_winner])*ballot)
        end
    end
end
@show answer1()

"Returns a list of winners, [-1] if no new winners."
function winner(marked, candidates)
    # @show candidates
    winners = []
    for k in candidates
        board = view(marked,:,:,k)
        for col in eachcol(board)
            if sum(col) == 5
                append!(winners,k)
            end
        end
        for row in eachrow(board)
            if sum(row) == 5
                append!(winners,k)
            end
        end
    end
    if size(winners,1)>0
        return unique(winners)
    end
    return [-1]
end
function answer2()
    input = "input"
    cardboards = permutedims((reshape(readdlm(input,Int,skipstart=2)', 5,5,:)),[2,1,3])
    ballots = parse.(Int,split(readline(input),","))
    marked = zeros(size(cardboards))
    winners = ones(size(cardboards,3))
    candidates = collect(1:1:size(winners,1))[winners .== 1]
    last_winner = 0
    points_until_won = 0
    for ballot in ballots
        marked .+= (cardboards .== ballot)
        first_winner = winner(marked,candidates)
        for first_winner in winner(marked,candidates)
            if first_winner != -1
                winners[first_winner] = 0
                candidates = collect(1:1:size(winners,1))[winners .== 1]
            end
            if first_winner > 0 && first_winner != last_winner
                last_winner = first_winner
                points_until_won = Int(sum(-1 .* (marked[:,:,last_winner] .- 1) .* cardboards[:,:,last_winner])*ballot)
            end
        end
    end
    return points_until_won
end
@show answer2()
