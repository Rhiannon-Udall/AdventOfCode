open("input.txt", "r") do f
    message = read(f, String)
    for ii in 1:length(message) - 4
        tag = message[ii:ii+3]
        if join(unique(tag)) == tag
            println(ii+3)
            break
        end
    end
end