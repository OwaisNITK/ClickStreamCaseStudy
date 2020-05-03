# Data Generator Guidelines
Execute Following Command to Generate the Data
java -jar /path/to/ClickStreamDataGenerator.java date numberOfRecords batchSize /path/to/output/dir
E.g : java -jar ClickStreamDataGenerator.java 01-10-2020 1000000 100000 /home/user/clickstream/input
> date = DD-MM-YYYY , is the only acceptable format
> numberOfRecords , is a valid positive integer
> batchSize , is a valid positive integer , ideal batch size should be set as maximum as possible in accordance with java heap memory allocation.
> path , is an existing path with write permissions to the user , path must be separated by forward slash '/' irrespective of the OS.

# Add Following Variables into ~/.bashrc
export CLICKSTREAM_INPUT_DIR=$HOME/clickstream/input
export CLICKSTREAM_PROCESSED_DIR=$HOME/clickstream/processed
export CLICKSTREAM_HDFS_DIR=/data

# Make Sure Following Directories with Permissions Exist
mkdir home/{user}/clickstream
chmod -R 777 home/{user}/clickstream
mkdir /home/{user}/clickstream/input
chmod -R 777 home/{user}/clickstream/input
mkdir /home/{user}/clickstream/processed
chmod -R home/{user}/clickstream/processed

# Analysis Query

1) Which Location generates the highest traffic towards the application
> SELECT location,COUNT(*) AS occurence FROM activity_partitioned GROUP BY location order by occurence DESC LIMIT 1;

2) Which Page is most frequently visited across the users
> SELECT url,COUNT(*) AS page_hits FROM activity_partitioned GROUP BY url ORDER BY page_hits DESC LIMIT 1;

3) Which Page is most frequently visited by users of bangalore location
> SELECT url,COUNT(*) AS page_hits FROM activity_partitioned WHERE location='bangalore' GROUP BY url ORDER BY page_hits DESC;

4) Which location has the most number of buyers (most occurence of action=checkout)
SELECT location,COUNT(*) AS occurence FROM activity_partitioned WHERE action='checkout' GROUP BY location order by occurence DESC;
