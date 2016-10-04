#!/bin/bash
# This script will rename the .log and .out files to the normalized names
for filename in $(ls timetest* | tail -n 9)
do
    ending=$(echo $filename | tail -c 11)	# Finds the ending so can be .log or .out
    mv $filename timetest0$ending		# renames the files so they are all normalized
    
done

