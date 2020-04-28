create schema if not exists ${hiveconf:DB_NAME};

use ${hiveconf:DB_NAME};

create table if not exists ${hiveconf:DB_NAME}.${hiveconf:SOURCE_TABLE_NAME} (userId String,url String,action String,logTime String,paymentMethod String,logDate String,location String)
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS textfile;

create table if not exists ${hiveconf:DB_NAME}.${hiveconf:PARTITIONED_TABLE_NAME} (userId String,url String,action String,logTime String,paymentMethod String)
partitioned by (logDate String,location String)
row format serde 'org.apache.hive.hcatalog.data.JsonSerDe'
stored as textfile;
