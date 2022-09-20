/****** Object:  Table [log].[rider_activity]    Script Date: 9/17/2022 12:50:10 PM ******/
Drop table if exists [log].[rider_activity];
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [log].[rider_activity](
	[session_id] [bigint] NOT NULL,
	[rider_id] [bigint] NOT NULL,
	[location_id] [bigint] NULL,
	[event_type] [varchar](50) NOT NULL,
	[ts] [datetime] NOT NULL,
	[event_value] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


