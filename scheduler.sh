#!/bin/bash
CURRENT_DATE=$(date +"%d-%m-%Y")
NO_OF_RECORDS=5000
BATCH_SIZE=1000
OUTPUT_PATH=/home/impadmin/clickstream/input/ 
JAR_PATH=/home/impadmin/clickstream/datagenerator

echo "Scheduler : Generating Data for Clickstream . . ."
java -jar $JAR_PATH/ClickStreamDataGenerator.jar $CURRENT_DATE $NO_OF_RECORDS $BATCH_SIZE $OUTPUT_PATH

echo "#Scheduler : Executing HDFS Loading Script . . ."
sh hdfsloadscript.sh

echo "#Scheduler : Executing HIVE Loading Script . . ."
sh hiveloadscript.sh

echo "#Executing Analysis Queries and Generating Report"
sh analysis.sh

echo "Scheduler : Finished Execution . . ."
