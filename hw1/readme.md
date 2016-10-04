# stat679work
This folder will contain all the work for hw1 and the data from hw1. I have the data loaded onto my local machine in a folder called course data. I moved hw1-snaqTimeTests to this folder using the following command

move data to folder
cp -R ~/Desktop/STATS/coursedata/hw1-snaqTimeTests ~/Desktop/STATS/statWORK679/hw1

This data may be changed after I complete the asignment using them.

normalizeFileNames.sh will rename the files to add 0 before the single digit file names. To use this script go into the log of out directory and then run normalizeFileNames.sh in the command line. The single digit names will now have a zero added
normalize files
~/Desktop/STATS/statWORK679/hw1/normalizeFileNames.sh

summarizeSNaQres.sh will take the files and complete a quick analysis on the all the log and out files.To run this function go to the parent directory of the log and out file folders. Then type summarizeSNaQres.sh. A .csv file will be created will three parameters of interest included in the file.
create analysis file
~/Desktop/STATS/statWORK679/hw1/summarizeSNaQres.sh


