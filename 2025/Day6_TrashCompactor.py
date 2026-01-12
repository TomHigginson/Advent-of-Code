import argparse

# 

def Problems():
    """
    Literally just to read the input file, doing it this way will hopefully save me time later on
    """
    Problems = argparse.ArgumentParser(description="Looking for faulty ids")
    Problems.add_argument("file",help="Select your Day 6 input as a .txt file only")
    return Problems.parse_args()

def solver(file):
    """
    This function opens the file, and essentially converts it directly into the problem
    format so that it sums down the columns and returns each column seperately (I am anticpating this 
    being useful for pt 2 - news flash, it is not).
    """
    with open(file) as f:
        lines = [line.rstrip() for line in f if line.strip()]

    *number,op = lines

    rows = [line.split() for line in number]
    ops = op.split()

    ncols = len(ops)

    columns = [[] for _ in range(ncols)]
    for row in rows:
        for i in range(ncols):
            columns[i].append(int(row[i]))

    results = []

    for col_index, (col,op) in enumerate(zip(columns,ops),1):
        if op == "+":
            val = sum(col)
        elif op == "*":
            val = 1
            for x in col:
                val *= x
        elif op == "-":
            val = col[0]
            for x in col[1:]:
                val -= x
        elif op == "/":
            val = col[0]
            for x in col[1:]:
                val /= x
        
        else:
            raise ValueError(f"Unknown operator: {op}")

        results.append(val)

    return results

def solver_pt2(file):
    """
    The easiest way is for a new bit of code to be written I think, 
    all part 2 functions are within this main one.
    """
    def transpose(problem):
        """
        Since we are looking down the columns, transposing seems like the right idea
        """
        height = len(problem)
        width = max(len(r) for r in problem)
        grid = [r.ljust(width) for r in problem]

        return ["".join(grid[r][c] for r in range(height)) for c in range(width)]
    
    
    with open(file) as f:
        problems = [line.rstrip("\n") for line in f if line.strip("\n")]

    t = transpose(problems)
    print(t)

    results = []
    column = []

    def evaluate(column):
        """
        Basically the bulk of the part 2 function, it will look for
        where there is a row without a number and rows with operators
        then follow the instructions.
        As an aside I actually did this from left to right because it make no difference to 
        the problem, although I did realise that the positioning of the operator makes it 
        so much more effective going right-to-left.
        """
        nums = []
        op = None

        for row in column:
            s = row.replace(" ","")
            if s[-1] in "+-*/":
                op = s[-1]
                nums.append(int(s[:-1]))
            else:
                nums.append(int(s))

        nums = nums[::-1]

        if op == "+":
            return sum(nums)
        if op == "*":
            v = 1
            for n in nums:
                v *= n
            return v
        if op == "-":
            v = nums[0]
            for n in nums[1:]:
                v -= n
            return v
        if op == "/":
            v = nums[0]
            for n in nums[1:]:
                v /= n
            return v

    for row in t + [" " * len(t[0])]:
        if row.strip() == "":
            if column:
                results.append(evaluate(column))
                column = []
        else:
            column.append(row)

    return results

def main():
    problems = Problems()
    results = solver(problems.file)
    resultspt2 = solver_pt2(problems.file)

    print("\nThe column results are: ")
    print(" ".join(str(r) for r in results))
    print(" ".join(str(x) for x in resultspt2))
    print(f"\n\nSo the answer for part 1 is: {sum(results)}")
    print(f"\nSo the answer for part 2 is: {sum(resultspt2)} \n")

if __name__ == "__main__":
    main()