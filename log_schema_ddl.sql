-- USE master;

-- CREATE DATABASE ride_share;
-- GO

-- USE ride_share;

-- CREATE SCHEMA log;

DROP TABLE IF EXISTS log.rider_activity;
CREATE TABLE log.rider_activity(
    session_id BIGINT NOT NULL,
    rider_id BIGINT NOT NULL,
    car_id BIGINT,
    location_id BIGINT,
    event_type VARCHAR(50) NOT NULL,
    ts TIMESTAMP NOT NULL,
    event_value VARCHAR(MAX)
);

DROP TABLE IF EXISTS log.driver_activity;
CREATE table log.driver_activity(
    session_id BIGINT NOT NULL,
    driver_id BIGINT NOT NULL,
    car_id BIGINT,
    location_id BIGINT,
    event_type VARCHAR(50) NOT NULL,
    ts TIMESTAMP NOT NULL,
    event_value VARCHAR(MAX)
);

DROP TABLE IF EXISTS log.trip_activity;
CREATE table log.trip_activity(
    trip_id BIGINT NOT NULL,
    rider_id BIGINT NOT NULL,
    driver_id BIGINT,
    location_id BIGINT,
    car_id BIGINT,
    event_type VARCHAR(50) NOT NULL,
    ts TIMESTAMP NOT NULL,
    event_value VARCHAR(MAX)
);
