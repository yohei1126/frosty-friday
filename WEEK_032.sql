-- https://frostyfriday.org/blog/2023/02/03/week-32-basic/
-- This week we’re looking into some new security features that Snowflake has recently released
-- As you might know, the default idle time for Snowflake sessions is 4 hours BUT that was recently
-- adjusted; you can now change this value on certain levels.
-- Because we can finetune these numbers, Management has asked us to enforce it for some of our new
-- colleagues :
-- The challenge for this week:
-- Create 2 users
-- User 1 should have a max idle time of 8 minutes in the old Snowflake UI
-- User 2 should have a max idle time of 10 minutes in SnowSQL and in their communication with Snowflake
-- from tools like Tableau
-- https://docs.snowflake.com/en/user-guide/session-policies
-- https://docs.snowflake.com/en/user-guide/session-policies-using
-- https://docs.snowflake.com/en/sql-reference/sql/alter-session-policy
-- SESSION_IDLE_TIMEOUT_MINS -- For Snowflake clients and programmatic clients, the number of minutes in which a session can be idle before users must authenticate to Snowflake again. If a value is not specified, Snowflake uses the default value.
-- SESSION_UI_IDLE_TIMEOUT_MINS -- For Snowsight, the number of minutes in which a session can be idle before a user must authenticate to Snowflake again. If a value is not specified, Snowflake uses the default value.

use role accountadmin;

use warehouse xsmall;

create database if not exists frosty_friday;

create or replace schema week_32;

use schema week_32;

create or replace user ff_user_1;

create or replace user ff_user_2;

-- User 1 should have a max idle time of 8 minutes in the old Snowflake UI
create or replace session policy ff_session_policy_1
  SESSION_UI_IDLE_TIMEOUT_MINS = 8;

-- User 2 should have a max idle time of 10 minutes in SnowSQL and in their communication with Snowflake from tools like Tableau
create or replace session policy ff_session_policy_2
  SESSION_IDLE_TIMEOUT_MINS = 10;

show session policies;

alter user ff_user_1
set session policy ff_session_policy_1;

alter user ff_user_2
set session policy ff_session_policy_2;

-- Enforce session policies
alter account set enforce_session_policy = true;

-- Clean up
alter account set enforce_session_policy = false;

drop user if exists ff_user_1;
drop user if exists ff_user_2;

show users;

drop session policy if exists ff_session_policy_1;
drop session policy if exists ff_session_policy_2;

show session policies;
