CREATE TABLE tpcds.inventory (
    inv_date_sk integer NOT NULL,
    inv_item_sk integer NOT NULL,
    inv_warehouse_sk integer NOT NULL,
    inv_quantity_on_hand integer
)
WITH (:E9_MEDIUM_STORAGE)
:DISTRIBUTED_BY
partition by range(inv_date_sk)
(start(2450815) INCLUSIVE end(2453005) INCLUSIVE every (28),
default partition outliers
);
