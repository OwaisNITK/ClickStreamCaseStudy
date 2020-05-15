#!/bin/bash
CURRENT_DATE=$(date +"%Y-%m-%d")
NO_OF_RECORDS=1000
BATCH_SIZE=200
OUTPUT_PATH=/home/impadmin/clickstream/input/ 
JAR_PATH=/home/impadmin/clickstream/datagenerator

echo "Scheduler : Generating Data for Clickstream . . ."
java -jar $JAR_PATH/ClickStreamAnalysisDataGenerator.jar $CURRENT_DATE $NO_OF_RECORDS $BATCH_SIZE $OUTPUT_PATH

echo "Scheduler : Generating Clickstream Schema. . ."
sh clickstream-schema.sh

echo "#Scheduler : Executing HIVE Loading Script . . ."
sh hiveloadscript.sh

echo "#Executing Analysis Queries and Generating Report"
sh item_analysis.sh

echo "Scheduler : Finished Execution . . ."