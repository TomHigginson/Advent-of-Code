import matplotlib.pyplot as plt
import astropy
import argparse

# I feel like I am doing this too late

def Ingredients():
    """
    Literally just to read the input file, doing it this way will hopefully save me time later on
    """
    Ingredients = argparse.ArgumentParser(description="Looking for faulty ids")
    Ingredients.add_argument("file",help="Select your Day 5 input as a .txt file only")
    return Ingredients.parse_args()

def freshness(file):
    """
    This acts as the file reader but essentially it 
    just reads the challange input enables us to find the 
    fresh and spoilt ingredients
    """

    with open(file) as f:
        row = f.read().strip().split("\n\n")

    ranges = row[0].splitlines()
    ingredients = row[1].splitlines()

    fresh_range = []
    for r in ranges:
        lo, hi = r.split("-")
        fresh_range.append((int(lo),int(hi)))

    ingredient = [int(n) for n in ingredients]

    return fresh_range, ingredient

def fresh(n, fresh_range):
    """
    Used to check if an ingredient is fresh or not
    """
    for lo, hi in fresh_range:
        if lo <= n <= hi:
            return True
        
    return False

def all_fresh(fresh_range):
    """
    This is a function for part 2 only. This should identify all of the fresh ingredient IDs.
    Note The commented out stuff took too long to run on the big set so I needed to speed it up.
    """

    # ids = set()
    # for lo, hi in fresh_range:
    #     for x in range(lo,hi+1):
    #         ids.add(x)
    # return sorted(ids)

    fresh_range = sorted(fresh_range)
    merged = [fresh_range[0]]

    for lo, hi in fresh_range[1:]:
        prev_lo, prev_hi = merged[-1]

        if lo <= prev_hi + 1:
            merged[-1] = (prev_lo, max(prev_hi,hi))
        else:
            merged.append((lo,hi))
    return merged

def main():
    lists = Ingredients()
    fresh_range, ingredient = freshness(lists.file)

    print(f"The lists of fresh ingredients is: {fresh_range}")
    print()

    Valid_ticker=0
    for n in ingredient:
        if fresh(n, fresh_range):
            Valid_ticker+=1
            print(f"{n:>4} \u2713 valid")
        else:
            print(f"{n:>4} \u2718 invalid")
            
    
    Fresh_ingredients = all_fresh(fresh_range)
    total = sum(hi - lo + 1 for lo, hi in Fresh_ingredients)
    print(f"\n All valid IDs are: {Fresh_ingredients}")

    print(f"The solution for part 1 is: {Valid_ticker}")
    print(f"The solution for part 2 is: {total}")

if __name__ == "__main__":
    main()