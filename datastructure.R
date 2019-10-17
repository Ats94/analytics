#Datastructures in R




#Vectors ---------------------

v1 = 10
v1
print(v1)
v2 = 1:100
(v3 = c(1,5,4,10))   #create and print
v4 = seq(1,100,5)
v4

v5 = c('A', 'Dhiraj', 'IIFT')
V5

(V6<-1:100000)
v = rnorm(100, mean = 60, sd =10)
v
print(mean(v))
sd(v)
summary(v)
plot(v)
hist(v)
sort(v)
sort(v, decreasing=TRUE)




#Matrix
data = 100:111
data
length(100:111)
matrix(1,ncol=3, nrow=4)
(m1 = matrix(data, nrow=4))
(m2 = matrix(100:111, ncol=3, byrow=T))
m2[1,] #row
m2[,1] #column
m2[1,3]

rowSums(m2)

table(mtcars$cyl)
t1 = table(mtcars$cyl, mtcars$gear, dnn = c('cyl', 'gear'))
t1

margin.table(t1)
margin.table(t1, margin=1) #row cylinder
margin.table(t1, margin=2) #col gear

addmargins(t1) # col row sums
addmargins(t1, FUN=list(list(mean, sum, sd), list(sd, var)))
m2
sweep(m2, MARGIN=1, STATS=c(1,2,3,4), FUN = '+')
sweep(m2, MARGIN=2, STATS=c(3,3,3), FUN = '*')



#dataframes

mtcars
data()
AirPassengers
class(mtcars)
head(mtcars,n=3) #top 3 rows
dim(mtcars) 
names(mtcars) #names of column
rownames(mtcars)
summary(mtcars)


#summarising / filter data from DF
mtcars[mtcars$gear == 4,]
mtcars[ mtcars$gears == 4 & mtcars$mpg < 25, c('mpg', 'gear', 'cyl')]
mtcars
mtcars[order(mtcars$mpg),]
head(mtcars)
mtcars[row.names(mtcars)=='Mazda RX4', ]
mtcars[c(1,3,4), c(1.5)]


#export to csv
mtcars
write.csv(mtcars,'atul.csv')
df1=read.csv('atul.csv')
head(df1)
names(df1)
ncol(df1)

write.csv(mtcars,'atul1.csv',row.names=F) #to remove row names as extra column name
df2=read.csv('atul1.csv')
head(df2)
(carnames = paste('car', 1:32, sep='-'))
df2$cars=carnames #add extra column in Dataframes
head(df2)


#create dataframes from scratch
#roll no, name, gender, marks, grade

rollno = 1:30
rollno
(name=paste('stu',1:30))
rep(c('M','F'),c(12,18))
setseed(123)
(gender = sample(c('M','F'), size=30, replace=T, prob=c(.6,.4)))
table(gender)
prop.table(table(gender)) #percentage


marks = runif(30, min=50, max=100) #uniform distribution
marks

x= c(14.44,-14.76, 14.98)
x
trunc(x) #removes decimal
round(x) 
floor(x) #lowervalue
ceiling(x) #uppervalue

grades =sample(c('A','B','C'), size = 30, replace= T, prob=c(.3,.45,.25))
grades



students = data.frame(rollno, name, gender, marks, grades)
head(students)
str(students)
summary(students)
students$grades =factor(students$grades, ordered=T)
students$grades
students$grades =factor(students$grades, ordered=T, levels=c('C','B','A'))
barplot(table(students$grades), col =1:3)
hist(students$marks)
range(students$marks)
hist(students$marks, breaks=c(0,70,90,100))


students[students$marks > 70 & students$gender == 'M', ]


#library(dplyr)
#install.packages(dplyr)
