open("input.txt", "r") do f
    s = read(f, String)
    s_array = split(s, "\n")
    sum = 0
    for string in s_array
        clean_str = ""
        print(string * "\n")
        for ii in 1:length(string)
            clean_str = clean_str * string[ii]
            for (jj, named_number) in enumerate(["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"])
                clean_str = replace(clean_str, named_number=>jj)
                if isdigit(clean_str[end])
                    clean_str = clean_str * named_number[2:end]
                end
            end
        end
        print(clean_str * "\n")
        for letter in collect('a':'z')
            clean_str = replace(clean_str, letter=>"")
        end
        print(clean_str * "\n")
        if clean_str != ""
            number_string = clean_str[1]*clean_str[end]
            print(number_string * "\n")
            number = parse(Int, number_string)
            sum += number
        end
    end
    print(sum)
end


    