import astropy
import argparse

# What better way to spend a 2hr delay at Stansted, than doing AoC?

def Paper():
    """
    Literally just to read the input file, doing it this way will hopefully save me time later on
    """
    paper = argparse.ArgumentParser(description="Looking for faulty ids")
    paper.add_argument("file",help="Select your Day 2 input as a .txt file only")
    return paper.parse_args()


def accessible(paper):
    """
    Identifies of each individual roll of paper is accessible
    """

    rows = len(paper)
    cols = len(paper[0])
    nodes = 0

    #Listing all possible directions
    directions = [(-1,-1),(-1,0),(-1,1),(0,-1),(0,1),(1,-1),(1,0),(1,1)]
    output = []

    for i in range(rows):
        row = []
        for j in range(cols):
            if paper[i][j] == "@":
                count = 0
                for dx, dy in directions:
                    ni = i+dx
                    nj = j+dy
                    if 0 <= ni < rows and 0 <= nj < cols:
                        if paper[ni][nj] == "@":
                            count += 1
                if count < 4:
                    nodes += 1
                    
                row.append(str(count))
            else:
                row.append(".")
        output.append(row)
    return output,nodes
    
def removal(paper):
    """
    Basically the same as before but adjusted for part two such that 
    once a paper has been identified as being removable, it can be removed.
    """

    rows = len(paper)
    cols = len(paper[0])
    removed = 0

    directions = [(-1,-1),(-1,0),(-1,1),(0,-1),(0,1),(1,-1),(1,0),(1,1)]

    def neighbours(i,j):
        count = 0
        for dx, dy in directions:
            ni = i+dx
            nj = j+dy
            if 0 <= ni < rows and 0 <= nj < cols:
                if paper[ni][nj] == "@":
                    count += 1

        return count
    
    Removed = True

    while Removed:
        Removed = False

        newmap = [list(row) for row in paper]

        for i in range(rows):
            for j in range(cols):
                if paper[i][j] == "@":
                    if neighbours(i,j) < 4:
                        newmap[i][j] = "."
                        removed += 1
                        Removed = True
        
        paper = newmap
    
    return paper,removed


def main():
    layout = Paper()

    with open(layout.file, "r") as file:
        lines = [line.strip() for line in file.readlines() if line.strip()]

    result,nodes = accessible(lines)

    final,removed = removal(lines)

    # print("Input:")
    # for row in lines:
    #     print(row)

    # print("\nAdjacent counts:")
    # for row in result:
    #     print("".join(row))

    # print(nodes)

    print("\nFinal grid:")
    for row in final:
        print("".join(row))
    
    print(f"The result for part 1 is: {nodes}")
    print(f"The result for part 2 is: {removed}")

if __name__ == "__main__":
    main()
        