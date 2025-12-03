import astropy
import argparse
import re

# Without Regex, Pyinpy:

# Now, this looks like a job for Regex, 
# So everybody just follow Regex, 
# Coz we need a little controversey

Regex_repeating = re.compile(r'^(\d+)\1$')
Regex_repeating_pt2 = re.compile(r'^(\d+)\1+$') # Edit for pt 2
Regex_range = re.compile(r'(\d+)-(\d+)')

def faulty(id: str):
    """
    Identifies repeating strings (exactly 2)
    """

    return bool(Regex_repeating.match(id))

def faulty_pt2(id: str):
    """
    Identifies repeating strings for the part to part (for any number of repeating strings)
    """

    return bool(Regex_repeating_pt2.match(id))

# Coz it feels so empty without strings

def ranges():
    """
    Literally just to read the input file, doing it this way will hopefully save me time later on
    """
    Ranges = argparse.ArgumentParser(description="Looking for faulty ids")
    Ranges.add_argument("file",help="Select your Day 2 input as a .txt file only")
    return Ranges.parse_args()


# Like little Hellions, kids feeling rebellious
# Embarressed, their parents still use main

def main():
    ids = ranges()
    with open(ids.file, "r") as file:
        line = file.readline().strip()
    
    faultyids = []
    faultyids_part2 = []

    for match in Regex_range.finditer(line):
        id1, id2 = map(int, match.groups())
        
        for id in range(id1, id2+1):

            if faulty(str(id)):
                faultyids.append(id)
            
            elif faulty_pt2(str(id)):
                faultyids_part2.append(id)
    
    print("THIS IS FOR PART 1: \n")
    if faultyids:
        print("Faulty IDs Found: ")
        for id in faultyids:
            print(id)
        print("\n",faultyids)
        
    else:
        print("No faulty IDs found")

    print("\nTherefore the sum of the faulty IDs is: ",sum(faultyids))
    print("\n########################\n##################\nThis is for part 2:\n")
    if faultyids_part2:
        print("Faulty IDs Found: ")
        for id in faultyids_part2:
            print(id)
        print("\n",faultyids_part2)
        
    else:
        print("No faulty IDs found")
    print("\nTherefore the sum of the faulty IDs for part 2 is: ",sum(faultyids_part2)+sum(faultyids))

# A visionary but vision is scary
# Could start a revolution, polluting the regex
if __name__ == "__main__":
    main()