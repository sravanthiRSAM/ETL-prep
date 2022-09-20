/****** Object:  Table [log].[driver_activity]    Script Date: 9/17/2022 12:46:48 PM ******/
Drop table if exists [log].[driver_activity];
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [log].[driver_activity](
	[session_id] [bigint] NOT NULL,
	[trip_id] [bigint] NULL,
	[driver_id] [bigint] NOT NULL,
	[car_id] [bigint] NULL,
	[location_id] [bigint] NULL,
	[event_type] [varchar](50) NOT NULL,
	[ts] [datetime] NOT NULL,
	[event_value] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


--CREATE SCHEMA log;
--CREATE SCHEMA edw;