DROP EXTERNAL TABLE IF EXISTS public.data_dir;

CREATE EXTERNAL WEB TABLE public.data_dir
(hostname text, path text)
EXECUTE E'myhost=`hostname`; echo -n $myhost "|" $PGDATA' ON :SEGMENTS
FORMAT 'TEXT' (DELIMITER '|' NULL AS '');
