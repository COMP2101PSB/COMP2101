#!/bin/bash
# This script demonstrates how the shift command works

# loop through the command line arguments
while [ $# -gt 0 ]; do
  echo "Processing '$1'."
  # tell the user how many things are left on the command line
  echo "There are $# things left to process on the command line."
  # display whatever is in $1
  echo '$1 has '"''$1' in it."

# TASK 1: replace the echo command that just says processing with a case statement that
#             recognizes the following command line options and tells the user if
#             they were found on the command line
#          Options to recognize: -h for help, -v for verbose mode
case $1 in
  -h )
  echo '"-h" is for help'
  ;;
  -v )
  echo '"-v" is for verbose'
  ;;
# TASK 2: add recognition of a debug option -d that expects a number that specifies the debug level (e.g. -d 3)
#             save the debug level in a variable to be available to use later in the script
#             display an error if the user gave the -d option without a number after it
# TASK 3: put anything that wasn't recognized on the command line into a variable for use later in the script
  -d )
    case "$2" in
    [0-9] )
    echo "-d for debug level $2"
    shift
    ;;
    *)
    echo "The -d option should be followed by a number between (0-9)"
    esac
    ;;
    *)
    errors=$1
    echo  "Error: unknown value $errors"
    ;;
esac

  # each time through the loop, shift the arguments left
  # this decrements the argument count for us
  shift
  # tell the user we shifted things
  echo "Shifted command line, leaving $# things left to process."
  echo "--------------------------"
  # go back to the top of the loop to see if anything is left to work on
done
echo "Done"
