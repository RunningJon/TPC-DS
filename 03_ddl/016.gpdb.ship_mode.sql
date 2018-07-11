CREATE TABLE tpcds.ship_mode (
    sm_ship_mode_sk integer NOT NULL,
    sm_ship_mode_id character varying(16) NOT NULL,
    sm_type character varying(30),
    sm_code character varying(10),
    sm_carrier character varying(20),
    sm_contract character varying(20)
)
WITH (:SMALL_STORAGE)
:DISTRIBUTED_BY;
