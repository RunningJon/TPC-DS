CREATE TABLE tpcds.ship_mode (
    sm_ship_mode_sk integer NOT NULL,
    sm_ship_mode_id character(16) NOT NULL,
    sm_type character(30),
    sm_code character(10),
    sm_carrier character(20),
    sm_contract character(20)
)
:DISTRIBUTED_BY;
