using DataStructures
open("input.txt", "r") do f
    lines = split(read(f, String),"\n")
    properties_sum = 0
    lower_case = "abcdefghijklmnopqrstuvwxyz"
    upper_case = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    for line in lines
        if line != ""
            first_compartment = convert(String, line[1:convert(Int, length(line)/2)])
            second_compartment = convert(String, line[convert(Int, length(line)/2)+1:convert(Int, length(line))])
            first_compartment_set = OrderedSet(split(first_compartment, ""))
            second_compartment_set = OrderedSet(split(second_compartment, ""))
            common_element = only(intersect(first_compartment_set, second_compartment_set)[1])
            if occursin(common_element, lower_case)
                properties_sum += findall(x->x==common_element, lower_case)[1]
            else
                properties_sum += 26 + findall(x->x==common_element, upper_case)[1]
            end
        end
    end
    println(properties_sum)
end