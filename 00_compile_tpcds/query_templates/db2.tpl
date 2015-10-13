 -- $Id: db2.tpl,v 1.6 2008/06/19 16:51:52 jms Exp $
define __LIMITA = "";
define __LIMITB = "";
define __LIMITC = " fetch first %d rows only";
define _BEGIN = "-- start query " + [_QUERY] + " in stream " + [_STREAM] + " using template " + [_TEMPLATE] + " and seed " + [_SEED];
define _END = "-- end query " + [_QUERY] + " in stream " + [_STREAM] + " using template " + [_TEMPLATE];
