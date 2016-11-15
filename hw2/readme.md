# stat679work
This folder will contain all the work for hw2 and the data from hw2. I have the data loaded onto my local machine from the course github website run by Cecil. The two files used for this hw are `energy.csv` and `waterTemperature.csv` which contain energy data obtained by two different methods. The goal of this hw was to take two seperate files and merge together the imporatant information into a csv file. 

To run the Python script `MergeFiles.py` you need to run it in the folder with the two .csv files. This was created using python 3.5

Once the scipt is run command the following promts will appear asking for:

"Enter Energy Filename: " 
"Enter Temperature Filename: "
"Do you want to append to a file? (yes/no)  "
"Please enter appended file name:" or "Please enter new file name:"

The inpur for a new file would look like the following.

Enter Energy Filename:energy.csv
Enter Temperature Filename:waterTemperature.csv
Do you want to append to a file? (yes/no)  no
Please enter new file name:NewOut.csv

This will create a NewOut.csv merged output file.

The function utilizes the pythons ability for numpy arrays and boolean operators. For small files this will not cause any big issues. This format could cause increase in processing time depending on input file sizes. The other options for updating could be to read two lines in at a time for comparison not usign a numpy array approach this would decrease the amount of data being used at one time but increase the read in and writing out functions. 
 




