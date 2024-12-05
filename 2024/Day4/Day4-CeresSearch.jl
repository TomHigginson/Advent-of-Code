# Looks like there are some parallels to day 3 here so I shall start with the part 1 function, although redefined.
# I will adapt the function to be enhanced for today's problem.

# I will seperate part 1 and part 2 functions, although they will likely be almost identical
# Part 2 is clunky but works so I may improve it but for now this it the attempt

function Searching_pt1(WordSearch::Matrix{Char}, word::String, pos::CartesianIndex{2},depth::Int)::Int

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

function CheckAndCount_pt1(WordSearch::Matrix{Char}, word::String)
    Count=0
    for idx in CartesianIndices(WordSearch)
        Count += Searching_pt1(WordSearch, word, idx, 1)
        println(Count,",")
    end
    # Find why count includes ALL letters as a match
    return Count
end

####################################################################################################################
####################################################################################################################
####################################################################################################################

# Part 2 searching function

function Searching_pt2(WordSearch::Matrix{Char}, word::String, pos::CartesianIndex{2},depth::Int)::Int

    count = 0

    # Search for 'A' since this is the central letter
    if WordSearch[pos] != word[3]
        return 0
    end

    # If we found an 'X' in a valid position, new we only need the diagonals

    Directions = [
        CartesianIndex(1, 1),   
        CartesianIndex(-1, 1),  
    ]


    # Any direction for the first letter, first & third MUST be opposite
    
    # Along y=x line
    letter1 = pos + Directions[1]
    letter2 = pos - Directions[1]

    # Along y=-x
    letter3 = pos + Directions[2]
    letter4 = pos - Directions[2]
        
    if (letter1.I[1] < 1 || letter1.I[1] > size(WordSearch, 1) || letter1.I[2] < 1 || letter1.I[2] > size(WordSearch, 2)) 
        return 0
    end
    if (letter2.I[1] < 1 || letter2.I[1] > size(WordSearch, 1) || letter2.I[2] < 1 || letter2.I[2] > size(WordSearch, 2)) 
        return 0
    end
    if (letter3.I[1] < 1 || letter3.I[1] > size(WordSearch, 1) || letter3.I[2] < 1 || letter3.I[2] > size(WordSearch, 2)) 
        return 0
    end
    if (letter4.I[1] < 1 || letter4.I[1] > size(WordSearch, 1) || letter4.I[2] < 1 || letter4.I[2] > size(WordSearch, 2)) 
        return 0
    end

    if (WordSearch[letter1] == 'M' && WordSearch[letter2] == 'S' &&
        WordSearch[letter3] == 'M' && WordSearch[letter4] == 'S') ||
        (WordSearch[letter1] == 'S' && WordSearch[letter2] == 'M' &&
        WordSearch[letter3] == 'M' && WordSearch[letter4] == 'S') ||
        (WordSearch[letter1] == 'M' && WordSearch[letter2] == 'S' &&
        WordSearch[letter3] == 'S' && WordSearch[letter4] == 'M') ||
        (WordSearch[letter1] == 'S' && WordSearch[letter2] == 'M' &&
        WordSearch[letter3] == 'S' && WordSearch[letter4] == 'M')

        count += 1
    end

    return count
end

function CheckAndCount_pt2(WordSearch::Matrix{Char}, word::String)
    Count=0
    for idx in CartesianIndices(WordSearch)
        Count += Searching_pt2(WordSearch, word, idx, 1)
        println(Count,",")
    end
    # Find why count includes ALL letters as a match
    return Count
end


# Looping through the letter matrix

Path = "/Users/iv19980/Documents/PhD_Research/AdventOfCode/Day4_Real.txt"

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
result = CheckAndCount_pt2(WordSearch, word)


println("The word is included ", result, " times")
println(WordSearch)
