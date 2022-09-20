-- Avg time for trip per day 
Select	Cast(Start_ts As date) AS BusinessDate, 
		Avg(datediff(second,End_ts , Start_ts)) As Avg_trip_time_day
from [edw].[fact_trips]
where end_ts is not null  ---excluding trips that are not complete
group by Cast(Start_ts As date);


--Customer: avg wait time for a customer  (request time to start time)

Select	Cast(Start_ts As date) AS BusinessDate, 		
		Avg(datediff (second,Start_ts , Request_ts)) As Avg_wait_time
from [edw].[fact_trips]
where start_ts is not null --excluding trips that are not started
group by Cast(Start_ts As date);


--No. of drivers who spent at least 4 hours with passengers per day

Select	Cast(Start_ts As date) AS BusinessDate, 
		Driver_Id,		
		Sum(datediff (second,End_ts , Start_ts)) As Totaldrivetime
from [edw].[fact_trips]
where end_ts is not null --excluding trips that are not complete
group by Driver_Id , Cast(Start_ts As date)
Having Sum(datediff (second,End_ts , Start_ts)) >= 14400;



--No. of unique riders who use our app for airport service (ur start or end location is an airport) per day
Select	Cast(Start_ts As date) AS BusinessDate, 
		Count(Distinct rider_id)
from  [edw].[fact_trips] As A
		left  join edw.dim_Location	As B		on A.Start_location_id = B.location_id
		left  join edw.dim_Location	As C		on A.End_location_id = C.location_id
Where B.location_type = 'Airport' or C.location_type = 'Airport'
group by Cast(Start_ts As date);


---Ride cancellation ratio, assuming that accepted ts not having a start_ts is considered as cancelled 
select
	sum(case when start_ts is null then 1 else 0 end)/count(1) as cancellation_ration
from edw.fact_trips
where accept_ts is not null;

-- Excluding trips booked/accepted by banned riders/drivers
select
	sum(case when start_ts is null then 1 else 0 end)/count(1) as cancellation_ration
from edw.fact_trips t
	inner join edw.dim_drivers d on d.driver_id = t.driver_id and d.is_banned = 0
	inner join edw.dim_riders r on r.rider_id = t.rider_id and r.is_banned = 0
where accept_ts is not null;



---Avg time driver is idle/available per day

with session_time as (
	select
		driver_id,
		session_id,
		cast(min(case when event_type = 'login' then ts end)) as report_date,
		max(case when event_type = 'logout' then ts end) - min(case when event_type = 'login' then ts end) as logged_time
	from log.driver_activity
	where event_type in ('login', 'logout')
	group by driver_id, session_id
),
--individual trip time in a given session 
session_trip_time as (
	select
		driver_id,
		session_id,
		trip_id,
		max(case when event_type = 'ride_end' then ts end) - min(case when event_type = 'ride_start' then ts end) as indv_trip_time
	from log.driver_activity
	where event_type in ('ride_start', 'ride_end')
	group by driver_id, session_id, trip_id
),

--total trip time in a given session 
session_total_trip_time as (
	select
		driver_id,
		session_id
		sum(indv_trip_time) as trip_time
	from session_trip_time
	group by 1, 2
)
select
	s.report_date,
	sum(logged_time - coalesce(trip_time, 0)) as total_idle_time,
	(sum(logged_time - coalesce(trip_time, 0)))/count(distinct s.driver_id) as idle_time_per_driver
from session_time s
	left join session_total_trip_time t on t.session_id = s.session_id 
										and t.driver_id = s.driver_id
group by  report_date;



