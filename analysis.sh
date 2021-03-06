#!/bin/bash
echo "Analysis Started"

CURRENT_DATE=$(date +"%d-%m-%Y")
CURRENT_TIME=$(date +"%H-%M-%S")
ANALYSIS_REPORT_DIR=/home/impadmin/clickstream/output
FILE_NAME=REPORT_"$CURRENT_DATE"_"$CURRENT_TIME".txt

# Creating Report File
echo "Generating Report . . ." > $ANALYSIS_REPORT_DIR/$FILE_NAME
echo "" >> $ANALYSIS_REPORT_DIR/$FILE_NAME

echo "-> Follwing are the Location Wise Analysis of the Traffic Generated by each location for current date" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
hive -e "SELECT location,COUNT(*) AS occurence FROM clickstream.activity_partitioned WHERE logdate='$CURRENT_DATE' GROUP BY location order by occurence DESC" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
echo "" >> $ANALYSIS_REPORT_DIR/$FILE_NAME

echo "-> Following are the Page Hit Analysis across the locations for current date" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
hive -e "SELECT url,COUNT(*) AS page_hits FROM clickstream.activity_partitioned WHERE logdate='$CURRENT_DATE' GROUP BY url ORDER BY page_hits DESC;" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
echo "" >> $ANALYSIS_REPORT_DIR/$FILE_NAME

echo "-> Following are the Page Hit Analysis of users from bangalore location for current date" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
hive -e "SELECT url,COUNT(*) AS page_hits FROM clickstream.activity_partitioned WHERE logdate='$CURRENT_DATE' AND location='bangalore' GROUP BY url ORDER BY page_hits DESC" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
echo "" >> $ANALYSIS_REPORT_DIR/$FILE_NAME

echo "-> Following are the analysis of shopping from diffrent locations today" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
hive -e "SELECT location,COUNT(*) AS occurence FROM clickstream.activity_partitioned WHERE logdate='$CURRENT_DATE' AND action='checkout' GROUP BY location order by occurence DESC" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
echo "" >> $ANALYSIS_REPORT_DIR/$FILE_NAME

echo "Analysis Finished"