import astropy
import numpy
import argparse

# I thought it mattered, 
# I thought the music mattered,
# But does it? ******,
# Not compared to how elfs matter

def joltages():
    """
    Literally just to read the input file, doing it this way will hopefully save me time later on
    """
    Ranges = argparse.ArgumentParser(description="Looking for joltage ratings")
    Ranges.add_argument("file",help="Select your Day 3 input as a .txt file only")
    return Ranges.parse_args()

def largest_ratings(Bank):
    """
    Two batteries to produce the largest joltage. It works by finding the batteries, then checking their positions in order to get the right joltage of the bank.
    """
    rating = [int(battery) for battery in Bank]
    
    jolt_rating = 0
    for i in range(len(rating)):
        for j in range(i+1, len(rating)):
            potential = 10*rating[i] + rating[j]
            if potential > jolt_rating:
                jolt_rating = potential
    
    return jolt_rating

def largest_ratings_pt2(Bank):
    sequence = 12
    rating = [int(battery) for battery in Bank]
    ignore = len(rating) - sequence
    jolts = []

    for battery in rating:
        while ignore > 0 and jolts and jolts[-1] < battery:
            jolts.pop()
            ignore -= 1
        jolts.append(battery)
    
    End_jolts = jolts[:sequence]
    return int("".join(str(bat) for bat in End_jolts))

def main():
    banklist = joltages()

    with open(banklist.file, "r") as file:
        lines = [line.strip() for line in file.readlines() if line.strip()]

    total_jolts = 0
    total_jolts_pt2 = 0
    for line in lines:
        joltage = largest_ratings(line)
        joltage_pt2 = largest_ratings_pt2(line)
        if joltage is None or joltage_pt2 is None:
            print(f"{line} does not have enough digits so is passes")
        else:
            total_jolts = total_jolts + joltage 
            total_jolts_pt2 = total_jolts_pt2 + joltage_pt2
            print(f"In {line} the joltage rating is {joltage}")
            print(f"In {line} the enhanced joltage rating is {joltage_pt2}")

    print(f"The result for part 1 is {total_jolts}")
    print(f"The result for part 2 is {total_jolts_pt2}")

if __name__ == "__main__":
    main()
        


