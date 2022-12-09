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

for ii in 1:size(observation_array)[1]
    left_max = -1
    right_max = -1
    for jj in 1:size(observation_array)[2]
        if trees_array[ii, jj] > left_max
            observation_array[ii, jj] = 1
            left_max = trees_array[ii, jj]
        end
        if trees_array[ii, end-jj+1] > right_max
            observation_array[ii, end-jj+1] = 1
            right_max = trees_array[ii, end-jj+1]
        end
    end
end

for ii in 1:size(observation_array)[2]
    top_max = -1
    bottom_max = -1
    for jj in 1:size(observation_array)[1]
        if trees_array[jj, ii] > top_max
            observation_array[jj, ii] = 1
            top_max = trees_array[jj, ii]
        end
        if trees_array[end-jj+1, ii] > bottom_max
            observation_array[end-jj+1, ii] = 1
            bottom_max = trees_array[end-jj+1, ii]
        end
    end
end

println(sum(observation_array))