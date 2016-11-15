# -*- coding: utf-8 -*-
"""
This is the first python porject assigned in the Stats course. This uses input
form the user for two input files (energy.csv, waterTemperature.csv) and then 
creates a singe file adding information form both files. The output gives the 
choice of appending to a file or creating a new file. 
"""

import numpy
import time

filenameenergy = input("Enter Energy Filename: ") #get filename for energy file must include extension
energydata = numpy.loadtxt(filenameenergy, delimiter=',', dtype=bytes,skiprows=1).astype(str) #reads in csv file. 

[energydate,energyval] = numpy.split(energydata,2,1) #seperates the energy data and enrgy values

delindex = [len(energydate)-1] #find index of final value
energydate = numpy.delete(energydate, delindex) # deletes the final value total 
energyval = numpy.delete(energyval, delindex) # delets final value sum of Wh

energydivide = numpy.array(energyval[0:],dtype=int,ndmin=2)/1000 #divides values by 1000 as requested
energydivide = numpy.swapaxes(energydivide,0,1)

energykWh = [energydivide] #Puts the energy kilowatts per hour into array

filenametemp = input("Enter Temperature Filename: ") #get filename for energy file must include extension

with open(filenametemp, 'r') as infile: # Reading in the first 3 lines from temperature file for header
    lines = [line for line in infile][:3]


header = [lines[0],lines[2].strip('\n')+',"Energy Produced (kWh)"\n'] # adds kilowatts to header labels

tempdata = numpy.loadtxt(filenametemp, delimiter=',', dtype=bytes,skiprows=3).astype(str) #reads in the data from temp no header info

timevals = tempdata[0:,1]; # Gives time values for temperature file

N = len(energyval) # number of energy values for energy file
AddToArray = numpy.chararray((len(timevals), 1),itemsize=5)
AddToArray[:] = ''

a=0
for x in range(0, N):
    newtime = time.strptime(energydate[x], '%Y-%m-%d %H:%M:%S %z')
    newtime = time.strftime('%m/%d/%y %H:%M:%S %p',newtime) #compares the times in a boolean way.
    t = numpy.sum(newtime>timevals) + a
    AddToArray[t] =str(energydivide[x,0]) # Places the energy value next to the correct index location
    a = -1    
    
FinalMatrix = numpy.concatenate((tempdata,AddToArray),1)

decisionappend = input("Do you want to append to a file? (yes/no)  ") # This feature will add option to append or create new file

if "yes" in decisionappend: #You want to append
    appendfilename = input("Please enter appended file name:")
    numpy.savetxt(open(appendfilename, "ab"), FinalMatrix, delimiter=",", fmt="%s") #add the data to the file 
    print("file was appended")

if "no" in decisionappend: #You want to create a new file so lets create that
    newfilename = input("PLease enter new file name:")
    open(newfilename, 'a')
    
    with open(newfilename, "a") as myfile: # This corrects file name and puts it into a new file
        for x in range(0, 2):
            myfile.write(header[x]) 

    numpy.savetxt(open(newfilename, "ab"), FinalMatrix, delimiter=",", fmt="%s") # Adds data to the file
    print("new file was created")



