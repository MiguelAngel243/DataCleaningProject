# DataCleaningProject
For process the data the following pipeline is followed: (Resulting tidy dataset: df)
--Download zip file
--Unzip
--Load tables of:
  Data records with 561 variables each, train and test, both.
  Column with labels of activity of each record
  Row with labels of columns
--Convert numbers to respective activity on label column, with factors
--Adjunt activity column with data frame containing 561 variables
--Join both train and test data tables
--Filter columns of interest (mean and std related) 
--Unfold abbreviations on column names, separate word with periods, lowerize words and remove (),-

For dataframe two: (Resulting tidy dataset: dt2)
--Load column tables containing info about the subject of every record
--Join subject column with dataframe 
--Add subject column name
--Group resulting dataframe by subject and activity
--Calculate mean of every column by grouping

  
