lines = readlines("input.txt")


red_threshold = 12
green_threshold = 13
blue_threshold = 14

sum = 0
for (ii, game) in enumerate(lines)
    rounds = split(split(game, ":")[end], ";")
    possible = true
    for round in rounds
        elements = split(round, " ")
        print(elements)
        print("\n")
        for (jj, element) in enumerate(elements)
            if strip(element, ',') == "blue"
                precursor = parse(Int, elements[jj-1])
                if precursor > blue_threshold
                    possible = false
                    print("blue fail\n")
                end
            elseif strip(element, ',') == "red"
                precursor = parse(Int, elements[jj-1])
                if precursor > red_threshold
                    possible = false
                    print("red fail\n")
                end
            elseif strip(element, ',') == "green"
                precursor = parse(Int, elements[jj-1])
                if precursor > green_threshold
                    possible = false
                    print("green fail\n")
                end
            end
        end
    end
    if possible
        global sum += ii
    end
end
print(sum)