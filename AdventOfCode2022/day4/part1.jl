num_subsets = 0

for line in eachline("input.txt")
    global  num_subsets
    ranges = split(line, ",")
    range_1_array = split(ranges[1], "-")
    range_1 = parse(Int, range_1_array[1]):parse(Int, range_1_array[2])
    range_2_array = split(ranges[2], "-")
    range_2 = parse(Int, range_2_array[1]):parse(Int, range_2_array[2])
    println("--------")
    println(intersect(range_1, range_2))
    if intersect(range_1, range_2) == range_1
        num_subsets += 1
        println(range_1)
    elseif intersect(range_1, range_2) == range_2
        num_subsets += 1
        println(range_2)
    end 
end

println(num_subsets)