#!/bin/bash
#Based on a script created by Joel Fenwick

if [ $# -lt 3 ]
then
    echo "Usage: $0 tests_directory deck_name num_lines"
    exit 1
fi

#

shuffle() {
   local i tmp size max rand

   # $RANDOM % (i+1) is biased because of the limited range of $RANDOM
   # Compensate by using a range which is a multiple of the array size.
   size=${#array[*]}
   max=$(( 32768 / size * size ))

   for ((i=size-1; i>0; i--)); do
      while (( (rand=$RANDOM) >= max )); do :; done
      rand=$(( rand % (i+1) ))
      tmp=${array[i]} array[i]=${array[rand]} array[rand]=$tmp
   done
}

# Define the array named 'array'
array=( '1' '1' '1' '1' '1' '2' '2' '3' '3' '4' '4' '5' '5' '6' '7' '8')

TESTD=$1
DECK_NAME=$2
NUM_LINES=$3

rm $TESTD/hub_tests/$DECK_NAME 2> /dev/null

for i in $(seq 1 $NUM_LINES);
do shuffle;
printf "%s" "${array[@]}" >> $TESTD/hub_tests/$DECK_NAME
echo >> $TESTD/hub_tests/$DECK_NAME
done
