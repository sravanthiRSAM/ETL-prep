/****** Object:  Table [log].[driver_activity]    Script Date: 9/17/2022 12:46:48 PM ******/
Drop table if exists [edw].[dim_location];
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [edw].[dim_location](
	[location_id] [bigint] NOT NULL,	
	[location_type] [varchar] NOT NULL,
	[lat] [bigint] NULL,
	[long] [bigint] NULL,
	PRIMARY KEY (location_id)
) 
GO




