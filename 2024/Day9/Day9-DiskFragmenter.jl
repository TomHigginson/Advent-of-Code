# I want to use today as an experiment to use a matrix for a string which should allow us to move items in full and replace a multi-digit item with a single digit item

# Easiest to use a matrix to search
function diskmap(Path::String)::Matrix{Char}

    lines = readlines(Path)
    println(lines)
    grid = [Vector{Char}(line) for line in lines]
    wordsearch = Matrix{Char}(undef,length(grid),length(lines[1]))
    for i in 1:length(grid)
        wordsearch[i, :] = grid[i]
    end
    return wordsearch
end

# Seperate files and freespace first as they are treated seperatrely. Then create the id conversion with the key.
function idnumber(Diskmap::Matrix{Char})
    files = Int[]
    freespace = Int[] 
    idconversion = String[]

    # Creates a list of intergers for files and free space
    for (i,value) in enumerate(Diskmap)
        lines = parse(Int, string(value))
        if iseven(i)
            push!(freespace, lines)
        else
            push!(files,lines)
        end

    end

    # Since I will have ids longer than a single digit I need to use a string not a character.
    # This writes to an empty array, and converts to the desired id-line format.
    for i in 1:length(Diskmap)
        if iseven(i)
            item = Int(i/2)
            empty = string('.')
            repeat = freespace[item]
            for j in 1:repeat
                push!(idconversion,empty)
            end
        else
            item = Int((i+1)/2)
            id = string(item-1)
            repeat = files[item]
            for j in 1:repeat
                push!(idconversion,id)
            end
        end
    end
    return files, freespace, idconversion
end

# Making the swaps of last items with first occurance of empty space.
function ordering_ids(converted::Array{String})

    for i in 0:length(converted)-1 
        if converted[end-i] != "."
            for j in 1:length(converted)-i
                if converted[j] == "." && j < length(converted)-i
                    converted[j], converted[end-i] = converted[end-i], converted[j]
                end
            end
        end
    end

    return converted
end

# final thing for part 1, multilying position by id. We need to convert to intigers first
function finalchecksum(ordered::Array{String})
    
    total = 0
    for i in 1:length(ordered)
        if ordered[i] != "."
            id = parse(Int, ordered[i])
            additional = id*(i-1)
            total += additional
        end
    end
    return total

end



filepath = "inputfile.txt"
DiskMap = diskmap(filepath)
ids,freespace,diskmapout = idnumber(DiskMap)
# print(diskmapout)
# Be careful implementing the below function as it is definitely not optimised so could take a miniute or so. I didn't bother with progress information.
converted = ordering_ids(diskmapout)
# print(converted)
total = finalchecksum(converted)
println("The solution to part 1 is: ",total)