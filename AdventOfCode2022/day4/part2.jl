num_intersects = 0

for line in eachline("input.txt")
    global  num_intersects
    ranges = split(line, ",")
    range_1_array = split(ranges[1], "-")
    range_1 = parse(Int, range_1_array[1]):parse(Int, range_1_array[2])
    range_2_array = split(ranges[2], "-")
    range_2 = parse(Int, range_2_array[1]):parse(Int, range_2_array[2])
    if !isempty(collect(intersect(range_1, range_2)))
        num_intersects += 1
    end
end

println(num_intersects)