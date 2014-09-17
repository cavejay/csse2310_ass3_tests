#!/bin/bash
#Based on a script created by Joel Fenwick

red='\x1B[0;31m'
green='\x1B[0;32m'
NC='\x1B[0m' # No Color

if [ $# -lt 3 ]
then
    echo "Usage: $0 binname tests_dir name"
    exit 1
fi

BINNAME=$1
TESTD=$2/tests
DISPLAY_NAME=$3
TESTF="$2/tests_$DISPLAY_NAME"
dirn="${DISPLAY_NAME}_test_output"

rm -rf $dirn
mkdir $dirn

touch $dirn/locked
chmod a-w $dirn/locked

RESULT=""

number=0
passed=0
lnum=0
echo "-------------------------------------"
echo "Running Tests: $DISPLAY_NAME"
while read line
do
    let lnum=lnum+1
    if [ "$line" == "" ]
    then
	continue
    fi 
    if [ `echo $line|cut -c1` == '#' ]
    then
	continue
    fi
    let number=number+1
    details=`echo $line | cut -f1,2,3,4,5,6 -d\| | tr \| " "`
    args=`echo $line | cut -f7 -d\| | tr \| " "`
    desc=`echo $line | cut -f8 -d\|`
    read retval inp out err f1 f2<<END
$details
END
    #Now we actually run the test
    #$TESTD/tools/tlimit 20 $BINNAME $args < $TESTD/$inp > $dirn/result.$number 2> $dirn/err.$number
#echo "$BINNAME $args < $TESTD/$inp > $dirn/result.$number 2> $dirn/err.$number"
    $BINNAME $args < $TESTD/$inp > $dirn/result.$number 2> $dirn/err.$number
    result=$?

    if [ $result != $retval ]
    then
        echo -e "$number ${red}FAIL${NC} $desc (exit code expected $retval got $result)"
        continue
    else
        if [ ! -e $TESTD/$out ]
        then
            echo -e "Output file $TESTD/$out is missing"
            continue
        fi
  	diff -q $dirn/result.$number $TESTD/$out > /dev/null 2>&1
	if [ $? != 0 ]
	then
                          echo -e "$number ${red}FAIL${NC} $desc (stdout mismatch)"
                          continue
	else
            diff -q $dirn/err.$number $TESTD/$err > /dev/null 2>&1
            if [ $? != 0 ]
            then
                          echo -e "$number ${red}FAIL${NC} $desc (error mismatch)"
                          continue
            else
              if [ -n "$f1" ]
              then
                  diff -q $dirn/$f1 $TESTD/$f1 > /dev/null 2>&1
                  if [ $? != 0 ]
                  then
                          echo -e "$number ${red}FAIL${NC} $desc (FILE mismatch)"
                          continue
                  fi
                  if [ -n  "$f2" ]
                  then
                      diff -q $dirn/$f2 $TESTD/$f2 > /dev/null 2>&1
                      if [ $? != 0 ]
                      then
        echo -e "$number ${red}FAIL${NC} $desc (FILE mismatch)"
                          continue
                      fi
        echo -e "$number ${green}PASS${NC} $desc"
                      let passed=passed+1
                      continue 
                  fi
              fi
            fi
	fi 
    fi
    echo -e "$number ${green}PASS${NC} $desc"
    let passed=passed+1
done < $TESTF

if [ $passed == $number ]
then
    echo -e "${green}TESTS PASSED${NC}: passed $passed/$number"
else
    echo -e "${red}TESTS FAILED${NC}: passed $passed/$number"
fi
echo "-------------------------------------"
#echo $RESULT
#echo $RESULT > marks

#rm -rf $dirn
