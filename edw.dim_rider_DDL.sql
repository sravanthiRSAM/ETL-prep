/****** Object:  Table [log].[driver_activity]    Script Date: 9/17/2022 12:46:48 PM ******/
Drop table if exists [edw].[dim_rider];
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [edw].[dim_rider](
	[rider_id] [bigint] NOT NULL,
	[Is_Banned] [tinyint] NOT NULL,
	[Account_creation_Date] [datetime] NOT NULL,
	[Last_tripdate] [datetime] NOT NULL,
	[Num_of_trips] [int] NULL,
	[Num_of_trips_7] [int] NULL,
	[Num_of_trips_30] [int] NOT NULL,
	[Avg_rating] [decimal] NOT NULL,
	PRIMARY KEY (rider_id)
) 
GO


