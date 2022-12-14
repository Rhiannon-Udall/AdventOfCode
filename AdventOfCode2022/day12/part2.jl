using Graphs
using Match

# Get an appropriate 2d array of strings
map_array = hcat(map(x->split(String(x), ""), split(open(f->read(f, String), "input.txt")))...)

topological_graph = SimpleDiGraph(length(map_array), 0)

# Cartesian indices proceeds top->bottom left->right
# So we should track our vertices accordingly
get_vertex_number = x -> (x[2] - 1) * size(map_array)[1] + x[1]
start_index = findfirst(x->x=="S", map_array)
end_index = findfirst(x->x=="E", map_array)

current_elevation(character) = @match character begin
    "S" => 97
    "E" => 122
    x => Int(only(x))
end

for ii in CartesianIndices(map_array)
    global topological_graph
    center_vertex_number = get_vertex_number(ii)
    # Dealing with edge effects lazily
    for jj in CartesianIndices(map_array)
        if (((abs(ii[1] - jj[1]) == 1 && abs(ii[2] - jj[2]) == 0 ) ||
            (abs(ii[1] - jj[1]) == 0 && abs(ii[2] - jj[2]) == 1 )) &&
            ((current_elevation(map_array[jj]) - current_elevation(map_array[ii])) <= 1))
            add_edge!(topological_graph, center_vertex_number, get_vertex_number(jj))
        end
    end
end

a_distances = []

for aa in findall(x->x=="a", map_array)
    distances = dijkstra_shortest_paths(topological_graph, [get_vertex_number(aa)]).dists
    distances = reshape(distances, size(map_array)...)
    distance_to_end = distances[end_index]
    push!(a_distances, distance_to_end)
end

println(minimum(a_distances))
