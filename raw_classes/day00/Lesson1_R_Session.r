# This dataset represents pedestrian walking speed vs urban population density
# we want to predict walking speed from population
# 
# IMPORTANT: setwd changes the working directory. 
# All file references will be relative to this path
setwd("/Users/tomaspica/Documents/DataScience/day00")

# Loads the package 'ggplot2'
# You may have to install a package, but 'ggplot2' is a core one
library(ggplot2)

# Creates a data frame 
# (is really just a table: one or more variables and a bunch
# of instances of those variables)
# It has a header, set to T (True)
# and assigns to variable x (that's the left arrow assignment)
#
# Go crazy with help(read.csv)
x <- read.csv('pace.txt', header=T)

# Returns the first parts of a vector, matrix, table, data frame, or function
# Defaults to 6 head(x, [n=number_of_lines])
head(x)

# a 2d scatterplot of the data shows an obviously nonlinear relationship
# aes (aesthetics), give the axis as in the data frame
# + geom_point() (default black circle), but you can add more layers after with functions
ggplot(x, aes(y=speed, x=pop)) + geom_point()

# fitting a linear model to this dataset produces significant coeffs with an R-squared of ~43%, which is not bad
# but based on the shape of the data, we can probably do better
linear.fit <- lm(pop ~ speed, data=x)

# check out 'R-squared', along with more stuff with this
summary(linear.fit)

# Call:
# pop is dependend on speed, data = dataframe
lm(formula = pop ~ speed, data = x)
# really useful to have a look at your dataframes

# Remember:
# Residuals = distance of the points to the fitting line (the linear model)

#Residuals:
#     Min       1Q   Median       3Q      Max
#-1.42046 -0.51769 -0.00158  0.65962  1.13502
#
#Coefficients:
#            Estimate Std. Error t value Pr(>|t|)
#(Intercept)   3.6880     0.2778  13.275 6.17e-09 ***
#speed         0.9672     0.3094   3.126  0.00803 **
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

#Residual standard error: 0.8205 on 13 degrees of freedom
#Multiple R-squared: 0.4292,	Adjusted R-squared: 0.3853
#F-statistic: 9.774 on 1 and 13 DF,  p-value: 0.008029

# the model explains ~43% of the variance of the data
# it's a key to judge linear models

# this scatterplot shows the relationship after a log-log transformation
# based on this (and the previous) plot, we should expect the transformed data to produce a better linear fit
ggplot(x, aes(y=log(speed), x=log(pop))) + geom_point()

#why is this true? because the nonlinear relationship we saw before is an example of a "power law"; eg,

#	y = x ^ b

#the log-log transformation maps this nonlinear relationship to a linear relationship,
#effectively transforming the complicated problem to a simpler problem
#Logarithm - http://en.wikipedia.org/wiki/Logarithm#Logarithmic_identities 
#	log(y) = log(x^b)
#	--> log(y) = b * log(x)
#	--> y' = b * x'

#this is a linear fit on the transformed variables...note that R-squared has nearly doubled
log.fit <- lm(log(speed) ~ log(pop), data=x)
summary(log.fit)

#Call:
lm(formula = log(speed) ~ log(pop), data = x)

#Residuals:
#    Min      1Q  Median      3Q     Max
#-2.2927 -0.7014 -0.1421  0.8201  2.4433

#            Estimate Std. Error t value Pr(>|t|)
#Coefficients:
#(Intercept)  -14.571      1.812  -8.041 2.11e-06 ***
#log(pop)       8.814      1.259   6.999 9.35e-06 ***
#---

#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#Residual standard error: 1.27 on 13 degrees of freedom
#Multiple R-squared: 0.7903,	Adjusted R-squared: 0.7742
#F-statistic: 48.99 on 1 and 13 DF,  p-value: 9.35e-06

#this kind of manuever (mapping a nonlinear problem to a linear problem) is an important technique
#and will come up again later in the context of classification (buzzword: support vector machine)
