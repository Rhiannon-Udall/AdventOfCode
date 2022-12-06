# define an in-place method for doing moves
function move!(source, destination, num_to_move)
    stack_to_move = []
    for ii in 1:num_to_move
        push!(stack_to_move, pop!(source))
    end
    stack_to_move = reverse(stack_to_move)
    append!(destination, stack_to_move)
end

open("input.txt","r") do f
    lines = read(f, String)
    boxes, moves = split(lines, "\n\n")
    boxes = split(String(boxes), '\n')
    # parse the boxes
    column_indices = findall(x->x in '1':'9', boxes[end])
    columns = [[] for ii in 1:9]
    for box_row in reverse(boxes[1:end-1])
       for (ii, column) in enumerate(columns)
            if box_row[only(column_indices[ii])] != ' '
                push!(column, box_row[only(column_indices[ii])])
            end
       end
    end
    println(columns)
    # parse the moves, take the move action
    moves = split(String(moves), '\n')
    for move in moves[1:end-1]
        move_elements = split(move, " ")
        num_to_move = parse(Int, move_elements[2])
        destination = columns[parse(Int, move_elements[6])]
        source = columns[parse(Int, move_elements[4])]
        move!(source, destination, num_to_move)
    end
    # Read off our output
    println(columns)
end