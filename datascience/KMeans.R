#Kmeans Clustering

getwd()
#install.packages("dplyr")
library(dplyr)

PATH <-"F:/R_CBAP/codes/analytics/datascience/Computers.csv"
#PATH <-""F:\\R_CBAP\\codes\\analytics\\datascience\\Computers.csv"
df<- read.csv(PATH)

head(df,10)

view(df)
#%>% pipe operator
#cannot deploy clustering on categorial data only on numercial data
df <- read.csv(PATH) %>%
  select(-c(X, cd, multi, premium)) # -c --  remove columns from dataset
glimpse(df)

summary(df)
#from summary we saw that variable are not  on same scale price min 900, ram min 2,etc
#so there is need for standardisation (scale) converting value to z score
#preparing data for model

 #rescale the variables with the scale() function of the dplyr library.

rescale_df <- df %>%
  mutate(price_scal = scale(price),
         hd_scal = scale(hd),
         ram_scal = scale(ram),
         speed_scal = scale(speed),
         screen_scal = scale(screen),
         ads_scal = scale(ads),
         trend_scal = scale(trend)) %>%
  select(-c(price, speed, hd, ram, screen, ads, trend))

rescale_df

# kmeans(df, k)
# arguments:
#   -df: dataset used to run the algorithm
# -k: Number of clusters


# The list pc_cluster contains seven interesting elements:
# pc_cluster$cluster: Indicates the cluster of each observation
# pc_cluster$centers: The cluster centres
# pc_cluster$totss: The total sum of squares
# pc_cluster$withinss: Within sum of square. The number of components return is equal to `k`
# pc_cluster$tot.withinss: Sum of withinss
# pc_clusterbetweenss: Total sum of square minus Within sum of square
# pc_cluster$size: Number of observation within each cluster

##Optimal value of K
#Elbow mwthod is used the explain the variance by each cluster number


################################################################################3
# You can construct the elbow graph and find the optimal k as follow:
#   
# Step 1: Construct a function to compute the total within clusters sum of squares
# Step 2: Run the algorithm n times
# Step 3: Create a data frame with the results of the algorithm
# Step 4: Plot the results


#Step 1) Construct a function to compute the total within clusters sum of squares

kmean_withinss <- function(k) {
  cluster <- kmeans(rescale_df, k)
  return (cluster$tot.withinss)
}

#You can test the function with equals 5
kmean_withinss(2) #gives error value 

#Step 2 - Run the algorithm n times



# Set maximum cluster 
max_k <-25 
# Run algorithm over a range of k 
#sapply - for loop 
wss <- sapply(2:max_k, kmean_withinss)
wss
elbow <-data.frame(2:max_k, wss)
elbow
library(ggplot2)

#Plot the graph to visualize where is the elbow point
# Plot the graph with gglop x2.max_k, wss are names of column in table elbow
ggplot(elbow, aes(x = X2.max_k, y = wss)) +
  geom_point() +
  geom_line() +
  scale_x_continuous(breaks = seq(1, 25, by = 1))

##8 is more optimal value of K from graph

#Examining the cluster 10 clusters
pc_cluster_2 <-kmeans(rescale_df, 10)


pc_cluster_2$cluster #show cluster number of each row
pc_cluster_2$centers # -ve value in price column shows price sensitive cluster
pc_cluster_2$size # no of customers in each cluster

#attaching result with the original data
result <- cbind(df,pc_cluster_2$cluster) 
tail(result)

write.csv(result,"F:/R_CBAP/codes/analytics/datascience/cluster_result.csv")
