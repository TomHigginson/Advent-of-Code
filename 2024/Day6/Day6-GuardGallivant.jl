# I can probably reuse a decent amount from previous days today. I will use julia again as I can use cartesianindicies.

# Calling in the data (copied from day 3)
function matrix(Path::String)::Matrix{Char}

    lines = readlines(Path)
    println(lines)
    grid = [Vector{Char}(line) for line in lines]
    map = Matrix{Char}(undef,length(grid),length(lines[1]))
    for i in 1:length(grid)
        map[i, :] = grid[i]
    end
    return map
end

function findguard(map::Matrix{Char})

    # Needs to be in this order (start not important) since increase by 1 needs to be a right turn.
    for i in 1:size(map, 1), j in 1:size(map, 2)
        if map[i, j] == '^' 
            return (i,j,1)
        elseif map[i, j] == '>'
            return (i,j,2)

        elseif map[i, j] == 'v'
            return (i,j,3)

        elseif map[i, j] == '<'
            return (i,j,4)

        end
    end
    error("I cannot find where the guard currently is :(")
end


# Path of the guard. Should be slighly similar to day 3.
# This is part 1 but could be used iteratively for part 2. Only change is that it will find if it is in a perminant loop.
function path(map::Matrix{Char})
    map = copy(map)
    VisitCount = 0
    
    # Needed for part 2
    TotalVisit = 0

    directions = [
        CartesianIndex(-1, 0), 
        CartesianIndex(0, 1),  
        CartesianIndex(1, 0),   
        CartesianIndex(0, -1),   
    ]
    # This is no longer necessary but I will leave it in incase I want it back :)
    Orientation = [
        '^',
        '>',
        'v',
        '<',
    ] 

    position = findguard(map) 
    row,col,dir = position

    # This is used for part 2, if we have a repeating path then this trips to false
    loop = true

    while true

        TotalVisit += 1
        # Needed for part 2 to check if there is an infinite loop
        # (May need to adjust for time/safety ASSUMED: no escape if total visited squares exceeds double the number of squares - not mathematically checked)
        if TotalVisit > size(map,1) * size(map,2) * 2 
            loop = false
            break
        end

        # New position of guard
        GuardPos = CartesianIndex(row,col)
        NextPos = GuardPos + directions[dir]

        if map[row,col] != 'x' 
            VisitCount += 1
            map[row,col] = 'x'
                
        end

        if NextPos[1] < 1 || NextPos[1] > size(map,1) || NextPos[2] < 1 || NextPos[2] > size(map,2)
            break
        end

        if map[NextPos[1],NextPos[2]] == '#'
            dir = mod(dir,4)+1
        else
            row,col = NextPos[1], NextPos[2]
        end


    end

     # Make loop bool 
    return VisitCount, map, loop 

end

# Bit of a brute force algorithm but it works very quickly with the data given, The print debugging statements might slow it down.

function CheckNewObsticle(map::Matrix{Char})
   
    CanBePlaced = 0
    for i in 1:size(map, 1), j in 1:size(map, 2)
        
        if map[i,j] == '.'
            println("hey I am checking: ($i,$j)")
            Memory = map[i,j]
            map[i,j] = '#'
            Visit,MapTest,loop = path(map)

            
            if loop == false
                CanBePlaced +=1
                println("Placing something here will stop the guard ($i,$j)")
            end

            # Restore to original
            map[i, j] = Memory  

        end

    end

    return CanBePlaced

end

filepath ="GuardsPath.txt"
map = matrix(filepath)
Count,endmap = path(map)
NumberOfLocations = CheckNewObsticle(map)
println("The answer to part 1 is: ",Count)
println("The answer to part 2 is: ", NumberOfLocations)