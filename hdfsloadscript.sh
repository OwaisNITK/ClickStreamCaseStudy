echo "Data Loading Started at $(date +"%T")"
. /home/impadmin/.bashrc

# Fetching Current Date
CURRENT_DATE=$(date +"%d-%m-%Y")
CURRENT_TIME=$(date +"%H-%M-%S")
# Resolving File Path
FILE_NAME="clickstream_$CURRENT_DATE.txt"
PROCESSED_FILE_NAME="clickstream_${CURRENT_DATE}_${CURRENT_TIME}.txt"
LOCAL_FILE_PATH="$CLICKSTREAM_INPUT_DIR/$FILE_NAME"
HDFS_FILE_PATH="$CLICKSTREAM_HDFS_DIR"
PROCESSED_FILE_PATH="$CLICKSTREAM_PROCESSED_DIR"

# Validating Existence of Local File
if [ -f "$LOCAL_FILE_PATH" ]; then
        echo "Validation Successful for LOCAL FILE : $LOCAL_FILE_PATH"
else
        echo "ERROR: File Doesn't Exist at the following path : $LOCAL_FILE_PATH"
	echo "Please Ensure that the file exist with valid read permissions"
        exit 1
fi

# Validating Existence of HDFS File
hdfs dfs -test -e $HDFS_FILE_PATH 
if [ $? -eq 0 ]; then
	echo "Validation Successful for HDFS DIRECTORY : $HDFS_FILE_PATH"
else
	echo "ERROR : HDFS Directory Doesnt Exist at the following path : $HDFS_FILE_PATH"
	echo "Please Ensure that the directory exist with valid write permissions"
	exit 1
fi

# Command to Load Data from Local File System to HDFS
hdfs dfs -put $LOCAL_FILE_PATH $HDFS_FILE_PATH

# Validating Data Load over HDFS
hdfs dfs -test -e $HDFS_FILE_PATH/$FILE_NAME
if [ $? -eq 0 ]; then
        echo "File Successful loaded into HDFS DIRECTORY : $HDFS_FILE_PATH/$FILE_NAME"
	mv $LOCAL_FILE_PATH $PROCESSED_FILE_PATH/$PROCESSED_FILE_NAME
else
        echo "ERROR : File could not be loaded into the HDFS Directory at the following path : $HDFS_FILE_PATH/$FILE_NAME"
        echo "Please Ensure that the directory exist with valid write permissions"
fi  

echo "Data Loading Finished at $(date +"%T")"
