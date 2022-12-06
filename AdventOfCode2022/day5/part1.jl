# define an in-place method for doing moves
function move!(source, destination)
    push!(destination, pop!(source))
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
        num_actions = parse(Int, move_elements[2])
        destination = columns[parse(Int, move_elements[6])]
        source = columns[parse(Int, move_elements[4])]
        for ii in 1:num_actions
            move!(source, destination)
        end
    end
    # Read off our output
    println(columns)
end