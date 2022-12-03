open("input.txt", "r") do f
    s = read(f, String)
    rounds = split(s, "\n")
    #println(rounds)
    my_points = 0
    cycle = "ABCABC"
    wintieloss = "ZYX"
    cycling_map = Dict(1=>6, 2=>3, 3=>0)
    for round in rounds
        if round != ""
            elf_throw = findall(x->x==round[1], cycle)[1]
            cycling_index = findall(x->x==round[3], wintieloss)[1]
            response = findall(x->x==cycle[mod(elf_throw-cycling_index, 3)+2], cycle)[1]
            my_points += response
            my_points += cycling_map[cycling_index]
            println(response)
            println(cycling_map[cycling_index])
        end
    end
    println(my_points)
end