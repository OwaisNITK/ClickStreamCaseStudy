#!/bin/bash
# This file demonstrate how to use hive -e command to execute hive queries from shell
# The purpose of this file is to load data from local file system into hive table
echo "Data Load into hive started at $(date +"%T")"

# Fetching Current Date
CURRENT_DATE=$(date +"%Y-%m-%d")
CURRENT_TIME=$(date +"%H-%M-%S")
# Resolving File Path
FILE_NAME="clickstream_$CURRENT_DATE.txt"
PROCESSED_FILE_NAME="clickstream_${CURRENT_DATE}_${CURRENT_TIME}.txt"
LOCAL_FILE_PATH="$CLICKSTREAM_INPUT_DIR/$FILE_NAME"
PROCESSED_FILE_PATH="$CLICKSTREAM_PROCESSED_DIR"

# Validating Existence of Local File
if [ -f "$LOCAL_FILE_PATH" ]; then
        echo "Validation Successful for LOCAL FILE : $LOCAL_FILE_PATH"
else
        echo "ERROR: File Doesn't Exist at the following path : $LOCAL_FILE_PATH"
	echo "Please Ensure that the file exist with valid read permissions"
        exit 1
fi

# Loading Data from Local File System To Hive Tables
echo "Loading Data Into Activity Table"
hive -e "load data inpath '"$HDFS_FILE_PATH"/"$FILE_NAME"' into table clickstream.activity"
hive -e "LOAD DATA LOCAL INPATH  ‘$LOCAL_FILE_PATH’ INTO TABLE clickstream.activity" 

# Moving Data File to Processed File Directory
mv $LOCAL_FILE_PATH $PROCESSED_FILE_PATH/$PROCESSED_FILE_NAME

# Loading Data from Source Table into Partitioned Table
echo "Loading Data Into Activity_Partitioned Table"
hive -e "INSERT OVERWRITE TABLE clickstream.activity_partitioned
partition (logDate,location)
SELECT * from clickstream.activity"

echo "Data Load into hive ended at $(date +"%T")"