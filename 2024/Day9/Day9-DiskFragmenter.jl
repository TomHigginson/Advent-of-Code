using DataStructures

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
function ordering_ids(idlist::Array{String})
    converted = idlist
    for i in 0:length(converted)-1 
        if converted[end-i] != "."
            for j in 1:length(converted)-i
                if converted[j] == "." && j < length(converted)-i
                    converted[j], converted[end-i] = converted[end-i], converted[j]
                end
            end
        end
        println("We have completed ", i, " checks out of a possible ",length(converted))
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

# Create a dictionary to identify length
# Since Julia does not make dictionaries orderly, I originally used a key for determining the number id to move.
# However I realised I will need the same dictonary for free space and didn't want to make another key so I found DataStructures.jl 
# and used that for freespace. I kept in the key for ids for now as I cba to remove them :)

function part2_orderingids(converted::Array{String})
    id_position_dict = OrderedDict{String, Vector{Int}}()
    keys = String[]

    for i in 1:length(converted)
        if converted[i] != "."
            push!(get!(id_position_dict,converted[i],Int[]),i)
            if !(converted[i] in keys)
                push!(keys,converted[i])
            end
        end
    end
    FreeSpace = OrderedDict{Int,Vector{Int}}()
    spaceindex = nothing
    for i in 1:length(converted)
        if converted[i] == "."
            if spaceindex === nothing
                spaceindex = i
                FreeSpace[spaceindex] = Int[]
            end
            push!(FreeSpace[spaceindex],i)
        else
            spaceindex = nothing
        end
    end

    for key in reverse(keys)
        position = id_position_dict[key]
        count = length(position)
        available = findall(x -> x == '.',converted)

        # Now need to see if we can find space:
        for (start, chain) in FreeSpace
            if length(chain) >= count && chain[1] < position[1]
                for j in 1:count
                    converted[chain[j]] = key
                    converted[position[j]] = "."
                end
                FreeSpace[start] = chain[(count+1):end]
                break
            end
        end
    println("We have ",key," remaining checks out of ",length(keys))
    end

    return converted
end

filepath = "input_data.txt"
DiskMap = diskmap(filepath)
ids,freespace,diskmapout = idnumber(DiskMap)
# print(diskmapout)
# Be careful implementing the below function as it is definitely not optimised so could take a miniute or so. I didn't bother with progress information.
# println(diskmapout)
convert = ordering_ids(diskmapout)
# print(converted)
total = finalchecksum(convert)
println("The solution to part 1 is: ",total)
ids,freespace,diskmapout = idnumber(DiskMap)
part2 = part2_orderingids(diskmapout)
total2 = finalchecksum(part2)
print("The solution to part 2 is: ",total2)