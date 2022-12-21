# SQl-data-exploration
In this repo, I use SQl to explore Covid Vaccination and Deaths Data

 # Covid Death and Vaccination Data Exploration using SQL
 ![istockphoto-1367799941-170667a](https://user-images.githubusercontent.com/119099815/208915418-7cb0217c-19f9-4bd8-b84e-a1d4b4407e99.jpg)

 
 This repository contains SQL scripts for exploring Covid death and vaccination data. The data sources used in these scripts are:

## Covid death data: Our World in Data[Our World in Data](https://ourworldindata.org)

Covid vaccination data: This repository contains SQL scripts for exploring Covid death and vaccination data. The data sources used in these scripts are:

Covid death data: Our World in Data[Our World in Data](https://ourworldindata
.org/covid-deaths)

Covid vaccination data: [Our World in Data](https://ourworldindata
.org/covid-vaccinations)

Prerequisites
Access to a SQL database. The scripts in this repository have been tested on PostgreSQL.
The Covid death and vaccination data must be downloaded and stored in the database. The data can be downloaded in CSV format from the above links and imported into the database using a tool such as pgAdmin or the COPY command in PostgreSQL.

### Here are a few suggestions for things you can do with the data:

Compare the number of Covid deaths and vaccinations over time in different countries
Look at the percentage of the population that has been vaccinated in different countries
Analyze the relationship between the number of Covid deaths and various factors such as population size, GDP, and healthcare spending
Disclaimer
Please note that the data in this repository is provided for informational purposes only and is not intended to be used for making medical decisions or policy decisions. Always consult with a qualified healthcare professional or government agency for the latest information and guidance on the Covid pandemic.

## Prerequisites
Access to a SQL database. The scripts in this repository have been tested on PostgreSQL.
The Covid death and vaccination data must be downloaded and stored in the database. The data can be downloaded in CSV format from the above links and imported into the database using a tool such as pgAdmin or the COPY command in PostgreSQL.
## Setup
.Clone or download this repository

.Connect to your SQL database

.Execute the SQL scripts in the following order:

-01_create_tables.sql - this script will create the necessary tables in the database

-02_import_data.sql - this script will import the data from the CSV files into the tables
## Exploring the data
Once the data is imported, you can start exploring it using SQL queries. Some example queries are provided in the queries folder.

## Here are a few suggestions for things you can do with the data:

Compare the number of Covid deaths and vaccinations over time in different countries
Look at the percentage of the population that has been vaccinated in different countries
Analyze the relationship between the number of Covid deaths and various factors such as population size, GDP, and healthcare spending
## Disclaimer
Please note that the data in this repository is provided for informational purposes only and is not intended to be used for making medical decisions or policy decisions. Always consult with a qualified healthcare professional or government agency for the latest information and guidance on the Covid pandemic.
