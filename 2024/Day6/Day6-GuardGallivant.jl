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
end


# Path of the guard. Should be slighly similar to day 3.
function path(map::Matrix{Char})
    
    VisitCount = 0 

    directions = [
        CartesianIndex(-1, 0), 
        CartesianIndex(0, 1),  
        CartesianIndex(1, 0),   
        CartesianIndex(0, -1),   
    ]
    Orientation = [
        '^',
        '>',
        'v',
        '<',
    ]

    position = findguard(map) 
    row,col,dir = position

    while true

        
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


    return VisitCount, map

end

filepath ="GuardsMap.txt"
map = matrix(filepath)
Count,endmap = path(map)
print(endmap)
print(Count)