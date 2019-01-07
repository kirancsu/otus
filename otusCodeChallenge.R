
#read the files from folder "data" with file format .tsv

fileNames <- list.files(path = 'data', pattern='*.tsv')

print(fileNames)

#install sqldf and dplyr packages for the very first time, 
#install.packages("sqldf")
library(sqldf)

#install.packages("dplyr")
library(dplyr)

#Initialize a data frame
dataset <- data.frame(matrix(ncol = 7,nrow = 1))
colnames(dataset) <- c("title", "categories","titleWords","linksOut", "numRequests", "bytesServed","fileName")

#unit test 
head(dataset)

#Loop throug the files in the data folder and create one big dataset
for(i in length(fileNames)){
  dataRawTemp <- read.csv(paste("data\\",fileNames[i],sep=""), sep = "\t",quote="", header=TRUE,  stringsAsFactors = FALSE)
  dataRawTemp$fileName <- fileNames[i]
  colnames(dataRawTemp) <- c("title", "categories","titleWords","linksOut", "numRequests", "bytesServed","fileName")
  dataset <- rbind(dataset,dataRawTemp)
}

#Unit testing, checking the data set load
#nrow(dataset)
#head(dataset, 3)  


#functions 
is.not.null <- function(x) !is.null(x)



#data cleansing....remove NA, NULLS and spaces
dataset$numRequests <- as.numeric(as.character(dataset$numRequests))
dataset$numRequests <- ifelse(is.na(dataset$numRequests), 0, dataset$numRequests)
dataset <- select(filter(dataset,dataset$categories!="NULL"), c("title", "categories","titleWords","linksOut", "numRequests", "bytesServed","fileName"))

#unit check to verify how many data points were filtered out
#nrow(dataset)

dataset <- subset(dataset, dataset$numRequests > 0)
categories <-  as.data.frame(dataset$categories)

#Unit testing
#nrow(dataset)
#nrow(categories)
#head(categories, 1)
#colnames(categories)

#Data is ready for operation

#order
orderedDataByNumRequests <- dataset[order(dataset$numRequests),c(1,2,5,7)]
colnames(orderedDataByNumRequests)

# step 1 Most requested article for that day
leastRequested <- head(orderedDataByNumRequests, 1)
print(paste("Least requested article of the day is: ",leastRequested$title, sep = ""))


# Step 2 Least requested article for that day
mostRequested <- tail(orderedDataByNumRequests, 1)
#mostRequested <- mostRequested[order(mostRequested$numRequests, decreasing = TRUE),c("title","numRequests")]

print(paste ("Most requested article of the day is: ", mostRequested$title, sep = ""))


# Step 3 Top 5 categories for that day

typeof(categories)

colnames(categories) <- c("catg")
cat_length <- nrow(categories)

#colnames(categories)
#initialize split catgeories data frame
splitCatgs <- data.frame(matrix(nrow = 1,ncol = 1))
colnames(splitCatgs) <- c("categories")
head(splitCatgs)

for(catLen in 1:cat_length){
  
  test1 <- categories[[1]][catLen]
  
  splitStr <- as.data.frame(strsplit(as.character(test1), split = " "))
  colnames(splitStr) <- c("categories")
  
  splitCatgs <- rbind(splitCatgs,splitStr)
  
}


#myTest <- head(categories,1)

#df <- data.frame(matrix(unlist(myTest)),stringsAsFactors=FALSE)
#head(df,1)

nrow(splitCatgs)
testing <- splitCatgs
testing$count <- as.integer(1)
df2 <- aggregate(testing[c("count")],by=list(testing$categories), FUN=sum, na.rm=TRUE)

colnames(df2) <- c("categories", "count")
orderedCatgByCount <- df2[order(df2$count,decreasing = TRUE),c(1,2)]

print("Top 5 categories for the day:")
head(orderedCatgByCount,5)


#show(df3)

#Step 4 Which hour had the most requests? How many? Which article?
print("Which hour had the most requests? How many? Which article?")
print(paste("The hour that has most requests is: ",mostRequested$fileName, sep=""))
print(paste("Number of requests in that hour: ", mostRequested$numRequests,sep = ""))
print(paste("Most requested Article of that hour: ", mostRequested$title,sep = ""))


#Step 5 Which hour had the least requests? How many? Which article?
print("Which hour had the least requests? How many? Which article?")
print(paste("The hour that has least requests is: ",leastRequested$fileName, sep=""))
print(paste("Number of requests in that hour: ", leastRequested$numRequests,sep = ""))
print(paste("Least requested Article of that hour: ", leastRequested$title,sep = ""))



