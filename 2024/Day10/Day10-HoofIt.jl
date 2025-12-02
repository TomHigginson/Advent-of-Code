
# Using the now-standard starting point of generating a matrix:

function trailmap(Path::String)::Matrix{Char}

    lines = readlines(Path)
    println(lines)
    grid = [Vector{Char}(line) for line in lines]
    wordsearch = Matrix{Char}(undef,length(grid),length(lines[1]))
    for i in 1:length(grid)
        wordsearch[i, :] = grid[i]
    end
    return wordsearch
end


# This is essentially a wordsearch.

function RouteFinder(WordSearch::Matrix{Char})::Int

    count = 0
    row, col = size(WordSearch)
    # Search for a start node
    trailheads = [(i,j) for i in 1:row, j in 1:col if WordSearch[i,j] == '0']

    # If we found an '0' in a valid position, then we can look at all directions
    
    Directions = [
        (1, 0), 
        (-1, 0),  
        (0, 1),   
        (0, -1),  
    ]
    function validity(x, y, previous)
        x in 1:row &&
         y in 1:col && 
        abs(WordSearch[x,y] - previous) < 2
    end

    # Create a BFS form each trailhead to see if there is a Path
    function BFS(start)
        queue = [start]
        visited = Set{Tuple{Int, Int}}()
        push!(visited, start)

        while !isempty(queue)
            x, y = popfirst!(queue)
            if WordSearch[x,y] == 9
                return true
            end

            for (dx, dy) in Directions
                nx, ny = x+dx, y+dy
                if validity(nx, ny, WordSearch[x,y]) && (nx, ny) ∉ visited
                    push!(queue, (nx,ny))
                    push!(visited, (nx,ny))
                end
            end
            println(x,", ",y)
        end
        return false
    end

    for trailhead in trailheads
        if BFS(trailhead)  
            count += 1
        end
    end

    return count
end


filepath = "/Users/iv19980/Documents/Misc/AdventOfCode/Data_csv/Day10_test.txt"
DiskMap = trailmap(filepath)
Count = RouteFinder(DiskMap)