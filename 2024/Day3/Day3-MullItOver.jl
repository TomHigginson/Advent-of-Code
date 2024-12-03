
# It's day 3 and we need to now multiply some numbers

# Want to find any correctly noted multiplying function therefore:

function MultiplyFinderPART1(expression::String)

    # Defining a Regex for mul(x,y)
    want = r"mul\((-?\d+(\.\d+)?),(-?\d+(\.\d+)?)\)"
    mult = eachmatch(want, expression)

    results = []
    Sum = 0
    for i in mult
        x = parse(Float64, i.captures[1])
        y = parse(Float64, i.captures[3])

        Value = x*y
        Sum += Value
        push!(results, (x,y, Value))
    end
    return results, Sum

end

# Probably easier to change the function so writing a seperate one

function MultiplyFinderPART2(expression::String)

    # Defining a regex but not with the control
    want = r"mul\((-?\d+(\.\d+)?),(-?\d+(\.\d+)?)\)"
    control = r"mul\((-?\d+(\.\d+)?),(-?\d+(\.\d+)?)\)|(do\(\)|don't\(\))"

    Command = eachmatch(control, expression)
    
    Multiply = true  # Assuming we start with do()
    results = []
    Sum = 0

    # Checking for instructions first, then multiplying
    
    for i in Command
        matched = i.match
        if matched == "do()"
            Multiply = true
        elseif matched == "don't()"
            Multiply = false
        elseif occursin(want, matched) && Multiply
            x = parse(Float64, i.captures[1])
            y = parse(Float64, i.captures[3])

            Value = x*y
            Sum += Value
            push!(results, (x,y, Value))
        end
        # And don't() is essentially a skip so not needed
    end
    return results, Sum

end


Path = "Real.txt"
CorrputedMemory = open(Path, "r") do file
    read(file, String)
end

Findings1, Sum1 = MultiplyFinderPART1(CorrputedMemory)
Findings2, Sum2 = MultiplyFinderPART2(CorrputedMemory)

print("Part 1 sum is: ",Sum1)
print("Part 2 sum is: ",Sum2)



