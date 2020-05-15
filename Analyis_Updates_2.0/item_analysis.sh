#!/bin/bash
echo "Analysis Started"

CURRENT_DATE=$(date +"%d-%m-%Y")
CURRENT_TIME=$(date +"%H-%M-%S")
ANALYSIS_REPORT_DIR=/home/impadmin/clickstream/output
FILE_NAME=REPORT_"$CURRENT_DATE"_"$CURRENT_TIME".txt

# Creating Report File
echo "Generating Report . . ." > $ANALYSIS_REPORT_DIR/$FILE_NAME
echo "" >> $ANALYSIS_REPORT_DIR/$FILE_NAME

echo "-> Follwing is the most viewed item across the website" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
hive -e "QUERY" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
echo "" >> $ANALYSIS_REPORT_DIR/$FILE_NAME

echo "-> Following are the location wise analysis of the most viewed item" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
hive -e "QUERY" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
echo "" >> $ANALYSIS_REPORT_DIR/$FILE_NAME

echo "-> Following are the location and date wise analysis of the most sold item" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
hive -e "QUERY" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
echo "" >> $ANALYSIS_REPORT_DIR/$FILE_NAME

echo "Analysis Finished"