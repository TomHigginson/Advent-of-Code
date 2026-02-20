import argparse 

# I'm going to just try to animate this off the bat. It should be simple since my plan is to draw the path anyway as is in the original task.

def load_manifold(filename):
    """
    Opens the input file to generate the manifold
    """

    with open(filename, "r") as f:
        return [list(line.rstrip("\n")) for line in f]
    
def find_beam(manifold):
    """
    This will find the starting point for the beam. 
    I have not checked the input puzzle yet so hopefully this will
    still work if more than one beamhead is present.
    """
    beamhead = []
    for i in range(len(manifold)):
        for j in range(len(manifold[0])):
            if manifold[i][j] == "S":
                beamhead.append((i,j))

    if not beamhead:
        raise ValueError("The Tachyon Beam has not been located")

    return beamhead

def step(manifold, beamhead):
    """
    A function for generating the new position of the beamhead,
    which should make the animation simple to generate.
    """

    max_i = len(manifold)
    max_j = len(manifold[0]) 
    New_beamheads = []
    Splits = 0

    for i,j in beamhead:
        di = i+1
        if di >= max_i:
            continue

        if manifold[di][j] == "^":
            Splits += 1
            if j - 1 >= 0:
                New_beamheads.append((di,j-1))
            if j + 1 < max_j:
                New_beamheads.append((di,j+1))
        
        else:
            New_beamheads.append((di,j))

    #New_beamheads = list(set(New_beamheads))

    return New_beamheads, Splits

def render(manifold,beamhead):
    """
    Generates the frame
    """

    frame = []
    for row in manifold:
        frame.append(row[:])

    for i,j in beamhead:
        if 0 <= i <= len(frame) and 0 <= j <= len(frame[0]):
            frame[i][j] = "S"
    
    return frame

def print_frame(frame, ticker):
    """
    Prints each frame individually
    """
    print("\n"+"="*40)
    print(f"Splits: {ticker}")
    for row in frame:
        print("".join(row))

def animate(manifold):
    """
    Does what it says on the tin, animates the solution
    """
    beamhead = find_beam(manifold)
    frame_id = 0
    ticker = 0

    while beamhead:
        frame = render(manifold,beamhead)
        print_frame(frame,ticker)

        beamhead, Splits = step(manifold,beamhead)
        ticker += Splits
        frame_id += 1

    print("\nSimulation has Finished")
    print(f"Total number of splits (and part one solution): {ticker}")

def main():
    parser = argparse.ArgumentParser(
        description = "Teleporter Hub animation for fixing the tachyon manifold"
    )
    parser.add_argument("input", help="Input text file")
    args = parser.parse_args()

    manifold = load_manifold(args.input)
    animate(manifold)

if __name__ == "__main__":
    main()

