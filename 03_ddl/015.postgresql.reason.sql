CREATE TABLE tpcds.reason (
    r_reason_sk integer NOT NULL,
    r_reason_id character varying(16) NOT NULL,
    r_reason_desc character varying(100)
);
alter table tpcds.reason add primary key (r_reason_sk);
