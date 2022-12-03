using DataStructures
open("input.txt", "r") do f
    lines = split(read(f, String),"\n")
    properties_sum = 0
    lower_case = "abcdefghijklmnopqrstuvwxyz"
    upper_case = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    for ii in range(0, Int(length(lines) / 3)-1, step=1)
        first_elf = lines[3*ii+1]
        second_elf = lines[3*ii+2]
        third_elf = lines[3*ii+3]
        first_elf_set = OrderedSet(split(first_elf, ""))
        second_elf_set = OrderedSet(split(second_elf, ""))
        third_elf_set = OrderedSet(split(third_elf, ""))
        common_element = only(only(intersect(first_elf_set, second_elf_set, third_elf_set)))
        println(first_elf_set)
        println(second_elf_set)
        println(third_elf_set)
        println(common_element)
        if occursin(common_element, lower_case)
            properties_sum += findall(x->x==common_element, lower_case)[1]
        else
            properties_sum += 26 + findall(x->x==common_element, upper_case)[1]
        end
    # for line in lines
    #     if line != ""
    #         first_compartment = convert(String, line[1:convert(Int, length(line)/2)])
    #         second_compartment = convert(String, line[convert(Int, length(line)/2)+1:convert(Int, length(line))])
    #         first_compartment_set = OrderedSet(split(first_compartment, ""))
    #         second_compartment_set = OrderedSet(split(second_compartment, ""))
    #         common_element = only(intersect(first_compartment_set, second_compartment_set)[1])
    #         
    #     end
    end
    println(properties_sum)
end
