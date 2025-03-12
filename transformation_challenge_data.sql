use staging
go

/*one file for the transformation query with the object creation portion for ease of exercise. also only using staging database for destination just for the exercise.*/
create table lrs.service_customer_data (
    Service_ID nvarchar(20) not null primary key
    ,Customer_ID nvarchar(20) not null	
    ,Customer_Type nvarchar(100)	
    ,Service_Type nvarchar(100)	
    ,Waste_Type	nvarchar(100)
    ,Service_Date date	
    ,Location nvarchar(100)	
    ,Service_Cost numeric(7,2)	
    ,Collection_Time_Minutes int	
    ,Request_Count int 	
    ,Customer_Name nvarchar(100)
    ,Email nvarchar(100)
    ,Phone_Number nvarchar(100)

)


;with data as(
    select 
        Customer_ID	
        ,Service_ID
        ,Customer_Type
        ,Service_Type
        ,Waste_Type
        ,cast(Service_Date as date) as Service_Date
        ,Location
        ,cast(Service_Cost as numeric(7,2)) as Service_Cost
        ,cast(Collection_Time_Minutes as int) as Collection_Time_Minutes	
        ,cast(Request_Count as int) as Request_Count
        ,isnull(Customer_Name,	
            replace(
                left(
                        iif(isnull(Email,'x') like '%@example.com',Email,reverse(Email))
                        ,charindex('@',iif(isnull(Email,'x') like '%@example.com',Email,reverse(Email)),1)-1
                    )
                ,'.', ' '
            )
        ) as Customer_Name 
        ,iif(isnull(Email,'x') like '%@example.com',Email,reverse(Email)) as Email
        ,format(
            cast(
                (case when left(replace(replace(replace(Phone_Number,'(',''),')',''),'-',''),1) = 1 then null
            else replace(replace(replace(Phone_Number,'(',''),')',''),'-','') end) as numeric)        
            ,'###-###-####') as Phone_Number
    from lrs.service_customer
)

insert into lrs.service_customer_data 
/*did not define columns for insert, would be a 1 to 1 on columns being inserted into.*/

select 
    Service_ID
    ,Customer_ID	
    ,Customer_Type	
    ,Service_Type	
    ,Waste_Type	
    ,Service_Date	
    ,Location	
    ,Service_Cost	
    ,Collection_Time_Minutes	
    ,Request_Count	
    ,iif(Customer_Name in  ('sivaD ylimE','sivaD treboR','zenitraM semaJ','smailliW treboR','nosnhoJ haraS','htimS treboR'),
        reverse(Customer_Name),Customer_Name) as Customer_Name --used the cte to do this part because the transformation logic on the inner query was getting beefy, easier to parse this way.
    ,Email	
    ,Phone_Number
from data

select * from lrs.service_customer_data