-- https://frostyfriday.org/blog/2023/01/27/week-31-basic/
-- Frosty Friday’s super academy wants to know who their best and worst super heroes are,
-- and the only metric that matters is villains defeated. Using MIN_BY and MAX_BY, 
-- tell us which super hero is the best, and which is the worst.
-- https://docs.snowflake.com/en/sql-reference/functions/min_by
-- https://docs.snowflake.com/en/sql-reference/functions/max_by

use role sysadmin;

use warehouse xsmall;

create or replace database frosty_friday;

create schema week31;

create or replace table w31(id int, hero_name string, villains_defeated number);

insert into w31 values
  (1, 'Pigman', 5),
  (2, 'The OX', 10),
  (3, 'Zaranine', 4),
  (4, 'Frostus', 8),
  (5, 'Fridayus', 1),
  (6, 'SheFrost', 13),
  (7, 'Dezzin', 2.3),
  (8, 'Orn', 7),   
  (9, 'Killder', 6),   
  (10, 'PolarBeast', 11)
  ;

select
  MAX_BY(id, villains_defeated) as best_super_hero_id,
  MIN_BY(id, villains_defeated) as worst_super_hero_id
from w31;
