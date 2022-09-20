/****** Object:  Table [log].[driver_activity]    Script Date: 9/17/2022 12:46:48 PM ******/
Drop table if exists [edw].[fact_trips];
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TABLE [edw].[fact_trips](
	[trip_id] [bigint] NOT NULL,
	[driver_id] [bigint] NULL,
	[rider_id] [bigint] NULL,
	[car_id] [bigint] NULL,
	[Request_locaiton_id] [bigint] NULL,
	[Start_location_id] [bigint] NULL,
	[Accept_location_id] [bigint] NULL,
	[End_location_id] [bigint] NULL,
	[Request_ts] [datetime] NULL,
	[Accept_ts] [datetime] NULL,
	[Start_ts] [datetime] NULL,
	[End_ts] [datetime] NULL,
	[Payment_amount] [decimal](9, 2) NULL,
	[Tip_amount] [decimal](9, 2) NULL,
	[Driver_rating] [decimal](4, 2) NULL,
	[Customer_rating] [decimal](4, 2) NULL,
	PRIMARY KEY (trip_id)
) 
GO

/*
--Create after driver table
ALTER TABLE [edw].[fact_trips]
ADD CONSTRAINT FK_dim_driver_Id
FOREIGN KEY ([driver_id]) REFERENCES edw.dim_driver([driver_id]);


ALTER TABLE [edw].[fact_trips]
ADD CONSTRAINT FK_dim_rider_Id
FOREIGN KEY ([rider_id]) REFERENCES edw.dim_rider([rider_id]);

ALTER TABLE [edw].[fact_trips]
ADD CONSTRAINT FK_dim_car_Id
FOREIGN KEY ([car_id]) REFERENCES edw.dim_car([car_id]);

*/