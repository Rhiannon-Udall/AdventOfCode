lines = readlines("input.txt")

current_x = 1
cycle_history = []
for line in lines
    global current_x
    global cycle_history
    if occursin("noop", line)
        append!(cycle_history, fill(current_x, 1))
    else
        append!(cycle_history, fill(current_x, 2))
        current_x += parse(Int, split(line, " ")[2])
    end
end

signal_weights = (map(ii-> ii * cycle_history[ii], [20 + 40 * x for x in 0:5]))
println(sum(signal_weights))