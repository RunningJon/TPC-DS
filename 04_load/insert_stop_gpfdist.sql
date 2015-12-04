INSERT INTO public.stop_gpfdist
SELECT 'foo'
FROM generate_series(1, :SEGMENT_COUNT) AS i;

