#reshape





#missing values

v1 =c(1,2,3,5)
is.na(v1)

v2=c(1,NA,3,NA,5)
is.na(v2)
sum(is.na(v2))


library(VIM)

library(reshape2)
(rollno = 1:30)
sub1 =rnorm(30, mean=50, sd=10)
sub2 = rnorm(30,65,12)
sub3 = runif(30, min=50, max=90)
gender = sample(c('M','F'), size=30, replace=T)
gender
exam =data.frame(rollno,gender,sub1,sub2,sub3)

exam[1:5,-1] #-1 --- skip first column
head(exam)
#colMeans(exam[,-1])
#rowSums(exam[,-1]) # without gender
colMeans(exam[,-c(1,2)])
rowSums(exam[,-c(1,2)])

exam %>% mutate(totalmarks = sub1+sub2+sub3) %>% head() #adding extra column of total marks of each student

#longdata = melt(exam,id.vars='rollno')
head(longdata)
dim(longdata)

#converting wide to long
longdata = melt(exam,id.vars='rollno', variable.name='subject', value.name='marks')# changing column name
longdata = melt(exam,id.vars='rollno','gender', variable.name='subject', value.name='marks')# changing column name


longdata %>% group_by(subject) %>% summarise(mean(marks), max(marks), min(marks), sd(marks))



#convert long to wide

#widedata = dcast(longdata, rollno ~ subject)
widedata = dcast(longdata, rollno + gender ~ subject)
head(widedata)



#missing values

data(sleep)
dim(sleep)
str(sleep)
is.na(sleep)
sum(is.na(sleep))
rowSums(is.na(sleep)) #how many data is missing in row
#df=sleep
#df$missing = rowSums(is.na(sleep))
#head(df)


colSums(is.na(sleep)) #how many data is missing in column
v4 = c(1,5,NA,6,NA)
is.na(v4)
mean(v4,na.rm=T) # TO cal mean when there is missing values
v4[is.na(v4)] = mean(v4, na.rm=T)# INSERTS mean values in place of missing
v4

v4[is.na(v4)] = min(v4,na.rm=T)
V4

complete.cases(sleep) # tells which rows have all values present i.e no missing values
sum(complete.cases(sleep)) #count
sleep[complete.cases(sleep),]
sleep[rep(T,)]

