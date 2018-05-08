#install.packages("class") #using knn

library(dplyr)
library(ggplot2)
library(class)


# Summarize data
summary(mtcars)

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
