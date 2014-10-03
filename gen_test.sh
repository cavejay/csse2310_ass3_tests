#!/bin/bash
#Based on a script created by Joel Fenwick

if [ $# -lt 3 ]
then
    echo "Usage: $0 tests_directory deck_name num_players update_test_manifest(optional)"
    exit 1
fi

#

TESTD=$1
DECK_NAME=$2
NUM_PLAYERS=$3
players=""
for i in $(seq 1 $NUM_PLAYERS);
do players="$players ./player";
done

name=`echo $DECK_NAME | cut -f1 -d .`
name=${name}_${NUM_PLAYERS}pl
./hub $TESTD/hub_tests/$DECK_NAME $players > $TESTD/hub_tests/$name.out 2> $TESTD/hub_tests/$name.err
if [ $# -lt 4 ]
then
	echo "0|empty|$name.out|$name.err|||TESTD/$DECK_NAME$players|Generated test for $DECK_NAME, $NUM_PLAYERS players" >> $TESTD/tests_hub.txt
fi