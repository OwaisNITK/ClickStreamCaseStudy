#!/bin/bash
echo "Analysis Started"

CURRENT_DATE=$(date +"%d-%m-%Y")
CURRENT_TIME=$(date +"%H-%M-%S")
ANALYSIS_REPORT_DIR=/home/impadmin/clickstream/output
FILE_NAME=REPORT_"$CURRENT_DATE"_"$CURRENT_TIME".txt

# Creating Report File
echo "Generating Report . . ." > $ANALYSIS_REPORT_DIR/$FILE_NAME
echo "" >> $ANALYSIS_REPORT_DIR/$FILE_NAME

echo "-> Follwing is the most viewed item across the website considering all the records" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
echo "" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
echo "ITEM | VIEWS | RANK" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
echo "" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
hive -e "SELECT item,viewcount,rank from (SELECT *,rank() OVER (ORDER BY viewcount DESC) rank from (SELECT reverse(split(reverse(url),\"/\")[0]) item,count(url) as viewcount from clickstream.activity_partitioned WHERE action=\"view\" GROUP BY reverse(split(reverse(url),\"/\")[0])) b ) a where rank=1" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
echo "" >> $ANALYSIS_REPORT_DIR/$FILE_NAME

echo "-> Following are the location wise analysis of the most viewed item today" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
echo "" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
echo "LOCATION | ITEM | VIEWS | RANK" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
echo "" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
hive -e "SELECT location,item,viewcount,rank from (SELECT *,rank() OVER (PARTITION BY location ORDER BY viewcount DESC) rank from (SELECT location,reverse(split(reverse(url),\"/\")[0]) item,count(url) as viewcount from clickstream.activity_partitioned WHERE logDate=CURRENT_DATE() AND action=\"view\" GROUP BY location,reverse(split(reverse(url),\"/\")[0])) b) a where rank=1" >> $ANALYSIS_REPORT_DIR/$FILE_NAME
echo "" >> $ANALYSIS_REPORT_DIR/$FILE_NAME

echo "Analysis Finished"
