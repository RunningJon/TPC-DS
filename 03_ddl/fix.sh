for i in $(ls *.gpdb.*.sql); do
	new=$(echo $i | awk -F '.' '{print $1 ".postgresql." $3 "." $4}')
	echo "cp $i $new"
	cp $i $new
done
