using Match
lines = readlines("input.txt")

direction_match(direction) = @match direction begin
    "L" => [-1, 0]
    "R" => [1, 0]
    "U" => [0, 1]
    "D" => [0, -1]
    x => parse(Int, x)
end

norm(array) = sqrt(sum(map(x->x*x, array)))

function evolve_state(head_state::Array, tail_state::Array, tail_history::Array, line::String)
    # head_state, tail_state are arrays of [x,y] starting from origin (0,0)
    # tail_history is an array containing all arrays of tail states (non-unique)
    # line is the line to parse
    increment, number = map(x->direction_match(x), split(line, " "))
    for ii in 1:number
        head_state += increment
        if norm(head_state-tail_state) > sqrt(2)
            tail_step = map(sign, head_state - tail_state)
            tail_state += tail_step
        end
        push!(tail_history, tail_state)
    end
    return head_state, tail_state, tail_history
end

head_state, tail_state, tail_history = [0, 2], [0, 0], []
for line in lines
    global head_state
    global tail_state
    global tail_history
    head_state, tail_state, tail_history = evolve_state(head_state, tail_state, tail_history, line)
end
println(length(unique(tail_history)))