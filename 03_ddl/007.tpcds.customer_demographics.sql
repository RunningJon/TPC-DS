CREATE TABLE tpcds.customer_demographics (
    cd_demo_sk integer NOT NULL,
    cd_gender character(1),
    cd_marital_status character(1),
    cd_education_status character varying(20),
    cd_purchase_estimate integer,
    cd_credit_rating character varying(10),
    cd_dep_count integer,
    cd_dep_employed_count integer,
    cd_dep_college_count integer
)
WITH (:SMALL_STORAGE)
:DISTRIBUTED_BY;
