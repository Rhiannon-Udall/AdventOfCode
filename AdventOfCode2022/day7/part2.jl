lines = readlines("input.txt")
using JSON

function get_working_directory_by_absolute_path(directory_structure, absolute_path)
    current_working_directory = directory_structure
    path_elements = split(absolute_path, "/")
    for path_element in path_elements[2:end]
        current_working_directory = current_working_directory[path_element]
    end
    return current_working_directory
end

function serial_parse_input(lines)
    directory_structure = Dict()
    current_working_directory = directory_structure
    current_absolute_path = ""
    for line in lines[2:end]
        if line == "\$ cd .."
            current_absolute_path = join(split(current_absolute_path, "/")[1:end-1], "/")
            current_working_directory = get_working_directory_by_absolute_path(directory_structure, current_absolute_path)
        elseif occursin("\$ cd", line)
            current_absolute_path = join([current_absolute_path, split(line, " ")[end]], "/")
            current_working_directory = get_working_directory_by_absolute_path(directory_structure, current_absolute_path)
        elseif !occursin("\$", line)
            file_descriptor, file_name = split(line, " ")
            if file_descriptor == "dir"
                merge!(current_working_directory, Dict(file_name=>Dict()))
            else
                merge!(current_working_directory, Dict(file_name=>parse(Int, file_descriptor)))
            end
        end
    end
    return directory_structure
end

function populate_size_element!(dir_dict)
    size = 0
    for value in values(dir_dict)
        if value isa Int
            size += value
        else
            size += populate_size_element!(value)
        end
    end
    merge!(dir_dict, Dict("size"=>size))
    return size
end

function get_list_of_sizes!(dir_name, dir_dict, list_of_sizes)
    for (key, value) in pairs(dir_dict)
        if key == "size" 
            push!(list_of_sizes, value)
        elseif value isa Dict
            get_list_of_sizes!(key, value, list_of_sizes)
        end
    end
end

directory_structure = serial_parse_input(lines)
populate_size_element!(directory_structure)
list_of_sizes = []
get_list_of_sizes!("/", directory_structure, list_of_sizes)
print(json(directory_structure, 4))

sort!(list_of_sizes, rev=true)
println(list_of_sizes)
current_space_available = 70000000 - list_of_sizes[1]
println(current_space_available)
space_to_clear = 30000000 - current_space_available
println(space_to_clear)

for (ii, element) in enumerate(list_of_sizes)
    if list_of_sizes[ii+1] <= space_to_clear
        println(element)
        break
    end
end
