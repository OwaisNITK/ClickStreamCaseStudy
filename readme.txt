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