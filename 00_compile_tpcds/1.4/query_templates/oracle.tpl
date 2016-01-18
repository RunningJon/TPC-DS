 -- $Id: oracle.tpl,v 1.6 2008/06/19 16:51:52 jms Exp $
define __LIMITA = "select * from (";
define __LIMITB = "";
define __LIMITC = " ) where rownum <= %d";
define _BEGIN = "-- start query " + [_QUERY] + " in stream " + [_STREAM] + " using template " + [_TEMPLATE] + " and seed " + [_SEED];
define _END = "-- end query " + [_QUERY] + " in stream " + [_STREAM] + " using template " + [_TEMPLATE];
