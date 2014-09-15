CSSE2310 Assignment 3 Tests
===================

This is a collection of student created tests for Assignment 3 of CSSE2310 Semester 2 2014.

Please feel free to collaborate and submit a pull request if you add your own tests, if you think a test is incorrect or the spec has been misinterpreted please raise an issue [here.](https://github.com/timdrew/csse2310_ass3_tests/issues)

No tests currently exist for the hub section of the assignment, these will be added when I (or others) start that component.

Usage:
-----------

Tests are run by executing tscript.sh, this will result in terminal output displaying a list of tests run and PASS/FAIL status, a folder with test output files will also be created.

__tscript.sh arguments:__ binname tests_dir name

__binname:__ The name of the executable you wish to test.

__tests_dir:__ The root of this repository.

__name:__ The name of the group of tests you with to run e.g. "player" or "hub", this name property will be used to select which tests_${name}.txt file to run. Test output will also be stored in a ${name}_test_output folder.

__Sample usage:__

    my_tests/tscript.sh ./player my_tests player

Disclaimer:
-------------

This software is provided "As is" and no guarantee is given as to its reliability or accuracy. Make sure you check your the assignment specification as I take no responsibility for lost marks.

tscript.sh is based on a script created by Joel Fenwick and is reused with his permission.