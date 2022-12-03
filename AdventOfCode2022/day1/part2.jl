open("part1input.txt", "r") do f
    s = read(f, String)
    splits = split(replace(replace(s, "\n\n" => ";"), "\n" => " "), ";")
    elf_calories = []
    for (ii, elf_items) in enumerate(splits)
        this_elf_calories = 0
        items = split(elf_items)
        for item in items
            val = parse(Int, item)
            this_elf_calories += val
        end
        push!(elf_calories, this_elf_calories)
    end
    sort!(elf_calories, rev=true)
    print(elf_calories)
    print("\n")
    print(sum(elf_calories[1:3]))
end

