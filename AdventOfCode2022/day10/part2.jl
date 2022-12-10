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

screen = Array{String, 2}(undef, 6, 40)

for (ii, x) in enumerate(cycle_history)
    cursor_position = mod(ii-1, 40)
    sprite_fill = [x-a for a in -1:1]
    if cursor_position in sprite_fill
        screen_value = "#"
    else
        screen_value = "."
    end
    screen[Int(floor((ii - 1) / 40))+1, mod(ii-1, 40)+1] = screen_value
end

display(screen)

