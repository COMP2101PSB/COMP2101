#!/bin/bash
echo -n "he1b wold" |
  sed -e "s/b/o/" -e "s/1/ll/" -e "s/ol/orl/" |
  tr "h" "H"|
  tr "w" "W"|
  awk '{print $1 "\x20" $2 "\41"}'
bc <<< "(($$ * 4 - 24)/2 + 12)/2" |
  sed 's/^/I am process # /'
