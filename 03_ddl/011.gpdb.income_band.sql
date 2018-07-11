CREATE TABLE tpcds.income_band (
    ib_income_band_sk integer NOT NULL,
    ib_lower_bound integer,
    ib_upper_bound integer
)
WITH (:SMALL_STORAGE)
:DISTRIBUTED_BY;
