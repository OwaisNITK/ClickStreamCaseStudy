#!/bin/bash
# This script generates the schema required by clickstream application
echo "Schema Creation Started at $(date +"%T")"

PROPERTY_FILE_LOCATION=/home/impadmin/clickstream/clickstream-schema.properties
HQL_FILE_LOCATION=/home/impadmin/clickstream/clickstream-schema.hql

db_name=$(grep -i 'databasename' $PROPERTY_FILE_LOCATION  | cut -f2 -d'=')
source_table_name=$(grep -i 'sourcetablename' $PROPERTY_FILE_LOCATION  | cut -f2 -d'=')
partitioned_table_name=$(grep -i 'partitionedtablename' $PROPERTY_FILE_LOCATION  | cut -f2 -d'=')
echo "connecting to database - " $db_name
echo  "using source table as - " $source_table_name
echo "using partitioned table as - " $partitioned_table_name
hive -hiveconf DB_NAME=$db_name -hiveconf SOURCE_TABLE_NAME=$source_table_name -hiveconf PARTITIONED_TABLE_NAME=$partitioned_table_name -f $HQL_FILE_LOCATION

echo "Schema Creation Ended at $(date +"%T")"