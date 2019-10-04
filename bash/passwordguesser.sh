#!/bin/bash
# This script demonstrates testing to see if 2 strings are the same

# TASK 1: Improve it by asking the user for a password guess instead of using inline literal data
# TASK 2: Improve it by rewriting it to use the if command
# TASK 3: Improve it by giving them 3 tries to get it right before failing (test 3 times but only if necessary)
#           *** Do not use the exit command


referenceString="password"
read -s -p "Please put in your password:" myString
echo
if [ $myString = $referenceString ]; then
  echo " It is Correct"
  echo
  else
    echo "Try again. You have 2 attempts left"
    read -s -p "Please put in your password:" myString
    if [ $myString = $referenceString ]; then
      echo " It is Correct"
      echo
      else
        echo "Try again. You have 1 attempts left"
        read -s -p "Please put in your password:" myString
        if  [ $myString = $referenceString ]; then
          echo " It is Correct"
          echo
          else
              echo "You failed"
              echo
        fi
      fi
    fi
