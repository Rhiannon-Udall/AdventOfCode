open("input.txt", "r") do f
    s = read(f, String)
    rounds = split(s, "\n")
    #println(rounds)
    my_points = 0
    wins = ["A Y", "B Z", "C X"]
    losses = ["A Z", "B X", "C Y"]
    ties = ["A X", "B Y", "C Z"]
    case_values = Dict('X'=>1, 'Y'=>2, 'Z'=>3)
    for round in rounds
        if round in wins
            my_points += 6
        elseif round in ties
            my_points += 3
        elseif round in losses
        else
            continue
        end
        my_cast = getindex(round, 3)
        my_points += case_values[my_cast]
    end
    print(my_points)
end