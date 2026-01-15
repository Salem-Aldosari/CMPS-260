#!/bin/bash

# Problem 3 Script: Regular Expressions, grep/egrep/fgrep, tr, sed

DATA_FILE="../data/regex_lab.txt"
LOG_FILE="../data/log.txt"

echo "=== GREP/EGREP/FGREP Examples ==="
echo ""

echo "1. Grep for lines starting with 'var':"
grep '^var' $DATA_FILE
echo ""

echo "2. Egrep for time patterns:"
egrep '[0-9]{1,2}:[0-9]{2}' $DATA_FILE
echo ""

echo "3. Fgrep for literal string 'a*b*':"
fgrep 'a*b*' $DATA_FILE
echo ""

echo "=== TR Examples ==="
echo ""

echo "4. Convert lowercase to uppercase:"
cat $DATA_FILE | tr '[:lower:]' '[:upper:]' | head -3
echo ""

echo "5. Squeeze repeated spaces:"
cat $DATA_FILE | tr -s ' ' | head -3
echo ""

echo "=== SED Examples ==="
echo ""

echo "6. Substitute 'var' with 'variable':"
sed 's/var/variable/' $DATA_FILE | grep variable
echo ""

echo "7. Delete lines containing 'EMPTY':"
sed '/EMPTY/d' $DATA_FILE | head -5
echo ""
