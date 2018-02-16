. ./param
echo "<<<<<<<<<<<<<==========Drop DATABASE if Retail_Market already Existed==========>>>>>>>>>>>"
hive -e "drop database Retail_Market;"             
echo "<<<<<<<<<<<<<==============  Creat DATABASE Retail_Market   ==================>>>>>>>>>>>>>>>>>>"
hive -e "create database if not exists Retail_Market;"
hive -e "show databases;"
echo  " <<<<<<<<<<<<<<==============Database  Created=================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"

#hive -e "use Retail_Market";
#hive -e "drop table IF EXISTS HIVE_HBP";
#hive -e "drop table IF EXISTS HIVE_NP";
#hive -e "drop table IF EXISTS HIVE_RP";
#hive -e "drop table IF EXISTS HIVE_ODCP";
#hive -e "drop table IF EXISTS HIVE_AP";
#hive -e "drop table IF EXISTS HIVE_OP";
echo "<<<<<<<<<<<<<<================Creating HIVE_HBP External Table====================>>>>>>>>>>>>>>>>>>>>>>>>>"
hive -e "create external table Retail_Market.HIVE_HBP(
RTLID:int,
RTLName:string,
TypeOfCrawling:string,
Prod_URL:string,
Title:string,
SalePrice:float,
RegPrice:float,
RebatePercent:int,
StockInfo:string)
row format delimited fields terminated by '\t' stored as textfile location '/"$RetailHiveOP"/HIVE_HBP';"
echo "<<<<<<<<<<<<<================Loading data into HIVE_HBP================>>>>>>>>>>>>>>>>>>>>>>"
hive -e "load data inpath '/"$retailPigOutput"/HBP/part-r-00000' into table Retail_Market.HIVE_HBP;"
echo "<<<<<<<<<<<<<<================Creating HIVE_NP External Table====================>>>>>>>>>>>>>>>>>>>>>>>>>"
hive -e "create external table Retail_Market.HIVE_NP(
RTLID:int,
RTLName:string,
TypeOfCrawling:string,
Prod_URL:string,
Title:string,
SalePrice:float,
RegPrice:float,
RebatePercent:int,
StockInfo:string)
row format delimited fields terminated by '\t' stored as textfile location '/"$RetailHiveOP"/HIVE_NP';"
echo "<<<<<<<<<<<<<================Loading data into HIVE_NP================>>>>>>>>>>>>>>>>>>>>>>"
hive -e "load data inpath '/"$retailPigOutput"/NP/part-r-00000' into table Retail_Market.HIVE_NP;"
echo "<<<<<<<<<<<<<<================Creating HIVE_RP External Table====================>>>>>>>>>>>>>>>>>>>>>>>>>"
hive -e "create external table Retail_Market.HIVE_RP(
RTLID:int,
RTLName:string,
TypeOfCrawling:string,
Prod_URL:string,
Title:string,
SalePrice:float,
RegPrice:float,
RebatePercent:int,
StockInfo:string)
row format delimited fields terminated by '\t' stored as textfile location '/"$RetailHiveOP"/HIVE_RP';"
echo "<<<<<<<<<<<<<================Loading data into HIVE_RP================>>>>>>>>>>>>>>>>>>>>>>"
hive -e "load data inpath '/"$retailPigOutput"/RP/part-r-00000' into table Retail_Market.HIVE_RP;"
echo "<<<<<<<<<<<<<<================Creating HIVE_ODCP External Table====================>>>>>>>>>>>>>>>>>>>>>>>>>"
hive -e "create external table Retail_Market.HIVE_ODCP(
RTLID:int,
RTLName:string,
TypeOfCrawling:string,
Prod_URL:string,
Title:string,
SalePrice:float,
RegPrice:float,
RebatePercent:int,
StockInfo:string)
row format delimited fields terminated by '\t' stored as textfile location '/"$RetailHiveOP"/HIVE_ODCP';"
echo "<<<<<<<<<<<<<================Loading data into HIVE_ODCP================>>>>>>>>>>>>>>>>>>>>>>"
hive -e "load data inpath '/"$retailPigOutput"/ODCP/part-r-00000' into table Retail_Market.HIVE_ODCP;"
echo "<<<<<<<<<<<<<<================Creating HIVE_AP External Table====================>>>>>>>>>>>>>>>>>>>>>>>>>"
hive -e "create external table Retail_Market.HIVE_AP(
RTLID:int,
RTLName:string,
TypeOfCrawling:string,
Prod_URL:string,
Title:string,
SalePrice:float,
RegPrice:float,
RebatePercent:int,
StockInfo:string)
row format delimited fields terminated by '\t' stored as textfile location '/"$RetailHiveOP"/HIVE_AP';"
echo "<<<<<<<<<<<<<================Loading data into HIVE_AP================>>>>>>>>>>>>>>>>>>>>>>"
hive -e "load data inpath '/"$retailPigOutput"/AP/part-r-00000' into table Retail_Market.HIVE_AP;"
echo "<<<<<<<<<<<<<<================Creating HIVE_OP External Table====================>>>>>>>>>>>>>>>>>>>>>>>>>"
hive -e "create external table Retail_Market.HIVE_OP(
RTLID:int,
RTLName:string,
TypeOfCrawling:string,
Prod_URL:string,
Title:string,
SalePrice:float,
RegPrice:float,
RebatePercent:int,
StockInfo:string)
row format delimited fields terminated by '\t' stored as textfile location '/"$RetailHiveOP"/HIVE_OP';"
echo "<<<<<<<<<<<<<================Loading data into HIVE_OP================>>>>>>>>>>>>>>>>>>>>>>"
hive -e "load data  inpath '/"$retailPigOutput"/OP/part-r-00000' into table Retail_Market.HIVE_OP;"