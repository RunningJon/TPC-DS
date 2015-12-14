CREATE TABLE tpcds.time_dim (
    t_time_sk integer NOT NULL,
    t_time_id character(16) NOT NULL,
    t_time integer,
    t_hour integer,
    t_minute integer,
    t_second integer,
    t_am_pm character(2),
    t_shift character(20),
    t_sub_shift character(20),
    t_meal_time character(20)
)
WITH (:SMALL_STORAGE)
DISTRIBUTED BY (t_time_sk);
