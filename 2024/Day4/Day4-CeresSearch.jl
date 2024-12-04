# Looks like there are some parallels to day 3 here so I shall start with the part 1 function, although redefined.
# I will adapt the function to be enhanced for today's problem.


function Searching(WordSearch::Matrix{Char}, word::String, pos::CartesianIndex{2},depth::Int)::Int

    count = 0

    # Search for 'X'
    if WordSearch[pos] != word[1]
        return 0
    end
    if (pos.I[1] < 1 || pos.I[1] > size(WordSearch, 1) || pos.I[2] < 1 || pos.I[2] > size(WordSearch, 2)) 
        return 0
    end

    # If we found an 'X' in a valid position, then we can look at all directions
    
    Directions = [
        CartesianIndex(1, 0), 
        CartesianIndex(-1, 0),  
        CartesianIndex(0, 1),   
        CartesianIndex(0, -1),  
        CartesianIndex(1, 1),   
        CartesianIndex(-1, 1),  
        CartesianIndex(1, -1),  
        CartesianIndex(-1, -1)  
    ]

    # Any direction for the first letter, second & third MUST be the same
    for i in Directions
        letter2 = pos + i
        if (letter2.I[1] < 1 || letter2.I[1] > size(WordSearch, 1) || letter2.I[2] < 1 || letter2.I[2] > size(WordSearch, 2)) 
            continue
        end

        if WordSearch[letter2] == 'M'
            letter3 = letter2 + i
            letter4 = letter3 + i
            if letter3.I[1] >= 1 && letter3.I[1] <= size(WordSearch, 1) && letter3.I[2] >= 1 && letter3.I[2] <= size(WordSearch, 2) &&
                WordSearch[letter3] == 'A' &&
                letter4.I[1] >= 1 && letter4.I[1] <= size(WordSearch, 1) && letter4.I[2] >= 1 && letter4.I[2] <= size(WordSearch, 2) &&
                WordSearch[letter4] == 'S'
                count += 1
            end
        end
    end

    return count
end

# Looping through the letter matrix
function CheckAndCount(WordSearch::Matrix{Char}, word::String)
    Count=0
    for idx in CartesianIndices(WordSearch)
        Count += Searching(WordSearch, word, idx, 1)
        println(Count,",")
    end
    # Find why count includes ALL letters as a match
    return Count
end

Path = "TestData.txt"

# probably easiest to convert into a matrix
function matrix(Path::String)::Matrix{Char}

    lines = readlines(Path)
    println(lines)
    grid = [Vector{Char}(line) for line in lines]
    wordsearch = Matrix{Char}(undef,length(grid),length(lines[1]))
    for i in 1:length(grid)
        wordsearch[i, :] = grid[i]
    end
    return wordsearch
end

# Bits and Bobs to call run the funcation
WordSearch = matrix(Path)
word = "XMAS"
result = CheckAndCount(WordSearch, word)


println("The word is included ", result, " times")
println(WordSearch)
