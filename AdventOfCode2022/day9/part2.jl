using Match
lines = readlines("input.txt")

direction_match(direction) = @match direction begin
    "L" => [-1, 0]
    "R" => [1, 0]
    "U" => [0, 1]
    "D" => [0, -1]
    x => parse(Int, x)
end

function evolve_tail(head_state, tail_state)
    if norm(head_state-tail_state) > sqrt(2)
        tail_step = map(sign, head_state - tail_state)
        tail_state += tail_step
    end
    return tail_state
end

norm(array) = sqrt(sum(map(x->x*x, array)))

function evolve_state(head_state::Array, tail_states::Array, tail_histories::Array, line::String)
    # head_state, tail_state are arrays of [x,y] starting from origin (0,0)
    # tail_history is an array containing all arrays of tail states (non-unique)
    # line is the line to parse
    increment, number = map(x->direction_match(x), split(line, " "))
    for ii in 1:number
        head_state += increment
        for (jj, tail_state) in enumerate(tail_states)
            if jj == 1
                current_head = head_state
            else 
                current_head = tail_states[jj - 1]
            end
            tail_state = evolve_tail(current_head, tail_state)
            tail_states[jj] = tail_state
            push!(tail_histories[jj], tail_state)
        end
    end
    return head_state, tail_states, tail_histories
end

head_state = [0, 0]
tail_states = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]]
tail_histories = [[], [], [], [] ,[], [], [], [], []]
for line in lines
    global head_state
    global tail_states
    global tail_histories
    head_state, tail_states, tail_histories = evolve_state(head_state, tail_states, tail_histories, line)
end

print(length(unique(tail_histories[9])))