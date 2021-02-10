# Eclat <- simplified Apriori (respect 'Support') 

# install.packages("arules")
library(arules) # for Eclat as we respect support in Apriori 

# import data without columns 
# read.csv: sep = ',' is a default 
dataset = read.csv('Market_Basket_Optimisation.csv', header = FALSE)

# create sparse matrix (contains very few non-zero elements): 
# need to reduce duplicates from the dataset
# sep = ',' because , is separate signs in csv, read.transactions does NOT have sep = ',' as a default 
dataset = read.transactions('Market_Basket_Optimisation.csv', sep = ',', rm.duplicates = TRUE)

# distribution of transactions with duplicates:
# 1 = duplicate, 2 = triplicate  
# 5 = 5 duplicates

summary(dataset)
# a density of 0.03288973 is non-zero values are 0.03% = 97% is 0

#    1    2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   18   19   20 
# 1754 1358 1044  816  667  493  391  324  259  139  102   67   40   22   17    4    1    2    1
# 1754 rows are only 1 column, 1358 rows are only 2 columns and so on 

itemFrequencyPlot(dataset, topN = 10, col="#69b3a2")
# itemFrequencyPlot(x, topN = Only plot the topN items with the highest item frequency)

# train/fit the dataset
# support: 3 items (mean 3.914) * 7 days / length of dataset
# (length(dataset)-1) original was 7500 and header = FALSE made 7501 -> [0 rule(s)] too strict
# confidence is 0.8 (default) might affect results
rules = apriori(dataset, parameter = list(support = 0.001, minlen = 2))


# visualizing the rules top 10 by support as Eclat
inspect(sort(rules, by = 'support')[1:10])