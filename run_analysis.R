# Check if the user has the "reshape2" package installed 
if(!library(reshape2, logical.return = TRUE)) {
  #install the package, and then load it
  install.packages('reshape2')
  library(reshape2)
}
# Initialization
targetFolder <- 'UCI HAR Dataset'
filename <- 'getdata_dataset.zip'

# Check unzipped file
if(!file.exists(targetFolder)) {
  # check file existence 
  if(!file.exists(filename)) {
    # Download the file
    download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',filename)
  }
  #unzip the file
  unzip(filename)
}

# --Merges into one data set
  # Read in the data into training sets
  test.data <- read.table(file.path(targetFolder, 'test', 'X_test.txt'))
  test.activities <- read.table(file.path(targetFolder, 'test', 'y_test.txt'))
  test.subjects <- read.table(file.path(targetFolder, 'test', 'subject_test.txt'))
  train.data <- read.table(file.path(targetFolder, 'train', 'X_train.txt'))
  train.activities <- read.table(file.path(targetFolder, 'train', 'y_train.txt'))
  train.subjects <- read.table(file.path(targetFolder, 'train', 'subject_train.txt'))
  # Bind the rowss
  data.data <- rbind(train.data, test.data)
  data.activities <- rbind(train.activities, test.activities)
  data.subjects <- rbind(train.subjects, test.subjects)
  # combine all columns into one table
  full_data <- cbind(data.subjects, data.activities, data.data)

# --Extract measurements on the mean and standard deviation 
  # list of features
  features <- read.table(file.path(targetFolder, 'features.txt'))
  # Filter on the features
  requiredFeatures <- features[grep('-(mean|std)\\(\\)', features[, 2 ]), 2]
  full_data <- full_data[, c(1, 2, requiredFeatures)]

#--descriptive activity names in the data set
  # Read in  activity labels
  activities <- read.table(file.path(targetFolder, 'activity_labels.txt'))
  # Update  activity name
  full_data[, 2] <- activities[full_data[,2], 2]
  
# --descriptive variable names. 
  colnames(full_data) <- c(
    'subject',
    'activity',
    # Remove the brackets from features 
    gsub('\\-|\\(|\\)', '', as.character(requiredFeatures))
  )
  # data strings
  full_data[, 2] <- as.character(full_data[, 2])
  
# -- create tidy data set with the average of each variable for each activity and each subject.
  final.melted <- melt(full_data, id = c('subject', 'activity'))
  final.mean <- dcast(final.melted, subject + activity ~ variable, mean)
  write.table(final.mean, file=file.path("tidy.txt"), row.names = FALSE, quote = FALSE)