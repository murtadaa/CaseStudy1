
#################################################################
R.version 

library(ggplot2)
library(plyr)


setwd("C:\\Users\\Murtada\\Desktop\\SMU DATA SCIENCE\\2017 MAY TERM\\Doing Data Science\\CASE STUDY 1\\GitHub\\CaseStudy1")

beers<- read.csv("C:\\Users\\Murtada\\Desktop\\SMU DATA SCIENCE\\2017 MAY TERM\\Doing Data Science\\CASE STUDY 1\\GitHub\\RawData\\Beers.csv")
breweries<- read.csv("C:\\Users\\Murtada\\Desktop\\SMU DATA SCIENCE\\2017 MAY TERM\\Doing Data Science\\CASE STUDY 1\\GitHub\\RawData\\Breweries.csv")



##1
##The following displays how many breweries are present in each state.
##We have states like WV, SD, DC that have one brewery and other heavy
##hitters like CA, MI, and CO. The code bellow elegantly uses the variable
##to summarize how many breweries are in in the data set. 

summary(breweries$State)



## Number 2 
##As we can see, the two data sets are merged bellow by the brewery id. 
##The first and last 6 observations are printed to verify the merging. 
##The merge function is used to merge both data sets and the head/tail
##function is used to display the first 6 and last 6 observations. 



Merg<-merge(x=breweries, y=beers, by.x="Brew_ID", by.y="Brewery_id", all=TRUE)
#####################First 6 Observations
head(Merg)
#####################Last 6 Observations 
tail(Merg)



##3
##The number of NA's in each column are as following: 
##In ABV there are 62 NA's. 
##in IBU there are 1005 NA's
colSums(is.na(Merg))

##4 
##The following computes the median alcohol content and international
##bitterness unit for each state. The bar graph is a visual representation of the data. 

MedABV <- aggregate(ABV ~State, data =Merg, FUN = median)
MedIBU <- aggregate(IBU ~State, data =Merg, FUN = median)

##ggplot(MedABV, aes(y=ABV.median, x=State)) + geom_bar(stat="identity")

ggplot(data = MedABV,aes(State, ABV,fill=ABV)) +geom_bar(color="black",stat = "identity")+theme(text=element_text(size=15))
ggplot(data = MedIBU,aes(State, IBU,fill=IBU)) +geom_bar(color="black",stat = "identity")+theme(text=element_text(size=15))

##5
##From the following analysis we have determined Colorado has the maximum alcoholic beer. 
##Also from the same analysis we have determined Oregon has the most bitter beer. 
Merg[which.max(Merg$ABV),]
Merg[which.max(Merg$IBU),]

##6 
##The following displays the summary statistics for the ABV variable: 
summary(Merg$ABV)

##7 
##The following displays the relationship between the bitterness of the beer 
##and its alcoholic content using a scatter plot: 
Scattergraph <- ggplot(Merg, aes(IBU, ABV, label = State)) + geom_point(shape=1) +
  geom_smooth(method = lm) 
Scattergraph

##As the positive slope indicates, it appears that the more alcoholic 
##the beer is, the more bitter it becomes. 
