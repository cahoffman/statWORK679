#!/bin/bash
# This script will create a csv format file that will have 3 collums of data. Run this script from the parent directory of the log and out folders.

    saveFileloc=$(echo $(pwd)/analysis-p2-hw1.csv)    # Creates a file name and path for saving
    touch $saveFileloc     # Creates file in current location for data saving
 
for filename in $(ls log)
do
    logPath=$(echo "log/$filename")    # Creates path for the log files to be searched
    outPath=$(echo "out/${filename%.log}.out")   # Creates path for out files to be searched

    temp=$(grep "rootname for" $logPath)    # Picks out the lines from all files with root name
    rootName=$(echo "${temp:20}")    # Extracts just the name from the line

    temp=$(grep "hmax =" $logPath)    # Picks out the lines from all files with hmax in it
    hMax=$(echo "${temp:8}")    # Extracts hMax value with comma keep comma for csv formating

    # Picks out the lines from all out files with elasped time. Extracts numerical value with second part of the pipe
    elapsedTime=$(grep -E "Elapsed time" $outPath | grep -P '\d+\.\d' -o) 

    echo "analysis:$rootName, h:$hMax CPUtime:$elapsedTime in seconds" >> $saveFileloc
    
done 
