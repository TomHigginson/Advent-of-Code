using CSV
using DataFrames

# Note to self - might be worth trying this in python at some point. For now I will use julia as I have heard it can make this trivial.

# For part 2 the checked function will be identical.
# I have merged them together and taken out the function to determine the middle value

# Create the set of rules

function rule(order::String)
    rules = []
    open(order, "r") do file
        for line in eachline(file)
            a, b = split(line, "|")
            push!(rules, (parse(Int, strip(a)), parse(Int, strip(b))))
        end
    end
    return rules
end

# Read the set of updates

function updates(update::String)
    lists = []
    open(update, "r") do file
        for line in eachline(file)
            push!(lists, parse.(Int, split(strip(line), ",")))
        end
    end
    return lists
    
end

# Finds the midpoint value of a given list

function midpoint(list::Vector{Int})
    listlength=length(list)
    midvalue = Int(ceil((listlength+1) / 2))
    return list[midvalue]
end

# Apply the rules

function check(order::String, update::String)

    NewLists = []
    FixedLists = []
    sum = 0
    fixed_sum = 0


    # read rules and updates
    rules = rule(order)
    lists = updates(update)
    
    for j in lists
        for i in length(j)
            passed = true
            fixed = copy(j)
            
            for (x,y) in rules
                x_pos = findfirst(==(x), fixed)
                y_pos = findfirst(==(y), fixed)

                # Check if both are present 
                if !isnothing(x_pos) && !isnothing(y_pos) && x_pos > y_pos
                    passed = false

                    # This is only for part 2 
                    deleteat!(fixed, y_pos)
                    insert!(fixed, x_pos, y)
                end
            end

            if passed === true
                mid = midpoint(fixed)
                sum += mid
                push!(NewLists, fixed)

            else 
                mid = midpoint(fixed)
                fixed_sum += mid
                push!(FixedLists, fixed)
            end
        end
    end

    return NewLists,sum,FixedLists,fixed_sum
end

################################################################################
################################################################################
################################################################################


rules_list = "Intrsuction.txt"
updates_list = "Updates.csv"

NewList,sum,FixedLists,Fixed_sum = check(rules_list,updates_list)

print("The answer for part 1: ", sum)
print("The answer for part 2: ",test1)
