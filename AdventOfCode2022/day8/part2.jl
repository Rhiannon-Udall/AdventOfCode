lines = readlines("input.txt")
trees_array = []

for line in lines
    row_array = []
    for tree in split(line, "")
        push!(row_array, parse(Int, tree))
    end
    push!(trees_array, row_array)
end

# some stack exchange shit
trees_array = permutedims(reshape(hcat(trees_array...), (length(trees_array[1]), length(trees_array))))

observation_array = zeros(size(trees_array))

#for ii in 2:size(observation_array)[1]-1
#    for jj in 2:size(observation_array)[2]-1
for ii in 1:size(observation_array)[1]
    for jj in 1 : size(observation_array)[2]
        tree_height = trees_array[ii, jj]
        left_blocking = findall(x->x>=tree_height, trees_array[ii, 1:jj-1])
        if !isempty(left_blocking)
            number_left = jj - left_blocking[end]
        else
            number_left = jj - 1
        end
        right_blocking = findall(x->x>=tree_height, trees_array[ii, jj+1:end])
        if !isempty(right_blocking)
            number_right = right_blocking[1]
        else
            number_right = size(observation_array)[2] - jj
        end
        top_blocking = findall(x->x>=tree_height, trees_array[1:ii-1, jj])
        if !isempty(top_blocking)
            number_top = ii - top_blocking[end]
        else
            number_top = ii - 1
        end
        bottom_blocking = findall(x->x>=tree_height, trees_array[ii+1:end, jj])
        if !isempty(bottom_blocking)
            number_bottom = bottom_blocking[1]
        else 
            number_bottom = size(observation_array)[1] - ii
        end
        observation_array[ii, jj] = number_top * number_left * number_bottom * number_right
    end
end

print(maximum(observation_array))