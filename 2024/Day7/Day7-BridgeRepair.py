# I want to use python for this one as I still want to do some problems in python. Hopefully I can use these to compare to writing and implementing julia
# I got to experiment with recursion loops here which I have not used much of before.

def calibrators(CalEqn):
    """
    Opens the input data as Test Number: [values list]
    """
    data = {}
    with open(CalEqn,"r") as equations:
        for line in equations:
            if ":" in line:
                test, numbers = line.split(":")
                test = int(test.strip())
                numbers = list(map(int, numbers.strip().split()))
                data[test] = numbers
    return data

# def Maths(test,operator):
#     """
#     This will apply the maths through the list. 
#       Currently, not in us since I have adapted the checking function to 
#       include the operators and remove the need to insert them within the list of numbers.
#     """
#     result = test[0]
#     for i in range(1,len(test)):
#         if operator[i-1] == '+':
#             result += test[i]
#         if operator[i-1] == '*':
#             result *= test[i]
#     return result

def Check_pt1(numbers, test, index=1, Total=None):
    """
    Goes through all the number sets and applies multiplier or addition. 
    Please call as Check(number list, test) as index and Total are only used in the recursion
    """

    if Total is None:
        Total = numbers[0]

    # Check if we have obtained the target ONLY if we have used ALL numbers. 
    if index == len(numbers):
        if Total == test:
            return True,Total
        return False, None
    
    Next = numbers[index]

    # Addition
    add,totadd = Check_pt1(numbers, test, index + 1, Total + Next)
    if add:
        return True,totadd
    
    # Multiplication
    mult,totMult = Check_pt1(numbers, test, index+1, Total * Next)
    if mult:
        return True, totMult
    
    return False, None

# Part 1 and 2 are nearly identical but it seems like a hassel to write in a function that will call part 1 in such a way
# that it runs part 2 so I have literally copied the function and added the concatination

def Check_pt2(numbers, test, index=1, Total=None):
    """
    Goes through all the number sets and applies multiplier or addition or concatenation . 
    Please call as Check(number list, test) as index and Total are only used in the recursion
    """

    if Total is None:
        Total = numbers[0]

    # Check if we have obtained the target ONLY if we have used ALL numbers. 
    if index == len(numbers):
        if Total == test:
            return True,Total
        return False, None
    
    Next = numbers[index]

    # Addition
    add,totadd = Check_pt2(numbers, test, index + 1, Total + Next)
    if add:
        return True,totadd
    
    # Multiplication
    mult,totMult = Check_pt2(numbers, test, index+1, Total * Next)
    if mult:
        return True, totMult
    
    # Concatination
    concatenated = int(str(Total)+str(Next))
    con,totcon = Check_pt2(numbers,test,index+1,concatenated)
    if con:
        return True,totcon
    
    return False, None
    

CalEqn = "BridgeData.txt"
Data = calibrators(CalEqn)

EndTotal1 = 0
for test,numbers in Data.items():
    result, total = Check_pt1(numbers, test)
    if result:
        EndTotal1 += total
        print("Current Running Total is for PART 1: ",EndTotal1)

EndTotal2 = 0
for test,numbers in Data.items():
    result, total = Check_pt2(numbers, test)
    if result:
        EndTotal2 += total
        print("Current Running Total is for PART 2: ",EndTotal2)

print("FINAL VALUE pt1: ",EndTotal1)
print("FINAL VALUE pt2: ",EndTotal2)