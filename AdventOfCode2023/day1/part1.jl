open("input.txt", "r") do f
    s = read(f, String)
    s_array = split(s, "\n")
    #new_array = []
    sum = 0
    for string in s_array
        clean_str = string
        print(clean_str)
        for (ii, named_number) in enumerate(["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"])
            clean_str = replace(clean_str, named_number=>ii)
        end
        print(clean_str)
        for letter in collect('a':'z')
            clean_str = replace(clean_str, letter=>"")
        end
        if clean_str != ""
            number_string = clean_str[1]*clean_str[end]
            number = parse(Int, number_string)
            sum += number
        end
        #push!(new_array, clean_str)
    end
    print(sum)
end


    