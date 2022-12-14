-- Build fact trips  need to update trip information with each run with changed data
-- One record per each trip
Declare @lastloaddate as datetime;
Set @lastloaddate = GetDate()-1; -- Assuming ETL runs daily. Ideally this variable is stored in Scheduling tool. This is last ETL_Load_date. Better way to handle job failures.
--Select @lastloaddate

--New trip information since last loadtime
With new As (
		Select trip_id ,  
			   Min(case when event_type = 'ride_start' then driver_id end) as  driver_id,
			   Min(case when event_type = 'ride_request' then rider_id end) as  rider_id,
			   Min(case when event_type = 'ride_start' then car_id end) as  car_id,
			   Min(case when event_type = 'ride_request' then location_id end) as  Request_locaiton_id, 
			   Min(case when event_type = 'ride_start' then location_id end) as  Start_location_id,
			   Min(case when event_type = 'ride_accept' then location_id end) as  Accept_location_id,
			   Min(case when event_type = 'ride_end' then location_id end) as  End_locaiton_id,
			   Min(case when event_type = 'ride_request' then ts end) as  Request_ts,
			   Min(case when event_type = 'ride_start' then ts end) as  Start_ts,
			   Min(case when event_type = 'ride_accept' then ts end) as  Accept_ts,
			   Min(case when event_type = 'ride_end' then ts end) as  End_ts,
			   Min(case when event_type = 'payment' then event_value end) as  Payment_amount,
			   Min(case when event_type = 'Tip_Paid' then event_value end) as  Tip_amount,
			   Min(case when event_type = 'Driver_rating' then event_value end) as  Driver_rating,
			   Min(case when event_type = 'Customer_rating' then event_value end) as  Customer_rating
		from log.trip_activity
		Where ts > @lastloaddate
		Group by trip_id )

--- Insert new records -- If there is no match in the existing table consider it as new trip and insert. 
Insert into edw.fact_trips
Select A.*
from new As A 
	Left outer join  edw.fact_trips As old	on A.trip_id = Old.trip_id
Where old.trip_id IS NULL 

--updating old records - If there is a match in the existing table consider it as update and update
Select A.*
from new As A 
	Inner join  edw.fact_trips As old	on A.trip_id = Old.trip_id

-- Delete some times if the source data gets deleted -- not a typical use case. 


---Since updating record is very expensive on such large scale data, It is better to create a new fact_table, drop the old table and rename new table 
Insert into edw.fact_trips_new
Select Coalesce (A.trip_id, Old.trip_id) As trip_id,
		Coalesce (A.Driver_id, Old.Driver_id) As Driver_id,
		Coalesce (A.rider_id, Old.rider_id) As rider_id,
		Coalesce (A.car_id, Old.car_id) As car_id,
		Coalesce (A.Request_locaiton_id, Old.Request_locaiton_id) As Request_locaiton_id,
		Coalesce (A.Start_location_id, Old.Start_location_id) As Start_location_id,
		Coalesce (A.Accept_location_id, Old.Accept_location_id) As Accept_location_id,
		Coalesce (A.End_locaiton_id, Old.End_locaiton_id) As End_locaiton_id,
		Coalesce (A.Request_ts, Old.Request_ts) As Request_ts,
		Coalesce (A.Accept_ts, Old.Accept_ts) As Accept_ts,
		Coalesce (A.End_ts, Old.End_ts) As End_ts,
		Coalesce (A.Payment_amount, Old.Payment_amount) As Payment_amount,
		Coalesce (A.Tip_amount, Old.Tip_amount) As Tip_amount,
		Coalesce (A.Driver_rating, Old.Driver_rating) As Driver_rating,
		Coalesce (A.Customer_rating, Old.Customer_rating) As Customer_rating,
from new As A 
	Full outer join  edw.fact_trips As old	on A.trip_id = Old.trip_id;


Drop table edw.fact_trips; 
EXEC sp_rename 'edw.fact_trips_new', 'edw.fact_trips_new';




