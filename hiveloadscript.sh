echo "Data Load into hive started at $(date +"%T")"

CURRENT_DATE=$(date +"%d-%m-%Y")
FILE_NAME="clickstream_$CURRENT_DATE.txt"
HDFS_FILE_PATH="$CLICKSTREAM_HDFS_DIR"

echo "'"$HDFS_FILE_PATH"/"$FILE_NAME"'"

echo "Loading Data Into Activity Table"
hive -e "load data inpath '"$HDFS_FILE_PATH"/"$FILE_NAME"' into table clickstream.activity"

echo "Loading Data Into Activity_Partitioned Table"
hive -e "INSERT OVERWRITE TABLE clickstream.activity_partitioned
partition (logDate,location)
SELECT * from clickstream.activity"

echo "Data Load into hive ended at $(date +"%T")"
