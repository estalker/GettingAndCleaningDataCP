GettingAndCleaningDataCP
========================

function "readandmerge" takes one string parameter - default is "test", another variant is "train". Depends on this parameter
it loads datatables for train or test sets and merges in in dataset with activities and subjects. 


1. First of all run_analises.R downloads data from url.
2. It loads test data by readandmerge function
3. It loads train data by readandmerge function
4. It union test and train in one dataset
5. It load fratures and activity
6. It factorize subject column
7. It merges dataset and activity names to make it factor and clear to understand
8. It chooses only mean and std related variables
9. It cuts other variables exept subject and activity 
10. It aggregave values with mean() function by action and activity