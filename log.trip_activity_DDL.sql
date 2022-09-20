/****** Object:  Table [log].[trip_activity]    Script Date: 9/17/2022 12:51:20 PM ******/

Drop table if exists  [log].[trip_activity];

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [log].[trip_activity](
	[trip_id] [bigint] NOT NULL,
	[rider_id] [bigint] NOT NULL,
	[driver_id] [bigint] NULL,
	[location_id] [bigint] NULL,
	[car_id] [bigint] NULL,
	[event_type] [varchar](50) NOT NULL,
	[ts] [DateTime] NOT NULL,
	[event_value] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


