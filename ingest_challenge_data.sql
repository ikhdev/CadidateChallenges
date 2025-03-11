use staging
go

/*this is written as a one off for the sake of this challenge, so consideration isn't being given for regular ingestion or error handling. everything is in one file for ease of review*/

/*schema for idenitifcation of entity source. run solo*/
create schema lrs authorization dbo

/*table to ingest raw data. all nvarchar(max) to avoid data type issues upon ingestion. transformation/cleaning handled post-staging*/
create table lrs.service_customer 

(
     Service_ID  nvarchar(max)
    ,Customer_Type nvarchar(max)
    ,Service_Type nvarchar(max)
    ,Location nvarchar(max)
    ,Waste_Type nvarchar(max)
    ,Service_Cost nvarchar(max)
    ,Service_Date nvarchar(max)
    ,Collection_Time_Minutes nvarchar(max)
    ,Request_Count nvarchar(max)
    ,Customer_ID nvarchar(max)
    ,Customer_Name nvarchar(max)
    ,Email nvarchar(max)
    ,Phone_Number nvarchar(max)
)

/*insert raw data from csv*/
bulk insert lrs.service_customer 
from 'X:\CadidateChallenges\Enhanced_Garbage_Collection_Services_Dataset.csv'

with(
    firstrow = 2,  -- If header row is present in the CSV
    fieldterminator = ',', 
    rowterminator = '\n'
)

/*make sure data populates*/
select * from lrs.service_customer


