CREATE TABLE tpcds.reason (
    r_reason_sk integer NOT NULL,
    r_reason_id character(16) NOT NULL,
    r_reason_desc character(100)
)
WITH (:SMALL_STORAGE)
DISTRIBUTED BY (r_reason_sk);
