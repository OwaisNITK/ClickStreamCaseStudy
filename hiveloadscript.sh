# This file demonstrate how to use hive -e command to execute hive queries from shell
# The purpose of this file is to load data from hdfs into hive table
echo "Data Load into hive started at $(date +"%T")"

CURRENT_DATE=$(date +"%d-%m-%Y")
FILE_NAME="clickstream_$CURRENT_DATE.txt"
HDFS_FILE_PATH="$CLICKSTREAM_HDFS_DIR"

# Loading Data from HDFS into Source Table
echo "Loading Data Into Activity Table"
hive -e "load data inpath '"$HDFS_FILE_PATH"/"$FILE_NAME"' into table clickstream.activity"

# Loading Data from Source Table into Partitioned Table
echo "Loading Data Into Activity_Partitioned Table"
hive -e "INSERT OVERWRITE TABLE clickstream.activity_partitioned
partition (logDate,location)
SELECT * from clickstream.activity"

echo "Data Load into hive ended at $(date +"%T")"