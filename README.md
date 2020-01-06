#Global Surface Summary of the Day Weather Data from NOAA - Download, Import and Analysis

This set of ruby scripts serves to import and analyse weather data provided by the NOAA. 

##Requirements
* Ruby
* WGet
* GUnzip

##General
The scripts will download / import and analyse data for one specific station that you have to provide via the station code. The file stations.txt contains a list of stations and station codes.
The data is downloaded from the NOAA's [FTP-Server - ftp://ftp.ncdc.noaa.gov/pub/data/gsod/](ftp://ftp.ncdc.noaa.gov/pub/data/gsod/). Go there to check from when data is available for a specific station.
The files are named as such: stationcode-wbanId-year.op.gz - The wbanId is mostly 99999.

All scripts will hint you to their respective expected parameters if you dont call them with enough parameters.

##Downloading
download_weather_data.rb will download weather data from the NOAAs FTP server. It requires a station id
and a range of years (beginning and end year) as parameters.

It will store them in the directory from which you call the script. You might want to create a data-folder and call the script from there

##Importing
The process of importing refers to the consolidation of multiple .op files into one .json - file that will contain weather data for multiple years.
import_from_gsod.rb will import data from individual .op-files. It expects the same parameters as the download script.

##Joining
The case might occur, where data is not available for a certain station but for a nearby station. In this case you will end up with two consolidated json-files, which you can join into one using the join_data.rb script. It expects the names of the json-files you want to join as parameters

##Analysing
The script analyse_weather.rb expects a consolidated json-file as an input parameter and will provide you with a number of helper mechanisms using which you can analyse your weather data.

It features a Pry-console in which you can use ruby code to interact with the data.
