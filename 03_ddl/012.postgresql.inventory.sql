CREATE TABLE tpcds.inventory (
    inv_date_sk integer NOT NULL,
    inv_item_sk integer NOT NULL,
    inv_warehouse_sk integer NOT NULL,
    inv_quantity_on_hand integer
);

alter table tpcds.inventory add primary key (inv_date_sk, inv_item_sk, inv_warehouse_sk);
