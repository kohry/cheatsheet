#install.packages("class") #using knn

library(dplyr)
library(ggplot2)
library(class)

# Summarize data
summary(mtcars)

# length
nrow(mat)
ncol(mat)
length(mat)

# sampling
set.seed(100)
sample(1:100, 5, replace = T)
train = iris[c(1,3,100),2]
ind1 = sample(1:a, a*0.7, )

# sampling
library(sampling)
library(doBy)
ind2 <- sampleBy ( ~ Species, data = iris, frac=c(0.1), syetematic = T)

ind3 = strata(iris, 'Species', c(7,5,3), 'srswor')
getdata(iris,ind3)

# dplyr styled str
glimpse(mtcars)

# Pre-processing
sum(complete.cases(mtcars) == T)

# dplyr summarize
mtcars %>% group_by(cyl) %>% summarise(mean(gear))


#Modeling

# Linear Regression Model
lm(cyl ~ am + gear, data=mtcars)

# knn #install.packages("class") #library(class)
knn(cyl)

# kmeans
kmeans(mtcars, 3)

# Plotting

# ggplot - histogram
ggplot(mtcars) + geom_histogram(aes(x=cyl), binwidth = 10)
ggplot(mtcars) + geom_point(aes(x=cyl, y=gear), colour = "red")
