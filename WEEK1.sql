create database if not exists frosty_friday;
create schema if not exists week1;
create or replace stage week1_stage
  url = 's3://frostyfridaychallenges/challenge_1/';
list @week1_stage;
create or replace file format my_csv_format
type = csv,
field_delimiter = ',';
show file formats;
-- check file contents
select
  t.$1,
  t.$2
from @week1_stage (
    file_format => my_csv_format,
    pattern=> 'challenge_1/1.csv') as t;
select
  t.$1,
  t.$2
from @week1_stage (
    file_format => my_csv_format,
    pattern=> 'challenge_1/2.csv') as t;
select
  t.$1,
  t.$2
from @week1_stage (
    file_format => my_csv_format,
    pattern=> 'challenge_1/3.csv') as t;
create table week1_table(txt TEXT);
copy into week1_table
from @week1_stage;
select * from week1_table;
