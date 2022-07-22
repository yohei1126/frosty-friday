-- https://frostyfriday.org/2022/07/15/week-2-intermediate/
-- A stakeholder in the HR department wants to do some change-tracking but is concerned
-- that the stream which was created for them gives them too much info they don’t care about.
-- Load in the parquet data and transform it into a table, then create a stream that will
-- only show us changes to the dept and job_title columns. 
-- You can find the parquet data here. 
-- https://frostyfridaychallenges.s3.eu-west-1.amazonaws.com/challenge_2/employees.parquet
-- Execute the following commands:
-- update <table_name> set country = 'Japan' where employee_id = 8;
-- update <table_name> set last_name = 'Forester' where employee_id = 22;
-- update <table_name> set dept = 'Marketing' where employee_id = 25;
-- update <table_name> set title = 'Ms' where employee_id = 32;
-- update <table_name> set job_title = 'Senior Financial Analyst' where employee_id = 68;

create database if not exists frosty_friday;
create schema if not exists week2;
create stage if not exists ff_stage
  url = 's3://frostyfridaychallenges';
list @ff_stage/challenge_2/;
create or replace file format my_parquet_format
type = parquet;
show file formats;
-- check file contents
select $1
from @ff_stage (
    file_format => my_parquet_format,
    pattern=> 'challenge_2/employees.parquet');
create or replace table week2_table(
  city varchar,
  country varchar,
  country_code varchar,
  dept varchar,
  education varchar,
  email varchar,
  employee_id number,
  first_name varchar,
  job_title varchar,
  last_name varchar,
  payroll_iban varchar,
  postcode varchar,
  street_name varchar,
  street_num number,
  time_zone varchar,
  title varchar);
-- load data into the table
-- source file is parquet format so it must be converted to structured table
copy into week2_table
from (
  select
    $1:city::varchar,
    $1:country::varchar,
    $1:country_code::varchar,
    $1:dept::varchar,
    $1:education::varchar,
    $1:email::varchar,
    $1:employee_id::number,
    $1:first_name::varchar,
    $1:job_title::varchar,
    $1:last_name::varchar,
    $1:payroll_iban::varchar,
    $1:postcode::varchar,
    $1:street_name::varchar,
    $1:street_num::number,
    $1:time_zone::varchar,
    $1:title::varchar
  from @ff_stage (
      file_format => my_parquet_format,
      pattern=> 'challenge_2/employees.parquet'));
-- check if data is loaded to the table properly
select * from week2_table;
-- updated the table as instructed
update week2_table
set country = 'Japan'
where employee_id = 8;
select country
from week2_table
where employee_id = 8;
update week2_table
set last_name = 'Forester'
where employee_id = 22;
select last_name
from week2_table
where employee_id = 22;
update week2_table
set dept = 'Marketing'
where employee_id = 25;
select dept
from week2_table
where employee_id = 25;
update week2_table
set title = 'Ms'
where employee_id = 32;
select title
from week2_table
where employee_id = 32;
update week2_table
set job_title = 'Senior Financial Analyst'
where employee_id = 68;
select job_title
from week2_table
where employee_id = 68;
