# A script containing the N&O's analysis of past and current Demographic
# and Housing Characteristics file data released in May 2023
# 
# by @mtdukes

# Setting up --------------------------------------------------------------

# This function checks if you don't have the correct packages installed yet
# If not, it will install it for you
packages <- c('tidyverse')
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())), repos = "https://cran.us.r-project.org")  
}
rm(packages)

#load libraries
library(tidyverse)

# Create a function for loading SF file -----------------------------------

#geoheader file for 2020
#
#usage
# geo_header_nc2020 <- #load_header('data/nc2020.dhc/ncgeo2020.dhc')
loadHeader2020 <- function(path, state_code){
  
  header <- read_delim( path, col_types = cols(.default = "c"),
    col_names = c("fileid", "stusab", "sumlev", "geovar", "geocomp", "chariter", "cifsn", "logrecno", "geoid", 
                  "geocode", "region", "division", "state", "statens", "county", "countycc", "countyns", "cousub",
                  "cousubcc", "cousubns", "submcd", "submcdcc", "submcdns", "estate", "estatecc", "estatens", 
                  "concit", "concitcc", "concitns", "place", "placecc", "placens", "tract", "blkgrp", "block", 
                  "aianhh", "aihhtli", "aianhhfp", "aianhhcc", "aianhhns", "aits", "aitsfp", "aitscc", "aitsns",
                  "ttract", "tblkgrp", "anrc", "anrccc", "anrcns", "cbsa", "memi", "csa", "metdiv", "necta",
                  "nmemi", "cnecta", "nectadiv", "cbsapci", "nectapci", "ua", "uatype", "ur", "cd116", "cd118",
                  "cd119", "cd120", "cd121", "sldu18", "sldu22", "sldu24", "sldu26", "sldu28", "sldl18", "sldl22",
                  "sldl24", "sldl26", "sldl28", "vtd", "vtdi", "zcta", "sdelm", "sdsec", "sduni", "puma", "arealand",
                  "areawatr", "basename", "name", "funcstat", "gcuni", "pop100", "hu100", "intptlat", "intptlon", 
                  "lsadc", "partflag", "uga"),
    delim = '|')
  return(header)
          
}

# One of multiple Census files that describe the demographics gathered and calculated for the 2010 Census. 
# This file contains the State/County/Tract/Block IDs link to the logical record number, which can then be 
# linked to the other two tables. Relationships are one-to-one.
# NOTE: This is identical to the 2010 header from the redistricting file
# Sourced from the U.S. Census at the following URL:
# https://www2.census.gov/programs-surveys/decennial/2010/technical-documentation/complete-tech-docs/summary-file/sf1.pdf#page=18
#
# usage
# geo_header_nc2010 <- loadHeader2010( 'data/nc2010.sf1/ncgeo2010.sf1')
loadHeader2010 <- function(path){
  header <- readr::read_fwf(
    path, col_types = cols(.default = "c"),
    progress = show_progress(), trim_ws = TRUE,
    fwf_cols(
      fileid = c(1, 6),
      stusab = c(7, 8),
      sumlev = c(9, 11),
      geocomp = c(12, 13),
      chariter = c(14, 16),
      cifsn = c(17, 18),
      logrecno = c(19, 25),
      region = c(26, 26),
      division = c(27, 27),
      state = c(28, 29),
      county = c(30, 32),
      countycc = c(33, 34),
      countysc = c(35, 36),
      cousub = c(37, 41),
      cousubcc = c(42, 43),
      cousubsc = c(44, 45),
      place = c(46, 50),
      placecc = c(51, 52),
      placesc = c(53, 54),
      tract = c(55, 60),
      blkgrp = c(61, 61),
      block = c(62, 65),
      iuc = c(66, 67),
      concit = c(68, 72),
      concitcc = c(73, 74),
      concitsc = c(75, 76),
      aianhh = c(77, 80),
      aianhhfp = c(81, 85),
      aianhhcc = c(86, 87),
      aihhtli = c(88, 88),
      aitsce = c(89, 91),
      aits = c(92, 96),
      aitscc = c(97, 98),
      ttract = c(99, 104),
      tblkgrp = c(105, 105),
      anrc = c(106, 110),
      anrccc = c(111, 112),
      cbsa = c(113, 117),
      cbsasc = c(118, 119),
      metdic = c(120, 124),
      csa = c(125, 127),
      necta = c(128, 132),
      nectasc = c(133, 134),
      nectadeiv = c(135, 139),
      cnecta = c(140, 142),
      cbsapci = c(143, 143),
      nectapci = c(144, 144),
      ua = c(145, 149),
      uasc = c(150, 151),
      uatype = c(152, 152),
      ur = c(153, 153),
      cd = c(154, 155),
      sldu = c(156, 158),
      sldl = c(159, 161),
      vtd = c(162, 167),
      vtdi = c(168, 168),
      reserve2 = c(169, 171),
      zcta5 = c(172, 176),
      submcd = c(177, 181),
      submcdcc = c(182, 183),
      sdelm = c(184, 188),
      sdsec = c(189, 193),
      sduni = c(194, 198),
      arealand = c(199, 212),
      areawater = c(213, 226),
      name = c(227, 316),
      funcstat = c(317, 317),
      gcuni = c(318, 318),
      pop100 = c(319, 327),
      hu100 = c(328, 336),
      intptlat = c(337, 347),
      intptlon = c(348, 359),
      lsadc = c(360, 361),
      partflag = c(362, 362),
      reserve3 = c(363, 368),
      uga = c(369, 373),
      statens = c(374, 381),
      countyns = c(382, 389),
      cousubns = c(390, 397),
      placens = c(398, 405),
      concitns = c(406, 413),
      aianhhns = c(414, 421),
      aitsns = c(422, 429),
      anrcns = c(430, 437),
      submcdns = c(438, 445),
      cd113 = c(446, 447),
      cd114 = c(448, 449),
      cd115 = c(450, 451),
      sldu2 = c(452, 454),
      sldu3 = c(455, 457),
      sldu4 = c(458, 460),
      sldl2 = c(461, 463),
      sldl3 = c(464, 466),
      sldl4 = c(467, 469),
      aianhhsc = c(470, 471),
      csasc = c(472, 473),
      cnectasc = c(474, 475),
      memi = c(476, 476),
      nmemi = c(477, 477),
      puma = c(478, 482),
      reserved = c(483, 500)
      ) 
    )
  return(header)
}

#and a similar function for loading the 2000 header file
# usage
# geo_header_nc2000 <- loadHeader2000( 'data/nc2000.sf1/ncgeo.uf1')
loadHeader2000 <- function(path){
  header <- readr::read_fwf(
    path, col_types = cols(.default = "c"),
    progress = show_progress(), trim_ws = TRUE,
    fwf_cols(
      #record codes
      fileid = c(1, 6),
      stusab = c(7, 8),
      sumlev = c(9, 11),
      geocomp = c(12, 13),
      chariter = c(14, 16),
      cifsn = c(17, 18),
      logrecno = c(19, 25),
      region = c(26, 26),
      #geographic area codes
      division = c(27, 27),
      statece = c(28, 29),
      state = c(30, 31),
      county = c(32, 34),
      countysc = c(35, 36),
      cousub = c(37, 41),
      cousubcc = c(42, 43),
      cousubsc = c(44, 45),
      place = c(46, 50),
      placecc = c(51, 52),
      placedc = c(53, 53),
      placesc = c(54, 55),
      tract = c(56, 61),
      blkgrp = c(62, 62),
      block = c(63, 66),
      iuc = c(67, 68),
      concit = c(69, 73),
      concitcc = c(74, 75),
      concitsc = c(76, 77),
      aianhh = c(78, 81),
      aianhhfp = c(82, 86),
      aianhhcc = c(87, 88),
      aihhtli = c(89, 89),
      aitsce = c(90, 92),
      aits = c(93, 97),
      aitscc = c(98, 99),
      anrc = c(100,104),
      anrccc = c(105, 106),
      msacmsa = c(107, 110),
      masc = c(111, 112),
      cmsa = c(113, 114),
      macci = c(115, 115),
      pmsa = c(116, 119),
      necma = c(120, 123),
      necmacci = c(124, 124),
      necmasc = c(125, 126),
      exi = c(127, 127),
      ua = c(128, 132),
      uasc = c(133, 134),
      uatype = c(135, 135),
      ur = c(136, 136),
      cd106 = c(137, 138),
      cd108 = c(139, 140),
      cd109 = c(141, 142),
      cd110 = c(143, 144),
      sldu = c(145, 147),
      sldl = c(148, 150),
      vtd = c(151, 156),
      vtdi = c(157, 157),
      zcta3 = c(158, 160),
      zcta5 = c(161, 165),
      submcd = c(166, 170),
      submcdcc = c(171, 172),
      #area characteristics
      arealand = c(173, 186),
      areawater = c(187, 200),
      name = c(201, 290),
      funcstat = c(291, 291),
      gcuni = c(292, 292),
      pop100 = c(293, 301),
      hu100 = c(302, 310),
      intptlat = c(311, 319),
      intptlon = c(320, 329),
      lsadc = c(330, 331),
      partflag = c(332, 332),
      #special area codes
      sdelm = c(333, 337),
      sdsec = c(338, 342),
      sduni = c(343, 347),
      taz = c(348, 353),
      uga = c(354, 358),
      puma5 = c(359, 363),
      puma1 = c(364, 368),
      reserve2 = c(369, 383),
      macc = c(384, 388),
      uacp = c(389, 393),
      reserved = c(394, 400)
    ) 
  )
  return(header)
}

# Function to generate field names ----------------------------------------
#2020 field list exists in a table matrix here:
#https://www2.census.gov/programs-surveys/decennial/2020/technical-documentation/complete-tech-docs/demographic-and-housing-characteristics-file-and-demographic-profile/2020-dhc-table-matrix.xlsx
genFieldList2020 <- function(state_code = 'nc'){
  field_list <- tibble(
    file = 'base',
    no = 0,
    col_name = c('fileid', 'stusab', 'chariter', 'cifsn', 'logrecno')
  )
  
}

# load the field list into a dataframe based on the data dictionary
# https://www2.census.gov/programs-surveys/decennial/2010/technical-documentation/complete-tech-docs/summary-file/sf1.pdf#page=183
# accepts a two-digit state code as a parameter, although default is nc
#
# usage
# field_list2010 <- genFieldList2010('nc')
genFieldList2010 <- function(state_code = 'nc'){
  field_list <- tibble(
    file = 'base',
    no = 0,
    col_name = c('fileid', 'stusab', 'chariter', 'cifsn', 'logrecno')
  ) %>% 
    rbind(
      tibble(
        file = paste0(state_code, '000012010.sf1'), 
        no = 01, 
        col_name = 'P0010001'
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000022010.sf1'),
        no = 02, 
        col_name =c(paste0('P', sprintf('%0.3d', 2), sprintf('%0.4d', 1:6)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000032010.sf1'),
        no = 03, 
        col_name =c(paste0('P', sprintf('%0.3d', 3), sprintf('%0.4d', 1:8)),
                    paste0('P', sprintf('%0.3d', 4), sprintf('%0.4d', 1:3)),
                    paste0('P', sprintf('%0.3d', 5), sprintf('%0.4d', 1:17)),
                    paste0('P', sprintf('%0.3d', 6), sprintf('%0.4d', 1:7)),
                    paste0('P', sprintf('%0.3d', 7), sprintf('%0.4d', 1:15)),
                    paste0('P', sprintf('%0.3d', 8), sprintf('%0.4d', 1:71)),
                    paste0('P', sprintf('%0.3d', 9), sprintf('%0.4d', 1:73)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000042010.sf1'),
        no = 04, 
        col_name =c(paste0('P', sprintf('%0.3d', 10), sprintf('%0.4d', 1:71)),
                    paste0('P', sprintf('%0.3d', 11), sprintf('%0.4d', 1:73)),
                    paste0('P', sprintf('%0.3d', 12), sprintf('%0.4d', 1:49)),
                    paste0('P', sprintf('%0.3d', 13), sprintf('%0.4d', 1:3)),
                    paste0('P', sprintf('%0.3d', 14), sprintf('%0.4d', 1:43)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000052010.sf1'),
        no = 05, 
        col_name =c(paste0('P', sprintf('%0.3d', 15), sprintf('%0.4d', 1:17)),
                    paste0('P', sprintf('%0.3d', 16), sprintf('%0.4d', 1:3)),
                    paste0('P', sprintf('%0.3d', 17), sprintf('%0.4d', 1:3)),
                    paste0('P', sprintf('%0.3d', 18), sprintf('%0.4d', 1:9)),
                    paste0('P', sprintf('%0.3d', 19), sprintf('%0.4d', 1:19)),
                    paste0('P', sprintf('%0.3d', 20), sprintf('%0.4d', 1:34)),
                    paste0('P', sprintf('%0.3d', 21), sprintf('%0.4d', 1:31)),
                    paste0('P', sprintf('%0.3d', 22), sprintf('%0.4d', 1:21)),
                    paste0('P', sprintf('%0.3d', 23), sprintf('%0.4d', 1:15)),
                    paste0('P', sprintf('%0.3d', 24), sprintf('%0.4d', 1:11)),
                    paste0('P', sprintf('%0.3d', 25), sprintf('%0.4d', 1:11)),
                    paste0('P', sprintf('%0.3d', 26), sprintf('%0.4d', 1:11)),
                    paste0('P', sprintf('%0.3d', 27), sprintf('%0.4d', 1:3)),
                    paste0('P', sprintf('%0.3d', 28), sprintf('%0.4d', 1:16)),
                    paste0('P', sprintf('%0.3d', 29), sprintf('%0.4d', 1:28)),
                    paste0('P', sprintf('%0.3d', 30), sprintf('%0.4d', 1:13)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000062010.sf1'),
        no = 06, 
        col_name =c(paste0('P', sprintf('%0.3d', 31), sprintf('%0.4d', 1:16)),
                    paste0('P', sprintf('%0.3d', 32), sprintf('%0.4d', 1:45)),
                    paste0('P', sprintf('%0.3d', 33), sprintf('%0.4d', 1:7)),
                    paste0('P', sprintf('%0.3d', 34), sprintf('%0.4d', 1:22)),
                    paste0('P', sprintf('%0.3d', 35), sprintf('%0.4d', 1)),
                    paste0('P', sprintf('%0.3d', 36), sprintf('%0.4d', 1:3)),
                    paste0('P', sprintf('%0.3d', 37), sprintf('%0.4d', 1:3)),
                    paste0('P', sprintf('%0.3d', 38), sprintf('%0.4d', 1:20)),
                    paste0('P', sprintf('%0.3d', 39), sprintf('%0.4d', 1:20)),
                    paste0('P', sprintf('%0.3d', 40), sprintf('%0.4d', 1:20)),
                    paste0('P', sprintf('%0.3d', 41), sprintf('%0.4d', 1:6)),
                    paste0('P', sprintf('%0.3d', 42), sprintf('%0.4d', 1:10)),
                    paste0('P', sprintf('%0.3d', 43), sprintf('%0.4d', 1:63)),
                    paste0('P', sprintf('%0.3d', 44), sprintf('%0.4d', 1:3)),
                    paste0('P', sprintf('%0.3d', 45), sprintf('%0.4d', 1:3)),
                    paste0('P', sprintf('%0.3d', 46), sprintf('%0.4d', 1:3)),
                    paste0('P', sprintf('%0.3d', 47), sprintf('%0.4d', 1:3)),
                    paste0('P', sprintf('%0.3d', 48), sprintf('%0.4d', 1:3)),
                    paste0('P', sprintf('%0.3d', 49), sprintf('%0.4d', 1:3)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000072010.sf1'),
        no = 07, 
        col_name =c(paste0('P', sprintf('%0.3d', 50), sprintf('%0.4d', 1:3)),
                    paste0('P', sprintf('%0.3d', 51), sprintf('%0.4d', 1:3)),
                    paste0('P', sprintf('%0.3d', 12),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:49, letters = LETTERS[1:5])$letters,
                                   expand.grid(numbers = 1:49, letters = LETTERS[1:5])$numbers
                           )
                    ))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000082010.sf1'),
        no = 08, 
        col_name =c(paste0('P', sprintf('%0.3d', 12),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:49, letters = LETTERS[6:9])$letters,
                                   expand.grid(numbers = 1:49, letters = LETTERS[6:9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 13),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:3, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1:3, letters = LETTERS[1:9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 16),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:3, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1:3, letters = LETTERS[1:9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 17), 'A', sprintf('%0.3d', 1:3)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000092010.sf1'),
        no = 09, 
        col_name =c(paste0('P', sprintf('%0.3d', 17),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:3, letters = LETTERS[2:9])$letters,
                                   expand.grid(numbers = 1:3, letters = LETTERS[2:9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 18),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:9, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1:9, letters = LETTERS[1:9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 28),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:16, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1:16, letters = LETTERS[1:9])$numbers
                           )))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000102010.sf1'),
        no = 10, 
        col_name =c(paste0('P', sprintf('%0.3d', 29),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:28, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1:28, letters = LETTERS[1:9])$numbers
                           )))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000112010.sf1'),
        no = 11, 
        col_name =c(paste0('P', sprintf('%0.3d', 31),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:16, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1:16, letters = LETTERS[1:9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 34),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:22, letters = LETTERS[1:5])$letters,
                                   expand.grid(numbers = 1:22, letters = LETTERS[1:5])$numbers
                           )))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000122010.sf1'),
        no = 12, 
        col_name =c(paste0('P', sprintf('%0.3d', 34),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:22, letters = LETTERS[6:9])$letters,
                                   expand.grid(numbers = 1:22, letters = LETTERS[6:9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 35),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1, letters = LETTERS[1:9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 36),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:3, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1:3, letters = LETTERS[1:9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 37),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:3, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1:3, letters = LETTERS[1:9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 38),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:20, letters = LETTERS[1:5])$letters,
                                   expand.grid(numbers = 1:20, letters = LETTERS[1:5])$numbers
                           )))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000132010.sf1'),
        no = 13, 
        col_name =c(paste0('P', sprintf('%0.3d', 38),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:20, letters = LETTERS[6:9])$letters,
                                   expand.grid(numbers = 1:20, letters = LETTERS[6:9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 39),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:20, letters = LETTERS[1:8])$letters,
                                   expand.grid(numbers = 1:20, letters = LETTERS[1:8])$numbers
                           )))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000142010.sf1'),
        no = 14, 
        col_name =c(paste0('P', sprintf('%0.3d', 39),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:20, letters = LETTERS[9])$letters,
                                   expand.grid(numbers = 1:20, letters = LETTERS[9])$numbers
                           )))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000152010.sf1'),
        no = 15, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 1), sprintf('%0.4d', 1:54)),
                    paste0('PCT', sprintf('%0.3d', 2), sprintf('%0.4d', 1:54)),
                    paste0('PCT', sprintf('%0.3d', 3), sprintf('%0.4d', 1:54)),
                    paste0('PCT', sprintf('%0.3d', 4), sprintf('%0.4d', 1:9)),
                    paste0('PCT', sprintf('%0.3d', 5), sprintf('%0.4d', 1:22)),
                    paste0('PCT', sprintf('%0.3d', 6), sprintf('%0.4d', 1:22)),
                    paste0('PCT', sprintf('%0.3d', 7), sprintf('%0.4d', 1:22)),
                    paste0('PCT', sprintf('%0.3d', 8), sprintf('%0.4d', 1:14)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000162010.sf1'),
        no = 16, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 9), sprintf('%0.4d', 1:14)),
                    paste0('PCT', sprintf('%0.3d', 10), sprintf('%0.4d', 1:14)),
                    paste0('PCT', sprintf('%0.3d', 11), sprintf('%0.4d', 1:31)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000172010.sf1'),
        no = 17, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), sprintf('%0.4d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000182010.sf1'),
        no = 18, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 13), sprintf('%0.4d', 1:49)),
                    paste0('PCT', sprintf('%0.3d', 14), sprintf('%0.4d', 1:3)),
                    paste0('PCT', sprintf('%0.3d', 15), sprintf('%0.4d', 1:34)),
                    paste0('PCT', sprintf('%0.3d', 16), sprintf('%0.4d', 1:26)),
                    paste0('PCT', sprintf('%0.3d', 17), sprintf('%0.4d', 1:18)),
                    paste0('PCT', sprintf('%0.3d', 18), sprintf('%0.4d', 1:15)),
                    paste0('PCT', sprintf('%0.3d', 19), sprintf('%0.4d', 1:11)),
                    paste0('PCT', sprintf('%0.3d', 20), sprintf('%0.4d', 1:32)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000192010.sf1'),
        no = 19, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 21), sprintf('%0.4d', 1:195)),
                    paste0('PCT', sprintf('%0.3d', 22), sprintf('%0.4d', 1:21)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000202010.sf1'),
        no = 20, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'A', sprintf('%0.4d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000212010.sf1'),
        no = 21, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'B', sprintf('%0.4d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000222010.sf1'),
        no = 22, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'C', sprintf('%0.4d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000232010.sf1'),
        no = 23, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'D', sprintf('%0.4d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000242010.sf1'),
        no = 24, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'E', sprintf('%0.4d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000252010.sf1'),
        no = 25, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'F', sprintf('%0.4d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000262010.sf1'),
        no = 26, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'G', sprintf('%0.4d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000272010.sf1'),
        no = 27, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'H', sprintf('%0.4d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000282010.sf1'),
        no = 28, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'I', sprintf('%0.4d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000292010.sf1'),
        no = 29, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'J', sprintf('%0.4d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000302010.sf1'),
        no = 30, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'K', sprintf('%0.4d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000312010.sf1'),
        no = 31, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'L', sprintf('%0.4d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000322010.sf1'),
        no = 32, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'M', sprintf('%0.4d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000332010.sf1'),
        no = 33, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'N', sprintf('%0.4d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000342010.sf1'),
        no = 34, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'O', sprintf('%0.4d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000352010.sf1'),
        no = 35, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 13),
                           sprintf('%s%0.4d',
                                   expand.grid(numbers = 1:49, letters = LETTERS[1:5])$letters,
                                   expand.grid(numbers = 1:49, letters = LETTERS[1:5])$numbers
                           )))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000362010.sf1'),
        no = 36, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 13),
                           sprintf('%s%0.4d',
                                   expand.grid(numbers = 1:49, letters = LETTERS[6:9])$letters,
                                   expand.grid(numbers = 1:49, letters = LETTERS[6:9])$numbers
                           )),
                    paste0('PCT', sprintf('%0.3d', 14),
                           sprintf('%s%0.4d',
                                   expand.grid(numbers = 1:3, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1:3, letters = LETTERS[1:9])$numbers
                           )),
                    paste0('PCT', sprintf('%0.3d', 19),
                           sprintf('%s%0.4d',
                                   expand.grid(numbers = 1:11, letters = LETTERS[1:2])$letters,
                                   expand.grid(numbers = 1:11, letters = LETTERS[1:2])$numbers
                           )))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000372010.sf1'),
        no = 37, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 19),
                           sprintf('%s%0.4d',
                                   expand.grid(numbers = 1:11, letters = LETTERS[3:9])$letters,
                                   expand.grid(numbers = 1:11, letters = LETTERS[3:9])$numbers
                           )),
                    paste0('PCT', sprintf('%0.3d', 20),
                           sprintf('%s%0.4d',
                                   expand.grid(numbers = 1:32, letters = LETTERS[1:5])$letters,
                                   expand.grid(numbers = 1:32, letters = LETTERS[1:5])$numbers
                           )))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000382010.sf1'),
        no = 38, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 20),
                           sprintf('%s%0.4d',
                                   expand.grid(numbers = 1:32, letters = LETTERS[6:9])$letters,
                                   expand.grid(numbers = 1:32, letters = LETTERS[6:9])$numbers
                           )),
                    paste0('PCT', sprintf('%0.3d', 22),
                           sprintf('%s%0.4d',
                                   expand.grid(numbers = 1:21, letters = LETTERS[1:6])$letters,
                                   expand.grid(numbers = 1:21, letters = LETTERS[1:6])$numbers
                           )))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000392010.sf1'),
        no = 39, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 22),
                           sprintf('%s%0.4d',
                                   expand.grid(numbers = 1:21, letters = LETTERS[7:9])$letters,
                                   expand.grid(numbers = 1:21, letters = LETTERS[7:9])$numbers
                           )))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000402010.sf1'),
        no = 40, 
        col_name =c(paste0('PCO', sprintf('%0.3d', 1), sprintf('%0.4d', 1:39)),
                    paste0('PCO', sprintf('%0.3d', 2), sprintf('%0.4d', 1:39)),
                    paste0('PCO', sprintf('%0.3d', 3), sprintf('%0.4d', 1:39)),
                    paste0('PCO', sprintf('%0.3d', 4), sprintf('%0.4d', 1:39)),
                    paste0('PCO', sprintf('%0.3d', 5), sprintf('%0.4d', 1:39)),
                    paste0('PCO', sprintf('%0.3d', 6), sprintf('%0.4d', 1:39)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000412010.sf1'),
        no = 41, 
        col_name =c(paste0('PCO', sprintf('%0.3d', 7), sprintf('%0.4d', 1:39)),
                    paste0('PCO', sprintf('%0.3d', 8), sprintf('%0.4d', 1:39)),
                    paste0('PCO', sprintf('%0.3d', 9), sprintf('%0.4d', 1:39)),
                    paste0('PCO', sprintf('%0.3d', 10), sprintf('%0.4d', 1:39)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000422010.sf1'),
        no = 42, 
        col_name =c('H00010001')
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000432010.sf1'),
        no = 43, 
        col_name =c(paste0('H', sprintf('%0.3d', 2), sprintf('%0.4d', 1:6)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000442010.sf1'),
        no = 44, 
        col_name =c(paste0('H', sprintf('%0.3d', 3), sprintf('%0.4d', 1:3)),
                    paste0('H', sprintf('%0.3d', 4), sprintf('%0.4d', 1:4)),
                    paste0('H', sprintf('%0.3d', 5), sprintf('%0.4d', 1:8)),
                    paste0('H', sprintf('%0.3d', 6), sprintf('%0.4d', 1:8)),
                    paste0('H', sprintf('%0.3d', 7), sprintf('%0.4d', 1:17)),
                    paste0('H', sprintf('%0.3d', 8), sprintf('%0.4d', 1:7)),
                    paste0('H', sprintf('%0.3d', 9), sprintf('%0.4d', 1:15)),
                    paste0('H', sprintf('%0.3d', 10), sprintf('%0.4d', 1)),
                    paste0('H', sprintf('%0.3d', 11), sprintf('%0.4d', 1:4)),
                    paste0('H', sprintf('%0.3d', 12), sprintf('%0.4d', 1:3)),
                    paste0('H', sprintf('%0.3d', 13), sprintf('%0.4d', 1:8)),
                    paste0('H', sprintf('%0.3d', 14), sprintf('%0.4d', 1:17)),
                    paste0('H', sprintf('%0.3d', 15), sprintf('%0.4d', 1:7)),
                    paste0('H', sprintf('%0.3d', 16), sprintf('%0.4d', 1:17)),
                    paste0('H', sprintf('%0.3d', 17), sprintf('%0.4d', 1:21)),
                    paste0('H', sprintf('%0.3d', 18), sprintf('%0.4d', 1:69)),
                    paste0('H', sprintf('%0.3d', 19), sprintf('%0.4d', 1:7)),
                    paste0('H', sprintf('%0.3d', 20), sprintf('%0.4d', 1:3)),
                    paste0('H', sprintf('%0.3d', 21), sprintf('%0.4d', 1:3)),
                    paste0('H', sprintf('%0.3d', 22), sprintf('%0.4d', 1:3)),
                    paste0('H', sprintf('%0.3d', 11),
                           sprintf('%s%0.4d',
                                   expand.grid(numbers = 1:4, letters = LETTERS[1:6])$letters,
                                   expand.grid(numbers = 1:4, letters = LETTERS[1:6])$numbers
                           )
                    )
        )
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000452010.sf1'),
        no = 45, 
        col_name =c(paste0('H', sprintf('%0.3d', 11),
                           sprintf('%s%0.4d',
                                   expand.grid(numbers = 1:4, letters = LETTERS[7:9])$letters,
                                   expand.grid(numbers = 1:4, letters = LETTERS[7:9])$numbers
                           )),
                    paste0('H', sprintf('%0.3d', 12),
                           sprintf('%s%0.4d',
                                   expand.grid(numbers = 1:3, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1:3, letters = LETTERS[1:9])$numbers
                           )),
                    paste0('H', sprintf('%0.3d', 16),
                           sprintf('%s%0.4d',
                                   expand.grid(numbers = 1:17, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1:17, letters = LETTERS[1:9])$numbers
                           )),
                    paste0('H', sprintf('%0.3d', 17),
                           sprintf('%s%0.4d',
                                   expand.grid(numbers = 1:21, letters = LETTERS[1:3])$letters,
                                   expand.grid(numbers = 1:21, letters = LETTERS[1:3])$numbers
                           )))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000462010.sf1'),
        no = 46, 
        col_name =c(paste0('H', sprintf('%0.3d', 17),
                           sprintf('%s%0.4d',
                                   expand.grid(numbers = 1:21, letters = LETTERS[4:9])$letters,
                                   expand.grid(numbers = 1:21, letters = LETTERS[4:9])$numbers
                           )))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '000472010.sf1'),
        no = 47, 
        col_name =c(paste0('HCT', sprintf('%0.3d', 1), sprintf('%0.4d', 1:35)),
                    paste0('HCT', sprintf('%0.3d', 2), sprintf('%0.4d', 1:13)),
                    paste0('HCT', sprintf('%0.3d', 3), sprintf('%0.4d', 1:13)),
                    paste0('HCT', sprintf('%0.3d', 4), sprintf('%0.4d', 1:13)),
                    paste0('PCT', sprintf('%0.3d', 23), sprintf('%0.4d', 1:24)),
                    paste0('PCT', sprintf('%0.3d', 24), sprintf('%0.4d', 1:23)))
      )
    ) %>% 
    mutate(table_no = str_extract(col_name, '^[A-Z]+\\d{3}[A-Z]?'), .after = no)
  
  return(field_list)
}

# usage
# field_list2000 <- genFieldList2000('nc')
genFieldList2000 <- function(state_code = 'nc'){
  field_list <- tibble(
    file = 'base',
    no = 0,
    col_name = c('fileid', 'stusab', 'chariter', 'cifsn', 'logrecno')
  ) %>% 
    rbind(
      tibble(
        file = paste0(state_code, '00001.uf1'), 
        no = 01, 
        col_name = c('P001001',
                     paste0('P', sprintf('%0.3d', 2), sprintf('%0.3d', 1:6)),
                     paste0('P', sprintf('%0.3d', 3), sprintf('%0.3d', 1:71)),
                     paste0('P', sprintf('%0.3d', 4), sprintf('%0.3d', 1:73)),
                     paste0('P', sprintf('%0.3d', 5), sprintf('%0.3d', 1:71)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00002.uf1'),
        no = 02, 
        col_name = c(paste0('P', sprintf('%0.3d', 6), sprintf('%0.3d', 1:73)),
                     paste0('P', sprintf('%0.3d', 7), sprintf('%0.3d', 1:8)),
                     paste0('P', sprintf('%0.3d', 8), sprintf('%0.3d', 1:17)),
                     paste0('P', sprintf('%0.3d', 9), sprintf('%0.3d', 1:7)),
                     paste0('P', sprintf('%0.3d', 10), sprintf('%0.3d', 1:15)),
                     paste0('P', sprintf('%0.3d', 11), sprintf('%0.3d', 1:11)),
                     paste0('P', sprintf('%0.3d', 12), sprintf('%0.3d', 1:49)),
                     paste0('P', sprintf('%0.3d', 13), sprintf('%0.3d', 1:3)),
                     paste0('P', sprintf('%0.3d', 14), sprintf('%0.3d', 1:43)),
                     paste0('P', sprintf('%0.3d', 15), sprintf('%0.3d', 1)),
                     paste0('P', sprintf('%0.3d', 16), sprintf('%0.3d', 1)),
                     paste0('P', sprintf('%0.3d', 17), sprintf('%0.3d', 1)),
                     paste0('P', sprintf('%0.3d', 18), sprintf('%0.3d', 1:19))
        )
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00003.uf1'),
        no = 03, 
        col_name =c(paste0('P', sprintf('%0.3d', 19), sprintf('%0.3d', 1:19)),
                    paste0('P', sprintf('%0.3d', 20), sprintf('%0.3d', 1:31)),
                    paste0('P', sprintf('%0.3d', 21), sprintf('%0.3d', 1:19)),
                    paste0('P', sprintf('%0.3d', 22), sprintf('%0.3d', 1:11)),
                    paste0('P', sprintf('%0.3d', 23), sprintf('%0.3d', 1:11)),
                    paste0('P', sprintf('%0.3d', 24), sprintf('%0.3d', 1:11)),
                    paste0('P', sprintf('%0.3d', 25), sprintf('%0.3d', 1:3)),
                    paste0('P', sprintf('%0.3d', 26), sprintf('%0.3d', 1:16)),
                    paste0('P', sprintf('%0.3d', 27), sprintf('%0.3d', 1:27)),
                    paste0('P', sprintf('%0.3d', 28), sprintf('%0.3d', 1:17)),
                    paste0('P', sprintf('%0.3d', 29), sprintf('%0.3d', 1:46)),
                    paste0('P', sprintf('%0.3d', 30), sprintf('%0.3d', 1:22)),
                    paste0('P', sprintf('%0.3d', 31), sprintf('%0.3d', 1)),
                    paste0('P', sprintf('%0.3d', 32), sprintf('%0.3d', 1)),
                    paste0('P', sprintf('%0.3d', 33), sprintf('%0.3d', 1))
        )
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00004.uf1'),
        no = 04, 
        col_name =c(paste0('P', sprintf('%0.3d', 34), sprintf('%0.3d', 1:20)),
                    paste0('P', sprintf('%0.3d', 35), sprintf('%0.3d', 1:20)),
                    paste0('P', sprintf('%0.3d', 36), sprintf('%0.3d', 1:20)),
                    paste0('P', sprintf('%0.3d', 37), sprintf('%0.3d', 1:9)),
                    paste0('P', sprintf('%0.3d', 38), sprintf('%0.3d', 1:57)),
                    paste0('P', sprintf('%0.3d', 39), sprintf('%0.3d', 1:5)),
                    paste0('P', sprintf('%0.3d', 40), sprintf('%0.3d', 1:3)),
                    paste0('P', sprintf('%0.3d', 41), sprintf('%0.3d', 1:3)),
                    paste0('P', sprintf('%0.3d', 42), sprintf('%0.3d', 1:3)),
                    paste0('P', sprintf('%0.3d', 43), sprintf('%0.3d', 1:3)),
                    paste0('P', sprintf('%0.3d', 44), sprintf('%0.3d', 1:3)),
                    paste0('P', sprintf('%0.3d', 45), sprintf('%0.3d', 1:3))
        )
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00005.uf1'),
        no = 05, 
        col_name =c(paste0('P', sprintf('%0.3d', 12),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:49, letters = LETTERS[1:5])$letters,
                                   expand.grid(numbers = 1:49, letters = LETTERS[1:5])$numbers
                           ))
                    )
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00006.uf1'),
        no = 06, 
        col_name =c(paste0('P', sprintf('%0.3d', 12),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:49, letters = LETTERS[6:9])$letters,
                                   expand.grid(numbers = 1:49, letters = LETTERS[6:9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 13),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:3, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1:3, letters = LETTERS[1:9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 15),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1, letters = LETTERS[1:9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 16),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1, letters = LETTERS[1:9])$numbers
                           ))
                    )
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00007.uf1'),
        no = 07, 
        col_name =c(paste0('P', sprintf('%0.3d', 17),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1, letters = LETTERS[1:9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 26),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:16, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1:16, letters = LETTERS[1:9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 27),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:27, letters = LETTERS[1:3])$letters,
                                   expand.grid(numbers = 1:27, letters = LETTERS[1:3])$numbers
                           ))
                    )
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00008.uf1'),
        no = 08, 
        col_name =c(paste0('P', sprintf('%0.3d', 27),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:27, letters = LETTERS[4:9])$letters,
                                   expand.grid(numbers = 1:27, letters = LETTERS[4:9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 28),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:17, letters = LETTERS[1:5])$letters,
                                   expand.grid(numbers = 1:17, letters = LETTERS[1:5])$numbers
                           ))
                    )
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00009.uf1'),
        no = 09, 
        col_name =c(paste0('P', sprintf('%0.3d', 28),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:17, letters = LETTERS[6:9])$letters,
                                   expand.grid(numbers = 1:17, letters = LETTERS[6:9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 30),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:22, letters = LETTERS[1:8])$letters,
                                   expand.grid(numbers = 1:22, letters = LETTERS[1:8])$numbers
                           ))
                    
                    )
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00010.uf1'),
        no = 10, 
        col_name =c(paste0('P', sprintf('%0.3d', 30),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:22, letters = LETTERS[9])$letters,
                                   expand.grid(numbers = 1:22, letters = LETTERS[9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 31),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1, letters = LETTERS[1:9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 32),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1, letters = LETTERS[1:9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 33),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1, letters = LETTERS[1:9])$numbers
                           )),
                    paste0('P', sprintf('%0.3d', 34),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:20, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1:20, letters = LETTERS[1:9])$numbers
                           ))
                    )
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00011.uf1'),
        no = 11, 
        col_name =c(paste0('P', sprintf('%0.3d', 35),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:20, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1:20, letters = LETTERS[1:9])$numbers
                           ))
                    )
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00012.uf1'),
        no = 12, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 1), sprintf('%0.3d', 1:47)),
                    paste0('PCT', sprintf('%0.3d', 2), sprintf('%0.3d', 1:47)),
                    paste0('PCT', sprintf('%0.3d', 3), sprintf('%0.3d', 1:47)),
                    paste0('PCT', sprintf('%0.3d', 4), sprintf('%0.3d', 1:9)),
                    paste0('PCT', sprintf('%0.3d', 5), sprintf('%0.3d', 1:19)),
                    paste0('PCT', sprintf('%0.3d', 6), sprintf('%0.3d', 1:19)),
                    paste0('PCT', sprintf('%0.3d', 7), sprintf('%0.3d', 1:19)),
                    paste0('PCT', sprintf('%0.3d', 8), sprintf('%0.3d', 1:14)),
                    paste0('PCT', sprintf('%0.3d', 9), sprintf('%0.3d', 1:14))
        )
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00013.uf1'),
        no = 13, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 10), sprintf('%0.3d', 1:14)),
                    paste0('PCT', sprintf('%0.3d', 11), sprintf('%0.3d', 1:31))
                    
        ),
        
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00014.uf1'),
        no = 14, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), sprintf('%0.3d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00015.uf1'),
        no = 15, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 13), sprintf('%0.3d', 1:49)),
                    paste0('PCT', sprintf('%0.3d', 14), sprintf('%0.3d', 1:7)),
                    paste0('PCT', sprintf('%0.3d', 15), sprintf('%0.3d', 1:13)),
                    paste0('PCT', sprintf('%0.3d', 16), sprintf('%0.3d', 1:52)),
                    paste0('PCT', sprintf('%0.3d', 17), sprintf('%0.3d', 1:75))
        )
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00016.uf1'),
        no = 16, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'A', sprintf('%0.3d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00017.uf1'),
        no = 17, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'B', sprintf('%0.3d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00018.uf1'),
        no = 18, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'C', sprintf('%0.3d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00019.uf1'),
        no = 19, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'D', sprintf('%0.3d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00020.uf1'),
        no = 20, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'E', sprintf('%0.3d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00021.uf1'),
        no = 21, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'F', sprintf('%0.3d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00022.uf1'),
        no = 22, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'G', sprintf('%0.3d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00023.uf1'),
        no = 23, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'H', sprintf('%0.3d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00024.uf1'),
        no = 24, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'I', sprintf('%0.3d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00025.uf1'),
        no = 25, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'J', sprintf('%0.3d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00026.uf1'),
        no = 26, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'K', sprintf('%0.3d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00027.uf1'),
        no = 27, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'L', sprintf('%0.3d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00028.uf1'),
        no = 28, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'M', sprintf('%0.3d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00029.uf1'),
        no = 29, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'N', sprintf('%0.3d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00030.uf1'),
        no = 30, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 12), 'O', sprintf('%0.3d', 1:209)))
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00031.uf1'),
        no = 31, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 13),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:49, letters = LETTERS[1:5])$letters,
                                   expand.grid(numbers = 1:49, letters = LETTERS[1:5])$numbers
                           ))
        )
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00032.uf1'),
        no = 32, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 13),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:49, letters = LETTERS[6:9])$letters,
                                   expand.grid(numbers = 1:49, letters = LETTERS[6:9])$numbers
                           )),
                    paste0('PCT', sprintf('%0.3d', 15),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:13, letters = LETTERS[1:3])$letters,
                                   expand.grid(numbers = 1:13, letters = LETTERS[1:3])$numbers
                           ))
                    )
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00033.uf1'),
        no = 33, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 15),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:13, letters = LETTERS[4:9])$letters,
                                   expand.grid(numbers = 1:13, letters = LETTERS[4:9])$numbers
                           )),
                    paste0('PCT', sprintf('%0.3d', 17),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:75, letters = LETTERS[1:2])$letters,
                                   expand.grid(numbers = 1:75, letters = LETTERS[1:2])$numbers
                           ))
          
        )
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00034.uf1'),
        no = 34, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 17),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:75, letters = LETTERS[3:5])$letters,
                                   expand.grid(numbers = 1:75, letters = LETTERS[3:5])$numbers
                           ))
          
        )
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00035.uf1'),
        no = 35, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 17),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:75, letters = LETTERS[6:8])$letters,
                                   expand.grid(numbers = 1:75, letters = LETTERS[6:8])$numbers
                           ))
                    )
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00036.uf1'),
        no = 36, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 17),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:75, letters = LETTERS[9])$letters,
                                   expand.grid(numbers = 1:75, letters = LETTERS[9])$numbers
                           ))
                    )
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00037.uf1'),
        no = 37, 
        col_name =c(paste0('H', sprintf('%0.3d', 1), sprintf('%0.3d', 1)),
                    paste0('H', sprintf('%0.3d', 2), sprintf('%0.3d', 1:6)),
                    paste0('H', sprintf('%0.3d', 3), sprintf('%0.3d', 1:3)),
                    paste0('H', sprintf('%0.3d', 4), sprintf('%0.3d', 1:3)),
                    paste0('H', sprintf('%0.3d', 5), sprintf('%0.3d', 1:7)),
                    paste0('H', sprintf('%0.3d', 6), sprintf('%0.3d', 1:8)),
                    paste0('H', sprintf('%0.3d', 7), sprintf('%0.3d', 1:17)),
                    paste0('H', sprintf('%0.3d', 8), sprintf('%0.3d', 1:7)),
                    paste0('H', sprintf('%0.3d', 9), sprintf('%0.3d', 1:15)),
                    paste0('H', sprintf('%0.3d', 10), sprintf('%0.3d', 1)),
                    paste0('H', sprintf('%0.3d', 11), sprintf('%0.3d', 1:3)),
                    paste0('H', sprintf('%0.3d', 12), sprintf('%0.3d', 1:3)),
                    paste0('H', sprintf('%0.3d', 13), sprintf('%0.3d', 1:8)),
                    paste0('H', sprintf('%0.3d', 14), sprintf('%0.3d', 1:17)),
                    paste0('H', sprintf('%0.3d', 15), sprintf('%0.3d', 1:17)),
                    paste0('H', sprintf('%0.3d', 16), sprintf('%0.3d', 1:16)),
                    paste0('H', sprintf('%0.3d', 17), sprintf('%0.3d', 1:19)),
                    paste0('H', sprintf('%0.3d', 18), sprintf('%0.3d', 1:3)),
                    paste0('H', sprintf('%0.3d', 19), sprintf('%0.3d', 1:5)),
                    paste0('H', sprintf('%0.3d', 20), sprintf('%0.3d', 1:5))
                    )
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00038.uf1'),
        no = 38, 
        col_name =c(paste0('H', sprintf('%0.3d', 11),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:3, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1:3, letters = LETTERS[1:9])$numbers
                           )),
                    paste0('H', sprintf('%0.3d', 12),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:3, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1:3, letters = LETTERS[1:9])$numbers
                           )),
                    paste0('H', sprintf('%0.3d', 15),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:17, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1:17, letters = LETTERS[1:9])$numbers
                           ))
                    )
      )
    ) %>%
    rbind(
      tibble(
        file = paste0(state_code, '00039.uf1'),
        no = 39, 
        col_name =c(paste0('PCT', sprintf('%0.3d', 16),
                           sprintf('%s%0.3d',
                                   expand.grid(numbers = 1:19, letters = LETTERS[1:9])$letters,
                                   expand.grid(numbers = 1:19, letters = LETTERS[1:9])$numbers
                           )))
      )
    ) %>% 
    mutate(table_no = str_extract(col_name, '^[A-Z]+\\d{3}[A-Z]?'), .after = no)
  
  return(field_list)
}

# Function to generate tables ---------------------------------------------

# Generate a table from the summary file
# arguments
# dir - directory where your summary files are stored
# geoheader - dataframe containing your geoheader
# table_id - table number containing the data you want, according to the data dictionary (eg P1 or P001)
#    table list: https://www2.census.gov/programs-surveys/decennial/2010/technical-documentation/complete-tech-docs/summary-file/sf1.pdf#page=139
#    all variables: https://www2.census.gov/programs-surveys/decennial/2010/technical-documentation/complete-tech-docs/summary-file/sf1.pdf#page=183
# level- summary level code - DEFAULT: 040 (state)
#    State - 040
#    County - 050
#    Place - 160
#    Tract - 140
#    Block group - 150
#    Block - 101
# geo_comp - a geographic component available on the state level - DEFAULT: 00
#    see: https://www2.census.gov/programs-surveys/decennial/2010/technical-documentation/complete-tech-docs/summary-file/sf1.pdf#page=177
# field_list - a dataframe containing the field list for the summary file - DEFAULT is previously loaded file
# usage
# genTable('data/nc2010.sf1/', geo_header_nc2010, fields = field_list2010_nc, 'P12B', level = '050')
genTable <- function(dir, geoheader, table_id, fields, level = '040', geo_comp = '00'){
  
  #provide plain language description for summary level
  level_desc <- case_when(
    level == '040' ~ 'STATE',
    level == '050' ~ 'COUNTY',
    level == '160' ~ 'PLACE',
    level == '140' ~ 'TRACT',
    level == '150' ~ 'BLOCK GROUP',
    level == '101' ~ 'BLOCK',
    .default = NA
  )
  
  #check for an invalid summary level
  if(is.na(level_desc)){
    cat('XXX INVALID SUMMARY LEVEL\n')
    return()
  }
  
  #convert the table id to the long form if needed
  table_id <- paste0(
    str_extract(toupper(table_id), '[A-Z]+'),
    sprintf('%0.3d', as.integer(str_extract(table_id, '\\d+'))),
    str_extract(toupper(table_id), '[A-Z]?$')
  )
  
  #get the file number
  file_no <- fields %>% 
    filter(table_no == table_id) %>% 
    pull(no) %>% 
    pluck(1)
  
  #get the full col spec for the csv read
  all_cols <- fields %>% 
    filter(no == 0 | no == file_no) %>%
    pull(col_name)
  
  #get the filtered col spec for the final return
  filtered_cols <- fields %>% 
    filter(no == 0 | table_no == table_id) %>%
    pull(col_name)
  
  #find the file to load
  load_file <- fields %>% 
    filter(table_no == table_id) %>%
    pull(file) %>% 
    pluck(1)
  
  #make sure its right
  cat('--- LOADING TABLE', table_id, 'FROM FILE', load_file,'\n')
  
  #load the table and filter
  table <- read_csv(paste0(dir, load_file),
           col_types = cols(.default = "d",
                            fileid = 'c', stusab = 'c', chariter = 'c' , cifsn = 'c', logrecno = 'c'),
           col_names = all_cols) %>% 
    select(all_of(filtered_cols))
  
  cat('--- TABLE LOADED SUCCESSFULLY\n')
  
  #get the necessary record numbers by filtering by level and geographic comparison
  header <- geoheader %>% 
    filter(sumlev == level & geocomp == geo_comp) %>%
    mutate(geocode = case_when(
      sumlev == '040' ~ state, #state
      sumlev == '050' ~ paste0(state, county), #county
      sumlev == '160' ~ paste0(state, place), #place
      sumlev == '140' ~ paste0(state, county, tract), #tract
      sumlev == '150' ~ paste0(state, county, tract, blkgrp), #blkgrp
      sumlev == '101' ~ paste0(state, county, tract, block), #block
      .default = NA
    )) %>% 
    select(logrecno, geocomp, geocode)
  
  cat('--- FILTERED HEADER FOR', level_desc, '\n')
  
  table <- header %>%
    left_join(table, by = c('logrecno'))

  return(table)
  
}
