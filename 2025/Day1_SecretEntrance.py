import astropy
import numpy
import argparse

# Step 1: import Astropy; Step 2: disregard Astropy; Step 3: code
# Bonus Step: run out of time on Monday so fall a day behind before the challenge even starts

# How to run: This is command line executable so follow the command:
#
#               python python_file data_file
#
# make sure you know your route to the python version you want

# Part 1 function:

def rotate(pos, rot, val):
    """
    Hopefully this will wrap around between 0 and 99. 
    This is going to be our 'dial rotator' to crack the safe and save Christmas.
    """

    if rot == "L":
        return (pos - val) % 100
    elif rot == "R":
        return (pos + val) % 100
    else:
        raise ValueError(f"Invalid direction '{rot}'")
    
# Part 2 function: (For now these will be seperate so it is clearer)

def passes_go(pos, rot, val):
    """
    This is for part 2 of the problem where we need to record every time the dial
    passes zero. This can be used for part 1 as well but I want the part 1 function to remain 
    so that can also be checked. 
    """
    zeros = 0
    pos = pos

    if val == 0:
        return pos, zeros
    
    if rot == "R":
        step = 1
    elif rot == "L":
        step = -1

    for i in range(val):
        if pos == 99 and step == 1:
            zeros += 1
        elif pos == 1 and step == -1:
            zeros += 1
        pos = (pos + step) % 100

    return pos, zeros

def main():
    """
    This is where the magic happens. This is python-callable
    """

    clue = argparse.ArgumentParser(description="The dial clue for the password prompt")
    clue.add_argument("file", help="This should be a plain text file containing the password clues")
    args = clue.parse_args()

    try:
        with open(args.file, "r") as file:
            rotations = [line.strip() for line in file if line.strip()]
        
    except FileNotFoundError:
        print(f"Error: File '{args.file}' not found.")
        return
    
    position = 50
    history = [position]
    Passes_0 = 0            # Added for part 2  

    for rotation in rotations:
        rot = rotation[0]
        val = int(rotation[1:])
        position, zeros = passes_go(position,rot,val)  # function updated for pt 2
        
        Passes_0 += zeros # new for pt 2
        history.append(position)
        print(f"{rotation} gives {position}")
    
    zeros = history.count(0)

    # print("\nDial positions (including start):")
    # print(history)

    print(f"\nTotal times the dial was at 0: {zeros}")
    print(f"\nThe amount of times the dial passes (or lands on) go and collects £200: {Passes_0}")
    print(f"\nTherefore\n")
    print(f"\nThe answer to part 1 is: {zeros}")
    print(f"\nThe answer to part 2 is: {Passes_0}")




if __name__ == "__main__":
    main()
