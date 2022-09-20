/****** Object:  Table [log].[driver_activity]    Script Date: 9/17/2022 12:46:48 PM ******/
Drop table if exists [edw].[dim_car];
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [edw].[dim_car](
	[car_id] [bigint] NOT NULL,	
	[owner_id] [int] NULL,
	[Registration_num] [varchar] NULL,
	[Make] [varchar] NOT NULL,
	[Model] [varchar] NOT NULL,
	PRIMARY KEY (car_id)
) 
GO




