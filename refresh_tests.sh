#!/bin/bash
#Based on a script created by Joel Fenwick

if [ $# -lt 3 ]
then
    echo "Usage: $0 tests_directory start_index end_index"
    exit 1
fi

#

TESTD=$1
START_INDEX=$2
END_INDEX=$3


for i in $(seq $START_INDEX $END_INDEX);
do
printf -v j "%02d" $i
	for k in $(seq 2 4);
	do
	$TESTD/gen_test.sh $TESTD d${j}.deck $k 1;
	done
done
