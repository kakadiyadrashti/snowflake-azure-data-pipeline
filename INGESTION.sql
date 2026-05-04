--PART 1: DATA INGESTION
--NAME:DRASHTI KAKADIYA(25414741)

--1.create database
CREATE DATABASE STARBUCKS_DB;
USE DATABASE STARBUCKS_DB;

--2.create schema 
CREATE SCHEMA STARBUCKS_SCHEMA;
USE SCHEMA STARBUCKS_SCHEMA;

--3.connect azure sas token to storage and container name 
CREATE OR REPLACE STAGE stage_starbucks
URL='azure://bdestarbucks.blob.core.windows.net/starbucks'
CREDENTIALS=(AZURE_SAS_TOKEN='sv=2024-11-04&ss=b&srt=co&sp=rwdlaciytfx&se=2026-01-30T13:22:16Z&st=2025-11-27T05:07:16Z&spr=https&sig=55SzB6qO2WQOcLgfFbO21eUuroyFYxOIBI1DJyzzygo%3D')
;

LIST @stage_starbucks;

--4.portfolio table 
CREATE OR REPLACE EXTERNAL TABLE portfolio_ext
WITH LOCATION = @stage_starbucks
FILE_FORMAT = (TYPE= JSON)
PATTERN = 'portfolio.json';

--top 10 rows 
SELECT*
FROM portfolio_ext
LIMIT 10;

--5.create internal portfolio table and display table
CREATE OR REPLACE TABLE portfolio AS
SELECT
value:channels::varchar as channels,
value:difficulty::varchar as difficulty,
value:duration::varchar as duration,
value:id::varchar as id,
value:offer_type::varchar as offer_type,
value:reward::varchar as reward
FROM portfolio_ext;

--6. create profile table
CREATE OR REPLACE EXTERNAL TABLE profile_ext
WITH LOCATION = @stage_starbucks
FILE_FORMAT = (TYPE= JSON)
PATTERN = 'profile.json';

--top 10 lines in table
SELECT*
FROM profile_ext
LIMIT 10;

--7.create internal profile table and display table
CREATE OR REPLACE TABLE profile AS
SELECT
value:age::varchar as age,
value:became_member_on::varchar as became_member_on,
value:gender::varchar as gender,
value:id::varchar as id,
value:income::varchar as income
FROM profile_ext;

--8.craete transcript_ext
CREATE OR REPLACE EXTERNAL TABLE transcript_ext
WITH LOCATION = @stage_starbucks
FILE_FORMAT = (TYPE= JSON)
PATTERN = 'transcript.json';

--show top 10 in transcript table
SELECT*
FROM transcript_ext
LIMIT 10;

--9.create internal transcript table and display table
CREATE OR REPLACE TABLE transcript AS
SELECT
value:event::varchar      AS event,
value:person::varchar       as person,
value:time::varchar        as time,
value:value:"offer id"::varchar  as offerid
FROM transcript_ext;

--10. Describe all three tables
DESCRIBE TABLE portfolio;   
DESCRIBE TABLE profile;
DESCRIBE TABLE transcript;

--11. Showing all the table counts
SELECT COUNT(*) FROM portfolio;  --result: 10 rows
SELECT COUNT(*) FROM profile;    --result: 17000 rows
SELECT COUNT(*) FROM transcript; --result: 306534 rows

--END OF PART-A
--THANK YOU 