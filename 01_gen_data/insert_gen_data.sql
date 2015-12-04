INSERT INTO public.gen_data 
SELECT :GEN_DATA_SCALE 
FROM generate_series(1, :SEGMENT_COUNT) AS i;

