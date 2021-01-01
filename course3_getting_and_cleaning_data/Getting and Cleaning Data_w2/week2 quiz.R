
#######################QUESTION 1#############################


#1) your app knocks and says "I am this guy, you have my name (Client ID) on 
#the guest list and I know my password"; 

#2) github checks if that's true and then gives you a pass (called token),
#giving your app some kind of access to his premises; 

#3) your app then requests the info, showing its pass. 
#While there is a slightly confusing part in Hadley's tutorial, 
#that's what it means (basically using his code with 
#slight adjustment at the start):

myapp <- oauth_app("github", "3206264ebdcf78d3ed63", "138c33ddf1d10d93a96235973e822629b54f8c07")
# store the credentials we got from github for our app in the myapp variable

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
# go knock on github's door (which is located at oauth_endpoints("github")) and show our credentials (myapp). They give us a token that we store in the variable github_token

gtoken <- config(token = github_token)
# before we go on and request information we need to wrap the token we just got in a new variable using the config function so we can show the server we already got our pass when requesting information

req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
# finally we ask github about what we came for; we should replace this url with the url we are interested in, in our case where the info about Jeff Leek's repositories is located; the response we got is stored in the req variable and in this case it will come in the JSON format

# let's just make sure everything went right

##6) Now we can check what response github gave us checking the content of the req variable and trying to make sense of that JSON thing they sent back
json1=content(req)
json2 = jsonlite::fromJSON(toJSON(json1))

select(json2 , git_url   , created_at)


######################QUESTION 2####################

install.packages("sqldf")
install.packages("gsubfn")
install.packages("proto")
install.packages("RSQLite") 
install.packages("DBI")



library("sqldf")


setwd ("C://Users//Sara//Desktop//Sara")
dir.create("Getting and Cleaning Data_w2")

fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, dest=".//Getting and Cleaning Data_w2//Quiz2.csv")

acs<-read.csv(".//Getting and Cleaning Data_w2//Quiz2.csv")

x<-sqldf("select * from acs where AGEP < 50 and pwgtp1")
y<-sqldf("select pwgtp1 from acs where AGEP < 50")

#######################QUESTION 3###################
sqldf("select distinct pwgtp1 from acs")
sqldf("select AGEP where unique from acs")
sqldf("select distinct AGEP from acs")
sqldf("select unique * from acs")

####################QUESTION 4####################

con = url("http://biostat.jhsph.edu/~jleek/contact.html ")
htmlCode = readLines(con)
close(con)
htmlCode
nchar(htmlCode[10], type="chars")
nchar(htmlCode[20], type="chars")
nchar(htmlCode[30], type="chars")
nchar(htmlCode[100], type="chars")

##################QUESTION 5 #####################

fileUrl2<-"https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"

download.file(fileUrl2, dest=".//Getting and Cleaning Data_w2//Quiz2_5.for")

mydata_5<-read.fwf(fileUrl2, c(14,5,8,5,8,5,8,5,8), header = FALSE, skip = 4)
sum(mydata_5[4])
