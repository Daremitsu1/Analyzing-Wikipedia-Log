// To see the tables
SHOW TABLES;

// Create table
CREATE EXTERNAL TABLE access (
  host STRING,
  identity STRING,
  user STRING,
  time STRING,
  request STRING,
  status STRING,
  referer STRING,
  agent STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
  "input.regex" = "([^ ]*) ([^ ]*) ([^ ]*)"
STORED AS TEXTFILE;

// Load data from hdfs 
LOAD DATA INPATH 'hdfs:/wiki-access.log' into table access;

// Check if data loaded properly
SELECT * FROM access LIMIT 20;

// To check all the entries with status 404 (page not found)
SELECT host, referer, COUNT(*) FROM access WHERE STATUS=404 GROUP BY host, referer;

// Map Hive to HBase
