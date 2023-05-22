# Preparing for additional Census 2020 releases

On **May 25**, the U.S. Census Bureau will release the Demographic and Housing Characteristics file, a new dataset from the 2020 census that provides more detail on survey respondents. The data includes household makeup, racial and age information as well as ownership status, often at the Census block level.

**Jump to a section**

[Use our code](https://github.com/mcclatchy-southeast/census2020_dhc#running-code) | [Get data](https://github.com/mcclatchy-southeast/census2020_dhc#data-files) | [Quick reference](https://github.com/mcclatchy-southeast/census2020_dhc#quick-reference) | [Helpful links](https://github.com/mcclatchy-southeast/census2020_dhc#other-helpful-links)

## Data files

Click on the files to view and download them.

### 2010 data

#### By county

* [Median age (P13)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_county_2010_p13.csv)
* [Sex by age (PCT12)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_county_2010_pct12.csv)
* [Tenure of occupied housing units (H4)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_county_2010_h4.csv)
* [Status of vacant housing units (H5)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_county_2010_h5.csv)
* [Population in occupied housing units (H11)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_county_2010_h11.csv)
* [Population in occupied housing units - white, non-Hispanic (H11I)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_county_2010_h11i.csv)
* [Population in occupied housing units - Black (H11B)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_county_2010_h11b.csv)
* [Population in occupied housing units - Hispanic (H11H)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_county_2010_h11h.csv)

#### By place

* [Median age (P13)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_place_2010_p13.csv)
* [Sex by age (PCT12)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_place_2010_pct12.csv)
* [Tenure of occupied housing units (H4)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_place_2010_h4.csv)
* [Status of vacant housing units (H5)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_place_2010_h5.csv)
* [Population in occupied housing units (H11)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_place_2010_h11.csv)
* [Population in occupied housing units - white, non-Hispanic (H11I)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_place_2010_h11i.csv)
* [Population in occupied housing units - Black (H11B)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_place_2010_h11b.csv)
* [Population in occupied housing units - Hispanic (H11H)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_place_2010_h11h.csv)

#### By weighted/aggregated 2020 blocks

Census blocks change between each decennial census. To weight the 2010 block values to the new 2020 blocks for comparison, we used [geographic crosswalks from NHGIS](https://www.nhgis.org/geographic-crosswalks). *NOTE: The U.S. Census Bureau advises that due to noise in the block-level values, data should be aggregated to higher levels, like block groups or tracts.*

* [Tenure of occupied housing units (H4)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_block_2010_h4.csv)
* [Status of vacant housing units (H5)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_block_2010_h5.csv)
* [Population in occupied housing units (H11)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_block_2010_h11.csv)
* [Population in occupied housing units - white, non-Hispanic (H11I)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_block_2010_h11i.csv)
* [Population in occupied housing units - Black (H11B)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_block_2010_h11b.csv)
* [Population in occupied housing units - Hispanic (H11H)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_block_2010_h11h.csv)

#### By weighted/aggregated 2020 tracts

Census tracts also change between each decennial census. The [weighted block-level data above](https://github.com/mcclatchy-southeast/census2020_dhc#by-weightedaggregated-2020-blocks) was aggregated to the tract level to map 2010 data onto tract maps for 2020.

* [Tenure of occupied housing units (H4)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_tract_2010_h4.csv)
* [Status of vacant housing units (H5)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_tract_2010_h5.csv)
* [Population in occupied housing units (H11)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_tract_2010_h11.csv)
* [Population in occupied housing units - white, non-Hispanic (H11I)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_tract_2010_h11i.csv)
* [Population in occupied housing units - Black (H11B)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_tract_2010_h11b.csv)
* [Population in occupied housing units - Hispanic (H11H)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_tract_2010_h11h.csv)

### 2020 data

#### By county

* [Tenure of occupied housing units (H4)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_county_2000_h4.csv)

#### By place

* [Tenure of occupied housing units (H4)](https://github.com/mcclatchy-southeast/census2020_dhc/blob/main/data/nc_place_2000_h4.csv)

#### By weighted/aggregated 2020 blocks

* *COMING SOON*

#### By weighted/aggregated 2020 tracts

* *COMING SOON*

## Running code

### Loading the 2010 summary file

This repository contains a helper script to load the 2010 summary file, the equivalent to the 2020 Demographics and Housing Characteristics file.

#### 1. Download the data

The U.S. Census Bureau has a zip file [available to download for each state](https://www2.census.gov/census_2010/04-Summary_File_1/). Download the zip file and unzip it to a location on your hard drive. This may take a few minutes.

#### 2. Download our code

[Right click and save the script](https://github.com/mcclatchy-southeast/census2020_dhc/raw/main/code/sf1_loaders.R) to a location on your hard drive.

#### 3. Run the code

In RStudio, in a script or in the console, load the script's functions with `source`, replacing the `{{PATH}}` below to the directory where you downloaded the script.

```R
# load in the script's functions and variables
source('{{PATH}}/sf1_loaders.R')
```

The summary file is split into a header file and dozens of other tables. These scripts will help you join them up. Load the header file first, replacing `{{PATH}}` with the directory where you stored the unzipped file. *NOTE: the code that follows assumes you did NOT change the names of any of the unzipped files. If you run into errors, double-check your filenames and directories.*

```R
#load the 2010 header file
geo_header_nc2010 <- loadHeader2010( '{{PATH}}/nc2010.sf1/ncgeo2010.sf1')

#load the 2000 header file
geo_header_nc2000 <- loadHeader2000( '{{PATH}}/nc2000.sf1/ncgeo.uf1')
```

Load the field list with the `genFieldList` function, which generates a list of every field in every table in the summary file based on the [census data dictionary](https://www2.census.gov/programs-surveys/decennial/2010/technical-documentation/complete-tech-docs/summary-file/sf1.pdf#page=183).

The function optionally accepts a two-digit state code parameter. The default is `nc`.

```R
#load the field list for 2010
field_list2010 <- genFieldList()

#and for 2000
field_list2000 <- genFieldList2000('nc')
```

Use the `genTable` function to create a table of data at a given summary level. The `table_id` argument specifies which data you want based on the census table number (e.g. `P3` is the race population table). The default summary level is statewide, but you can specify county, place, tract, block group, or block for now. Replace `{{PATH}}` with the directory where you stored the unzipped file.

For more on the data available, see the [table reference](https://www2.census.gov/programs-surveys/decennial/2010/technical-documentation/complete-tech-docs/summary-file/sf1.pdf#page=139) or [full list of variables](https://www2.census.gov/programs-surveys/decennial/2010/technical-documentation/complete-tech-docs/summary-file/sf1.pdf#page=183).

**Argument list**
 - **dir** directory where your summary files are stored
 - **geoheader** dataframe containing your geoheader
 - **table_id** table number containing the data you want, according to the data dictionary *(eg P1 or P001)*
  - **fields** dataframe containing the field list and table filenames customized for a given state.
 - **level** summary level code *DEFAULT: 040*
    - **040** state 
    - **050** county    
    - **160** place   
    - **140** tract    
    - **150** block group
    - **101** block
 - **geo_comp** [geographic component](https://www2.census.gov/programs-surveys/decennial/2010/technical-documentation/complete-tech-docs/summary-file/sf1.pdf#page=177) available on the state level *DEFAULT: 00*

```R
#generate a race table on the county level
myTable <- genTable('{{PATH}}/nc2010.sf1/', geo_header_nc2010, 'P3', fields = field_list2010_nc, level = '050')
```

## Quick reference

### NC population change over time
| Year | Population | % change
|:---|---:|---:|
| 1990 | 6,628,637 | -- |
| 2000 | 8,049,313 | 21.4 |
| 2010 | 9,535,483 | 18.5 |
| 2020 | 10,439,388 | 9.5 |

Resident population according to Census apportionment results from [2020](https://www.census.gov/data/tables/2020/dec/2020-apportionment-data.html), [2010](https://www.census.gov/data/tables/2010/dec/2010-apportionment-data.html), [2000](https://www.census.gov/data/tables/2000/dec/2000-apportionment-data.html) and [1990](https://www.census.gov/data/tables/1990/dec/1990-apportionment-data.html).

### NC housing unit change over time

| Year | Total units | Owned units | Homeownership rate
|:---|---:|---:|
| 2000 | 3,132,013 | 2,172,355 | 69.4 |
| 2010 | 3,745,155 | 2,497,900 | 66.7 |

### Geographic area changes over time
| Geography | 2000 count | 2010 count | 2020 count |
|:--|--:|--:|--:|
| county | 100 | 100 | 100 |
| tracts | 1,563 | 2,195 | 2,672 |
| blocks | 232,403 | 288,987 | 236,638 |

More detail on basic Census geographies, counts and other NC-specific information [here](https://www.census.gov/geographies/reference-files/2010/geo/state-local-geo-guides-2010/north-carolina.html) and [here](https://www.census.gov/geographies/reference-files/time-series/geo/tallies.2000.html).

### Frequently used summary levels
| Area type | summary level code |
|:--|:--|
| State | 040 |
| County | 050 |
| Consolidated city | 170 |
| Place | 160 |
| Census tract | 140 |
| Block group | 150 |
| Block | 750, 101 |
| Congressional district | 500 |
| NC Senate district | 610 |
| NC House district | 620 |

[2010 summary levels](https://www2.census.gov/programs-surveys/decennial/2010/technical-documentation/complete-tech-docs/summary-file/sf1.pdf#page=107)

### Geographic identifiers
The Census uses [geographic identifiers](https://www.census.gov/programs-surveys/geography/guidance/geo-identifiers.html), or GEOIDs, for each of its geographic shapes.  The position of the number in every ID corresponds to a specific subdivision of a shape (think nesting dolls).

| 37 | 183 | 052404 | 1017 |
|:--|:--|:--|:--|
| State | County | Tract | Block |

### File locations

| File name | File type | Data dictionary |
|:--|:--|:--|
| 2000 Summary File 1 | [Files](https://www2.census.gov/census_2000/datasets/Summary_File_1/) | [Data dictionary](https://www2.census.gov/programs-surveys/decennial/2000/technical-documentation/complete-tech-docs/summary-files/sf1.pdf#page=204) |
| [2010 Summary File 1](https://www2.census.gov/census_2010/04-Summary_File_1/) | fixed-width and comma-delimited txt files | [Data dictionary](https://www2.census.gov/programs-surveys/decennial/2010/technical-documentation/complete-tech-docs/summary-file/sf1.pdf#page=163) |
| 2020 DHC file| *Coming soon* | [Data dictionary](https://www2.census.gov/programs-surveys/decennial/2020/technical-documentation/complete-tech-docs/demographic-and-housing-characteristics-file-and-demographic-profile/2020census-demographic-and-housing-characteristics-file-and-demographic-profile-techdoc.pdf) |
| [2010/2020 block shapefile](https://www.census.gov/cgi-bin/geo/shapefiles/index.php?year=2020&layergroup=Blocks%20%282020%29)| ESRI shapefile | [Notes](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html) |
| [Block assignment files](https://www.census.gov/geographies/reference-files/time-series/geo/block-assignment-files.html)| pipe-delimited txt files | [File record layout](https://www.census.gov/programs-surveys/geography/technical-documentation/records-layout/2020-census-block-record-layout.html) |
| [2010 Name lookup tables](https://www.census.gov/geographies/reference-files/time-series/geo/name-lookup-tables.2010.html) | pipe-delimited txt files | [File record layout](https://www.census.gov/programs-surveys/geography/technical-documentation/records-layout/nlt-record-layouts.html) |
| [2020 Name lookup tables](https://www.census.gov/geographies/reference-files/time-series/geo/name-lookup-tables.2020.html) | pipe-delimited txt files | [File record layout](https://www.census.gov/programs-surveys/geography/technical-documentation/records-layout/nlt-record-layouts.html) |

## Other helpful links

* [DHC press kit](https://www.census.gov/newsroom/press-kits/2023/2020-demographic-profile-and-dhc.html)
* [Data tables](https://www2.census.gov/programs-surveys/decennial/2020/program-management/data-table-guide-dhc-dp.xlsx)
* [Past coverage from the N&O and Observer](https://github.com/mcclatchy-southeast/census2020/tree/main#complete-coverage)
* [Original 2020 Census repo](https://github.com/mcclatchy-southeast/census2020)

