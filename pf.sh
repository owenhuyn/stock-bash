#!/bin/sh

#  pf.sh
#
#
#  Created by Owen Huyn on 2/11/2014.
#


for i
do
if ! [ -e $i ]
then
echo "This file does not exist"
continue
else

absolutetotal=0

while IFS=, read -r columnOne columnTwo
do
stockprice=$(curl -s "http://download.finance.yahoo.com/d/quotes.csv?s=$columnOne&f=l1" | tr -d '\r')
total=$(echo "$stockprice*$columnTwo" | bc)
absolutetotal=$(echo "$total+$absolutetotal" | bc)
TIMESTAMP=$(date "+%d %b %Y %X")
echo "$columnOne value: $total - $TIMESTAMP"
done < $i
fi

echo "Total Porfolio Value = $absolutetotal"

done

