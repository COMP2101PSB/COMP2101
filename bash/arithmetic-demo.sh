#!/bin/bash
#
# this script demonstrates doing arithmetic

# Improve this script by asking the user to supply the two numbers
# Improve this script by demonstrating using subtraction and multiplication
# Improve this script by demonstrating the modulus operation
#   - the output should look something like:
#   - first divided by second gives X with a remainder of Y
# Improve this script by calculating and displaying the first number raised to the power of the second numberech
echo "Please enter a desired number"
read firstnum
echo "Please enter another number"
read secondnum
subtract=$((firstnum - secondnum))
multiplication=$((firstnum*secondnum))
sum=$((firstnum + secondnum))
dividend=$((firstnum / secondnum))
fpdividend=$(awk "BEGIN{printf \"%.2f\", $firstnum/$secondnum}")
modulus=$((firstnum%secondnum))

cat <<EOF
$firstnum plus $secondnum is $sum
$firstnum minus $secondnum is $subtract
$firstnum into $secondnum is $multiplication
$firstnum mod $secondnum is $modulus
$firstnum divided by $secondnum is $dividend
  - More precisely, it is $fpdividend and the remainder is $modulus
EOF
