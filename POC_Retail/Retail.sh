. /home/sushil/parameter
mkdir $dirname
cd $dirname
cp /home/sushil/CopyToHDFS .
echo "***************************************************************"
echo "            Copying the Inputfile to HDFS                      "
echo "***************************************************************"
sh CopyToHDFS
cp /home/sushil/mapreduce .
echo "***************************************************************"
echo "             Mapreduce processing started                      "
echo "***************************************************************"
sh mapreduce
if [ $? -eq 0 ]; then
echo "***************************************************************"
echo "      Succesfully Mapreduce Processing is completed"
echo "***************************************************************"
else
    echo "Mapreduce processing stopped"
fi
cp /home/sushil/sensexScript.pig .
echo "***************************************************************"
echo "                 SENSEX Pig Processing started"
echo "***************************************************************"
sh sensexScript.pig
if [ $? -eq 0 ]; then
echo "***************************************************************"
echo "           PIG Processing completed successfully"
echo "***************************************************************"
else
    echo "Pig processing failed"
fi
cp /home/sushil/mysql .
echo "***************************************************************"
echo "                    Creating table in MYSQL"
echo "***************************************************************"
sh mysql
cp /home/sushil/sqoop .
echo "***************************************************************"
echo "           Exporting the data to MYSQL using SQOOP"
echo "***************************************************************"
sh sqoop
if [ $? -eq 0 ]; then
echo "***************************************************************"
echo "                exporting of data to MYSQL is done"
echo "***************************************************************"
else
    echo "exporting of data to MYSQL failed"
fi
echo "***************************************************************"
echo "                 creation of hive tables started"
echo "***************************************************************"
cp /home/sushil/hiveprocess.sh .
sh hiveprocess.sh
if [ $? -eq 0 ]; then
echo "***************************************************************"
echo "                    Hive process is done"
echo "***************************************************************"
else
    echo "Hive process failed"
fi
hadoop fs -ls /${Pig_Output_path}
cp /home/sushil/SensexHiveData .
echo "***************************************************************"
echo "                Data from Hivetables"
echo "***************************************************************"
sh SensexHiveData
cp /home/sushil/SensexMYSQLData .
echo "***************************************************************"
echo "               Data from MYSQL Database"
echo "***************************************************************"
sh SensexMYSQLData
