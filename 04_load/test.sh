#!/bin/bash

id=$(ls *.sql | awk -F '.' '{print $1}' | sort | tail -1 | sed 's/^0*//')

echo $id

id="0"$(($id+1))
echo $id
