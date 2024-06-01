lines = readlines("input.txt")

function parseline(line::String)
    numbers = split(line, ':')[2]
    game_number = split(line, ':'[1][end])
    winning_numbers_string, your_numbers_string = split(numbers, '|')
    winning_numbers = [parse(Int, number_string) for number_string in split(strip(replace(winning_numbers_string, "  "=>" "), ' '), ' ')]
    your_numbers = [parse(Int, number_string) for number_string in split(strip(replace(your_numbers_string, "  "=>" "), ' '), ' ')]
    return (game_number, winning_numbers, your_numbers)
end

global card_count = ones(length(lines))
for (ii, line) in enumerate(lines)
    game_number, winning_numbers, your_numbers = parseline(line)
    winning_set = Set(winning_numbers)
    your_set = Set(your_numbers)
    num_winning = length(intersect(winning_set, your_set))
    if num_winning > 0
        card_count[ii + 1 : min(ii + num_winning, end)] .+= card_count[ii]
    end
end

println(sum(card_count))