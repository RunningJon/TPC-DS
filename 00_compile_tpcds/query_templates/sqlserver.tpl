 -- $Id: sqlserver.tpl,v 1.5 2008/06/19 16:59:52 jms Exp $
define __LIMITA = "";
define __LIMITB = "top %d";
define __LIMITC = "";
define _BEGIN = "-- start query " + [_QUERY] + " in stream " + [_STREAM] + " using template " + [_TEMPLATE] + " and seed " + [_SEED];
define _END = "-- end query " + [_QUERY] + " in stream " + [_STREAM] + " using template " + [_TEMPLATE];
