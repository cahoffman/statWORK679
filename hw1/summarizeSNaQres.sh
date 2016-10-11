#!/bin/bash
# This script will create a csv format file that will have 3 collums of data. Run this script from the parent directory of the log and out folders.

    saveFileloc=$(echo $(pwd)/analysis-p3-hw1.csv)    # Creates a file name and path for saving
    touch $saveFileloc     # Creates file in current location for data saving
    cp /dev/null $saveFileloc     #Clears the files if you run it multiple times
    echo "analysis, h, CPUtime, Nruns, Nfail, fabs, frel, xabs, xrel, seed, under3460, under3450, under3440" >> $saveFileloc # Creates the headers for the csv file
 
for filename in $(ls log)
do
    logPath=$(echo "log/$filename")    # Creates path for the log files to be searched
    outPath=$(echo "out/${filename%.log}.out")   # Creates path for out files to be searched

    temp=$(grep "rootname for" $logPath)    # Picks out the lines from all files with root name
    rootName=$(echo "${temp:20}")    # Extracts just the name from the line

    temp=$(grep "hmax =" $logPath)    # Picks out the lines from all files with hmax in it
    hMax=$(echo "${temp:8}")    # Extracts hMax value with comma keep comma for csv formating

    # Picks out the lines from all out files with elasped time. Extracts numerical value with second part of the pipe
    elapsedTime=$(grep -E "Elapsed time" $outPath | grep -Po '\d+\.\d+') 

    Nruns=$(grep -E "BEGIN:" $logPath | cut -f 2 -d ' ') #find the number of runs intialized
    
    #find the number of fail runs
    Nfail=$(grep -E "max number of failed proposals" $logPath | grep -o -E '[0-9]+' | head -1) 

    #find input parameter absolute tolerance differnece
    fabs=$(sed -n '/ftolAbs=/{s/.*ftolAbs=//;s/\S*=.*//;p}' $logPath)

    #find input parameter relative tolerance differnece
    frel=$(sed -n '/ftolRel=/{s/.*ftolRel=//;s/\S*=.*//;p}' $logPath)

    #find input parameter absolute tolerance differnece
    xabs=$(sed -n '/xtolAbs=/{s/.*xtolAbs=//;s/\S*=.*//;p}' $logPath)

    #find input parameter relative tolerance differnece
    xrel=$(sed -n '/xtolRel=/{s/.*xtolRel=//;s/\S*=.*//;p}' $logPath)
    xrel=${xrel::-1} #remove the . at the end

    #find the value of main seed for the first run
    seed=$(grep -E "main seed" $logPath | grep -o -E '[0-9]+')

    #This is the section to find values lower than a certain number
    under=$(sed -n '/loglik/{s/.*loglik//;s/\S*=.*//;p}' $logPath | sed 's/[A-Za-z]*//g' | head -20 |cut -f 1 -d '.') #first section get all the -loglik values in file, all letters are then removed, then the final number is removed because that it a repeat, then order them using sort.
   
   #Initialize variables to keep count out number less than 3440,3450,and 3460
   under3460=0 # Counts less than 3460
   under3450=0 # Counts less than 3450
   under3440=0 # Counts less than 3440 

   # loop will run through ten numbers in the -loglik under variable
   for number in $under
   do

   if [ $number -lt 3440 ] #if less than 3440 then all variables get plus 1 count
   then
   ((under3460++))
   ((under3450++))
   ((under3440++))
   elif [ $number -lt 3450 ] #if less than 3450 then two variables get plus 1 count
   then
   ((under3460++))
   ((under3450++))
   elif [ $number -lt 3460 ] #if less than 3460 then one variables get plus 1 count
   then
   ((under3460++))
   fi 
   done

    # Output the data in csv format
    echo "$rootName, $hMax $elapsedTime, $Nruns, $Nfail, $fabs $frel $xabs $xrel, $seed, $under3460, $under3450, $under3440" >> $saveFileloc
    
done 
