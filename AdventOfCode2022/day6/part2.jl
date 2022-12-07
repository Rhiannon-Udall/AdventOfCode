open("input.txt", "r") do f
    message = read(f, String)
    for ii in 1:length(message) - 14
        tag = message[ii:ii+13]
        if join(unique(tag)) == tag
            println(ii+13)
            break
        end
    end
end