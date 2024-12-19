# Back to julia

# Easiest to use a matrix to search
function mapmaker(Path::String)::Matrix{Char}

    lines = readlines(Path)
    println(lines)
    grid = [Vector{Char}(line) for line in lines]
    wordsearch = Matrix{Char}(undef,length(grid),length(lines[1]))
    for i in 1:length(grid)
        wordsearch[i, :] = grid[i]
    end
    return wordsearch
end

# Find antenna paids and their antinodes then add all positions to a list and return the list.
# This is different to AoC description (denoting antinodes with a #) but this way can make the count easier.

function FindNode(map::Matrix{Char})
    function isvalid(x::Int, y::Int, rows::Int, cols::Int)
        return 1 <= x <= rows && 1 <= y <= cols
    end

    rows, cols = size(map)
    AntennaLocation = Tuple{Int,Int}[]

    # Finds Antenna
    for i in 1:size(map, 1), j in 1:size(map, 2)
        if map[i,j] != '.' && map[i,j] != '#'
            push!(AntennaLocation,(i,j))
            println("I am pushing this antenna: ",map[i,j]," at position ",(i,j))
        end
    end

    antinode_part1 = Set{Tuple{Int64, Int64}}()

    #Easier to get part 2 in the same loop
    antinode_part2 = Set{Tuple{Int64, Int64}}()

    # Comparing distances to Antenna for antinode location detection.
    for i in 1:length(AntennaLocation)
        for j in i+1:length(AntennaLocation)
            x1, y1 = AntennaLocation[i]
            x2, y2 = AntennaLocation[j]
            if map[x1,y1] == map[x2,y2]

                dx = x1 - x2
                dy = y1 - y2

                antinode1 = (x1 + dx,y1 + dy)
                antinode2 = (x2 - dx,y2 - dy)

                if isvalid(antinode1[1], antinode1[2], rows, cols) #&& map[antinode1[1],antinode1[2]] == '.'
                    println("from the character ", map[x1,y1],
                        " in position ",x1," ",y1,
                        " We find a node at ",antinode1,
                        " from antenna ",map[x2,y2],
                        " at position ",x2," ",y2
                    )
                    push!(antinode_part1,antinode1)
                end

                if isvalid(antinode2[1], antinode2[2], rows, cols) #&& map[antinode2[1],antinode2[2]] == '.'
                    println("from the character ", map[x2,y2],
                        " in position ",x2," ",y2,
                        " We find a node at ",antinode2,
                        " from antenna ",map[x1,y1],
                        " at position ",x1," ",y1
                    )
                    push!(antinode_part1,antinode2)
                end

                # Add onto part 1
                for k in 1:min(rows,cols)

                    antinode1 = (x1 - k * dx, y1 - k * dy)
                    antinode2 = (x2 + k * dx, y2 + k * dy)

                    if isvalid(antinode1[1], antinode1[2], rows, cols)
                        println("from the character ", map[x1,y1],
                        " in position ",x1," ",y1,
                        " We find a node at ",antinode1,
                        " from antenna ",map[x2,y2],
                        " at position ",x2," ",y2
                    )
                        push!(antinode_part2, antinode1)
                    end
    
                    if isvalid(antinode2[1], antinode2[2], rows, cols)
                        println("from the character ", map[x2,y2],
                        " in position ",x2," ",y2,
                        " We find a node at ",antinode2,
                        " from antenna ",map[x1,y1],
                        " at position ",x1," ",y1
                    )
                        push!(antinode_part2, antinode2)
                    end
                end
            end
        end
    end
    println(antinode_part1)
    println(map)
    return length(antinode_part1),length(antinode_part2)
    

end

filepath = "/Users/iv19980/Documents/PhD_Research/AdventOfCode/Day8_Real.txt"

antennamap = mapmaker(filepath)
nodes1,nodes2 = FindNode(antennamap)

println("The number of antinodes is in the part 1 case: ", nodes1)
println("The number of antinodes is in the part 2 case: ", nodes2)