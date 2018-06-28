Course 3 Final Project
June 2018

This project creates a tidy dataset from the "Human Activity Recognition Using Smartphones Data Set" available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The following steps are taken to make a tidy dataset:

1. The script merges the training and test datasets provided in the above dataset.

2. The mean and standard deviation of the measurements were extracted from the dataset. Included measurements were required to have both a mean and standard deviation available. Therefore, measurements with only a mean calculation (i.e. meanFreq) were not included.

3. The activities were given descriptive names:
	walking,
	walking upstairs,
	walking downstairs,
	sitting,
	standing,
	laying

4. The measurements for each activity were given descriptive names. The measurements  included are listed in the codebook under Feature Selection.

5. A tidy dataset with the average of each variable for each activity and each subject. This tidy dataset is written to a file called tidy_mean.txt.

To run the script:

Download the run_script.R file and zip folder containing the dataset, available below. Set the working directory to the folder containing the dataset. Run script.

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
