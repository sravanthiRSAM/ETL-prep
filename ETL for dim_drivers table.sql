--runs every day

--new info
Declare @lastloaddate as datetime;
Set @lastloaddate = GetDate()-30; -- scheduing app will have this. Using getdate for assumption. This won't handle job failure scenarios. Processing 30 days data to address num_trips in last 30 days.
Select @lastloaddate

with new As  (
	Select driver_id, 
		-- Max Account creation date - Where Event_type = Create_account - timestamp
		Max(Case when event_type = 'create_acount' then ts end) As Account_creation_Date,
		-- Last trip date = Max(timestamp) where event_type = Ride end - timestamp
		Max(Case when event_type = 'ride_start' then ts end) As Last_tripdate,
		--no. of trips = Count() where event_type = ride_accept 
		Sum(case when event_type = 'ride_start' and ts > getdate()-1 then 1 else 0 end) As Num_of_trips,
		Sum(case when event_type = 'ride_start' and ts > getdate()-7  then 1 else 0 end) As Num_of_trips_7,
		Sum(case when event_type = 'ride_start'  then 1 else 0 end) As Num_of_trips_30
	from log.driver_activity AS A		
	Where ts > @lastloaddate
	group by driver_id)
	   
Insert into new_dim_driver
Select  Coalesce (A.driver_id, B.driver_id) As driver_id,
		Coalesce (B.Account_creation_Date, A.Account_creation_Date) As Account_creation_Date,
		Coalesce (B.Last_tripdate, A.Last_tripdate) As Last_tripdate, 
		IsNUll(A.Num_of_trips,0) + Isnull(B.Num_of_trips,0) As Num_of_trips, 
		--last 7 days trips
		Isnull(B.Num_of_trips_7,0) As Num_of_trips_7,
		Isnull(B.Num_of_trips_30,0) As Num_of_trips_30
from edw.dim_driver As A
	Full outer join new As B			on A.driver_id = B.driver_id;

drop table edw.dim_driver;

EXEC sp_rename 'edw.new_dim_driver', 'edw.dim_driver';


