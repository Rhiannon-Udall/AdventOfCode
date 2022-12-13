function get_worry_function(operation_string)
    operation_elements = split(operation_string, " ")
    if operation_elements[4] == "+"
        add_to = parse(Int, operation_elements[5])
        return f = x -> x + add_to
    elseif operation_elements[4] == "*"
        if operation_elements[5] == "old"
            return f = x -> x * x
        else
            multiply_by = parse(Int, operation_elements[5])
            return f = x -> x * multiply_by
        end
    end
end

mutable struct Monkey
    monkey_number::Int
    worry_operation
    divisibility_condition
    pass_to_if_true::Int
    pass_to_if_false::Int
    number_inspected::Int
end

function parse_input(input_file)
    open(input_file, "r") do f
        items_array = Array{Int}(undef, 0, 2)
        # items_array will have two column:
        # 1st is worry level
        # 2nd is monkey currently in posession
        s = read(f, String)
        monkeys = split(s, "\n\n")
        monkey_array = []
        for monkey in monkeys
            elements = split(String(monkey), "\n")

            # Get the monkey we are dealing with
            monkey_number = parse(Int, strip(String(split(elements[1], " ")[2]), [':']))

            # Get the worry levels of the items it starts with
            starting_items = map(x-> parse(Int, strip(String(x), [','])), split(String(elements[2]), " ")[5:end])
            for item in starting_items
                temp_array = [item monkey_number]
                items_array = vcat(items_array, temp_array)
            end

            # Next we need to deduce the operation
            relation_string = strip(String(split(elements[3], ":")[2]), [' '])
            worry_function = get_worry_function(relation_string)

            # Now get the conditional operation
            # They are all "divisble by" so cut to the chase
            divisibility_number = parse(Int, split(elements[4], " ")[end])
            divisibility_check = x -> mod(x, divisibility_number) == 0

            # Get which monkey this monkey will throw to in true/false cases
            target_if_true = parse(Int, split(elements[5], " ")[end])            
            target_if_false = parse(Int, split(elements[6], " ")[end])      

            monkey = Monkey(monkey_number, worry_function, divisibility_check, target_if_true, target_if_false, 0)
            push!(monkey_array, monkey)
        end
        return items_array, monkey_array
    end
end

function play_a_round(items_array, monkey_array)
    for monkey in monkey_array
        monkey_number = monkey.monkey_number
        items_in_this_monkeys_inventory = findall(items_array[:, 2] .== monkey_number)
        for item_index in items_in_this_monkeys_inventory
            worry = items_array[item_index, 1]
            new_worry = monkey.worry_operation(worry)
            new_worry = floor(new_worry / 3)
            items_array[item_index, 1] = new_worry
            if monkey.divisibility_condition(new_worry)
                items_array[item_index, 2] = monkey.pass_to_if_true
            else
                items_array[item_index, 2] = monkey.pass_to_if_false
            end
            monkey.number_inspected += 1
        end
    end
end

items_array, monkey_array = parse_input("testcase.txt")
for ii in 1:20
    play_a_round(items_array, monkey_array)
end

for monkey in monkey_array
    println(monkey.number_inspected)
end