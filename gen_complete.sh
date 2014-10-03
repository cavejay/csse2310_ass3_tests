#!/bin/bash
#Based on a script created by Joel Fenwick

if [ $# -lt 3 ]
then
    echo "Usage: $0 tests_directory deck_name num_lines"
    exit 1
fi

#

TESTD=$1
DECK_NAME=$2
NUM_LINES=$3

$TESTD/gen_deck.sh $TESTD $DECK_NAME $NUM_LINES

for i in $(seq 2 4);
do
$TESTD/gen_test.sh $TESTD $DECK_NAME $i;
done
