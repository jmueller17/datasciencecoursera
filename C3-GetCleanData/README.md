Readme - Peer Assignment - Coursera Getting and Cleaning Data May 2014
========================================================

The following repository contains the file for the Peer Project of Coursera's "Getting and Cleaning Data" by Jeff Leek, May 2014. It works with the Human Activity Recognition Using Smartphones Dataset Version 1.0. 

The repository consists of the following files: 
----------------------------------------------

* run_analysis.R  - the R script combining and cleaning the raw data of the Smartphone Dataset
* CodeBook.md     - a description of the data and variables and an explanation of the internal workings of the script
* README.md       - this file, explaning how to run the analysis. 


How to run the script
---------------------

1. Download or clone this repostitory to your local machine

2. Download the Human Activity Recognition Using Smartphones Dataset Version 1.0 from the UCI Machine Learning Repository under the follwing URL: http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip Unzip the folder into the same location where your run_analysis.R script resides and rename its top level folder to "data/"

3. Open the run_analysis.R script in R. Set your working directory to your local repository folder and source the script. 

4. The script will run its analysis and transformations, producing in the end a new file called "dftidy.csv"


