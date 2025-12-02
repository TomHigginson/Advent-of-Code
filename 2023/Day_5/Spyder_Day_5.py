#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Dec  6 23:47:55 2023

@author: iv19980
"""

# Test case
import re

# with open('Day_4_Input.txt', 'r') as file:
    
#     Sample = []
    
#     for line in file:
#         line=line.strip()
#         Sample.append(line)
        
def Getting_Information(Input):
    """Turning the text file into callable arrays for each mapping catagory"""

    result = {'seeds': [], 'seed_to_soil_map': [], 'soil_to_fertilizer_map': [],
              'fertilizer_to_water_map': [], 'water_to_light_map': [],
              'light_to_temperature_map': [], 'temperature_to_humidity_map': [],
              'humidity_to_location_map': []}

    current_mapping = None

    with open(Input, 'r') as file:
        for line in file:
            line = line.strip()

            if not line:
                continue # No line so skipped
            
            elif line.endswith(':'):
                current_mapping = line[:-1].lower().replace('-', '_').replace(' ', '_')
                continue # Keeps mapping header

            values = list(map(int, line.split()))
            result[current_mapping].append(values)

    return result

def Mapping_Rule(Mapping_array):
    """Defining how the mapping works:
        it uses an input array of [Start_Map_From, Start_Map_To, Range]
        Then it returns the final mapping for only changed values"""
    Mapping_Values = {}
    for i in range(len(Mapping_array)):
        Map=Mapping_array[i]
        for j in range(Map[2]):
            Initial_key = Map[0]
            key=Initial_key+j
            Initial_value = Map[1]
            value=Initial_value+j
            Mapping_Values[key] = value
    return(Mapping_Values)

def apply_Mapping(Dictionary, Seed):
    """Applying the mapping to the input parameter"""
    
    #if input is not in mapping from array it stays the same, otherwise it becomes mapping to
    if Seed in Dictionary:
        return Dictionary[Seed]
    else:
        return Seed

order = {1:'seeds', 2:'seed_to_soil_map', 3:'soil_to_fertilizer_map',
              4:'fertilizer_to_water_map', 5:'water_to_light_map',
              6:'light_to_temperature_map', 7:'temperature_to_humidity_map',
              8:'humidity_to_location_map'}
    

def Mapping_over_all_Maps(Seeds,Mapping_Array):
    """Essentially applies all the mapping functions over all the different maps"""
    Locations=[]
    for i in range(len(Seeds)):
        for j in range(len(Mapping_Array)-1):
            DictionaryItem=order[j+1]
            Mapping_Array_input=Mapping_Array[DictionaryItem]
            Maps=Mapping_Rule(Mapping_Array_input)
            Seed=Seeds[i]
            Mapped=apply_Mapping(Maps,Seed)
        Locations.append(Mapped)
    return Locations
Dictionary=Getting_Information('Day_5_Input.txt')
Seeds = Dictionary['seeds']
Seed = Seeds[0]

Locations=Mapping_over_all_Maps(Seed,Dictionary)
print(Locations)