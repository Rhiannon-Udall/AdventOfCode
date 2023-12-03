lines = readlines("input.txt")


red_threshold = 12
green_threshold = 13
blue_threshold = 14

sum = 0
for (ii, game) in enumerate(lines)
    rounds = split(split(game, ":")[end], ";")
    blue_minimum = 1
    red_minimum = 1
    green_minimum = 1
    for round in rounds
        elements = split(round, " ")
        for (jj, element) in enumerate(elements)
            if strip(element, ',') == "blue"
                precursor = parse(Int, elements[jj-1])
                blue_minimum = max(blue_minimum, precursor)
            elseif strip(element, ',') == "red"
                precursor = parse(Int, elements[jj-1])
                red_minimum = max(red_minimum, precursor)
            elseif strip(element, ',') == "green"
                precursor = parse(Int, elements[jj-1])
                green_minimum = max(green_minimum, precursor)
            end
        end
    end
    powerset = blue_minimum * red_minimum * green_minimum
    global sum += powerset
end
print(sum)