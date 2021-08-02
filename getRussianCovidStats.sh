#!/bin/bash

SCRIPT_HOME='/home/limon/airflow/ssh-scripts'
DOWNLOAD_DIR="$SCRIPT_HOME/download"
TMP_FILE="$SCRIPT_HOME/tmp.csv"
RESULT_FILE="$SCRIPT_HOME/final.csv"
OUT_FILE="/home/limon/russia_rsn.csv"

cd $SCRIPT_HOME
rm -r $DOWNLOAD_DIR/*

# Download all csv

cd $DOWNLOAD_DIR
for i in 1 2 3 4 5 6 7
do
    echo "Iteration $i"
    YDATE=$(date --date="$i days ago" +"%m-%d-%Y")
    echo "Date $YDATE"
    wget "https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/csse_covid_19_daily_reports/$YDATE.csv"
done

# Filtering
cd $SCRIPT_HOME
cat $DOWNLOAD_DIR/*.csv | grep 'Russia' | cut -f 5,3,11,10 -d ',' > $TMP_FILE
TIMESTAMP=$(date +"%Y-%m-%d")
echo "Current timestamp $TIMESTAMP"
echo "Date,Region,Infected,Recovered,Timestamp" > $RESULT_FILE
cat $TMP_FILE |  sed "s/$/,$TIMESTAMP/" >> $RESULT_FILE
cat $RESULT_FILE > $OUT_FILE

echo "Done!"
echo "You can find file in $OUT_FILE"
