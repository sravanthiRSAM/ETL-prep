/****** Object:  Table [log].[driver_activity]    Script Date: 9/17/2022 12:46:48 PM ******/
Drop table if exists [edw].[dim_car_driver];
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [edw].[dim_car_driver](
	[car_id] [bigint] NOT NULL,	
	[driver_id] [bigint] NOT NULL,
	PRIMARY KEY (car_id,driver_id)
) 
GO

/*

ALTER TABLE [edw].[dim_car_driver]
ADD CONSTRAINT FK_dim_car_driver_car_Id
FOREIGN KEY ([car_id]) REFERENCES edw.[dim_car]([car_id]);

ALTER TABLE [edw].[dim_car_driver]
ADD CONSTRAINT FK_dim_car_driver_driver_Id
FOREIGN KEY ([driver_id]) REFERENCES edw.[dim_driver]([driver_id]);
*/