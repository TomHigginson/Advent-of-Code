#%%

import os
import astropy
import numpy as np
import csv

# Why not use lists...???
id1 = []
id2 = []

with open("/Users/iv19980/Documents/PhD_Research/AdventOfCode/Advent-of-Code/2024/Day1/Day1_Real.csv", 'r', encoding='utf-8-sig') as file:
    locations = csv.reader(file)
    for col in locations:
        id1.append(int(col[0]))
        id2.append(int(col[1]))


# Obviously bubble because I have the time

def bubble(locID):
    """I'm just a simple bubble sorting algorithm :)"""
    n = len(locID)

    # Running through the list

    for i in range(n):
        for j in range(0,n-i-1):
            if locID[j] > locID[j+1]:
                locID[j],locID[j+1]=locID[j+1],locID[j]
    return(locID)
    

sorted1=bubble(id1)
sorted2=bubble(id2)

# Now we need to find the difference

def distances(DisID1,DisID2):
    """I'll find the distances between opposite numbers in 2 lists"""
    n1 = len(DisID1)
    n2 = len(DisID2)
    if n1 != n2:
        print("Lists are of different lengths :(")

    Difference=0
    for i in range(n1):
        Diff = np.abs(DisID1[i]-DisID2[i])
        Difference=Difference+Diff
    return(Difference)

TotalDiff=distances(id1,id2)

print("And the difference is:")
print(TotalDiff)

#########################################################################################
#####                                                                               #####
#####                               Part 2                                          #####
#####                                                                               #####
#########################################################################################


# Doesn't matter if list is sorted but it can speed things up

def compare(list1,list2):
    """I will generate a weird similarity report where you get Number*Occurance in list 2 added for all numbers in list 1."""
    n1 = len(list1)
    n2 = len(list2)
    if n1 != n2:
        print("Lists are of different lengths :(")
        
    CurrentTotal = 0
    for i in range(n1):
        mult=0
        for j in range(n1):   
            if list1[i] == list2[j]:
                mult=mult+1
        Additional=0        
        if mult != 0:        
            Additional = list1[i]*mult

        CurrentTotal = CurrentTotal+Additional
    return CurrentTotal

Similarity = compare(id1,id2)

print("The similarity report is:")
print(Similarity)



# %%
