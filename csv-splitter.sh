#!/bin/bash

# check if an input filename was passed as a command
# line argument:
if [ ! $# == 2 ]; then
  echo "Please specify the source file and how many lines to split on."
  echo "    sh ./csv-splitter.sh <Source File> <Lines per file>"
  exit
fi

# create a directory to store the output:
mkdir output

# create a temporary file containing the header without
# the content:
head -n 1 $1 > header.csv

# create a temporary file containing the content without
# the header:
tail +2 $1 > content.csv

# split the content file into multiple files of specified number of lines each:
split -l $2 content.csv output/data_

# loop through the new split files, adding the header
# and a '.csv' extension:
for f in output/*; do cat header.csv $f > $f.csv; rm $f; done;

# remove the temporary files:
rm header.csv
rm content.csv
