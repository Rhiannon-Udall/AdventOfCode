lines = readlines("input.txt")

function number_from_line(line, initial_index)
    current_left = initial_index
    current_right = initial_index
    while current_left > 1 && isdigit(line[current_left-1])
        current_left -= 1
    end
    while current_right < length(line) && isdigit(line[current_right+1])
        current_right += 1
    end
    value = parse(Int, line[current_left:current_right])
    line = line[1:current_left-1] * '.'^(current_right-current_left+1) * line[current_right+1:end]
    return value, line
end

sum = 0
for ii in eachindex(lines)
    for jj in eachindex(lines[ii])
        if lines[ii][jj] == '*'
            values = []
            backup = copy(lines)
            for kk in -1:1
                for ll in -1:1
                    if isdigit(lines[ii+kk][jj+ll])
                        value, line = number_from_line(lines[ii+kk], jj+ll)
                        lines[ii+kk] = line
                        push!(values, value)
                    end
                end
            end
            global lines = backup
            if length(values) == 2
                global sum += values[1] * values[2]
            end
        end
    end
end