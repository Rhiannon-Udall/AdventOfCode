lines = readlines("input.txt")

function parseline(line::String)
    numbers = split(line, ':')[2]
    winning_numbers_string, your_numbers_string = split(numbers, '|')
    winning_numbers = [parse(Int, number_string) for number_string in split(strip(replace(winning_numbers_string, "  "=>" "), ' '), ' ')]
    your_numbers = [parse(Int, number_string) for number_string in split(strip(replace(your_numbers_string, "  "=>" "), ' '), ' ')]
    return (winning_numbers, your_numbers)
end

sum = 0
for line in lines
    winning_numbers, your_numbers = parseline(line)
    winning_set = Set(winning_numbers)
    your_set = Set(your_numbers)
    your_winning = intersect(winning_set, your_set)
    if length(your_winning) != 0
        global sum += 2^(length(your_winning)-1)
    end
end

println(sum)