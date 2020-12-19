
# Filename:   contest_loader.R
# Purpose:    Extracts contest data from SOA website, parses it into tibbles with 
#             appropriately-typed fields, and sets up analysis environment within
#             a try-catch block in order to flag any potential errors due to changes
#             to the contest source data structure, locale differences, etc.
# Author:     C. Seth Lester, ASA
# Date:       19 Dec 2020

library(readr)
library(tidyverse)
library(lubridate)

# Reset flags
warn_message <- ""
err_message <- ""

zipfile_rm_flag <- NULL
file_unzip_err_flag <- NULL
refresh_err_flag <- NULL
data_dl_err_flag <- NULL
pdf_dl_err_flag <- NULL
parse_errors_flag1 <- NULL
parse_errors_flag2 <- NULL


tryCatch(
  {
    # Remove old data directory contents
    refresh_err_flag <- as.logical(unlink(c("./soa_data", "./contest_rules.pdf"), recursive=T))
    
    # Check for success, issue error if no success
    if(refresh_err_flag) {
      err_message <- paste0(err_message, "Error removing previously downloaded SOA contents.", sep="\n")
    }
    
    # Download dataset
    data_dl_err_flag <- as.logical(download.file("https://www.soa.org/globalassets/assets/files/resources/research-report/2020/data-visualization-csv-files.zip", 
                                                 "soa_data.zip", 
                                                 method = "auto", 
                                                 quiet = FALSE,
                                                 mode = "wb"))
    
    if(data_dl_err_flag) {
      err_message <- paste0(err_message, "ERROR: Couldn't download SOA datasets.", sep="\n")
    }
    
    #Download PDF of rules and guidelines
    pdf_dl_err_flag <- as.logical(download.file("https://www.soa.org/globalassets/assets/files/static-pages/research/opportunities/2020-data-visualization-contest.pdf", 
                                                "contest_rules.pdf", 
                                                method = "auto", 
                                                quiet = FALSE,
                                                mode = "wb"))
    
    if(pdf_dl_err_flag) {
      err_message <- paste0(err_message, "ERROR: Couldn't download SOA contest rules PDF file.", sep="\n")
    }
    
    #Uncompress downloaded data
    unzip(zipfile="./soa_data.zip",
          overwrite=T,
          exdir="./soa_data/",
          junkpaths=T)
    
    #Check that the uncompress operation went OK.
    file_unzip_err_flag = !max(str_detect(dir(), "soa_data"))
    
    if(file_unzip_err_flag) {
      err_message <- paste0(err_message, "ERROR: Couldn't unzip downloaded CSV package.", sep="\n")
    }
    
    #Remove zipfile 
    zipfile_rm_flag <- as.logical(unlink("./soa_data.zip"))
    
    if(zipfile_rm_flag) {
      warn_message <- paste0(err_message, "WARNING: Couldn't remove zipfile.", sep="\n")
    }
    
    #Read and parse SOA sales dataset
    sales_data <- read_csv("soa_data/Data Visualization - Mockup Sales Data.csv",
                           col_types = cols(`Quoted Benefit` = col_number(),
                                            `Quoted Premium` = col_number(), 
                                            `Date of Quote` = col_date(format = "%m/%d/%Y"), 
                                            `Date Application Received` = col_date(format = "%m/%d/%Y"), 
                                            `Per mille Loading` = col_number(), 
                                            `Date of UW Decision` = col_date(format = "%m/%d/%Y"), 
                                            `Date of Purchase` = col_date(format = "%m/%d/%Y"), 
                                            `Purchase Benefit` = col_character(), 
                                            `Purchase Premium` = col_character()))
    
    #Monitor parsing issues with sales data
    sales_data_importlog <- problems(sales_data) # no parse issues?
    parse_errors_flag1 <- as.logical(count(sales_data_importlog)$n)
    if(parse_errors_flag1) {
      warn_message <- paste0(warn_message, "There were issues with data typing in parsing the sales data. Errors stored in 'sales_data_importlog' variable.", sep="\n")
    }
    
    #Parse oddly-formatted numeric values in CSV file
    sales_data <- sales_data %>% 
      mutate_at(vars(`Purchase Benefit`, `Purchase Premium`), ~ parse_number(., na=("$-")))
    
    # Parse experience data
    exper_data <- read_csv("soa_data/Group_Experience_50.csv", 
                           col_types = cols(company_id = col_integer(), 
                           participant_id = col_number(), Year = col_integer(), 
                           age = col_number(), face_amount = col_number(), 
                           death = col_logical(), lapse = col_logical()))
    
    #Monitor parsing issues with experience data
    exper_data_importlog <- problems(exper_data) # no parse issues?
    parse_errors_flag2 <- as.logical(count(exper_data_importlog)$n)
    if(parse_errors_flag2) {
      warn_message <- paste0(warn_message, "There were issues with data typing in parsing the sales data. Errors stored in 'exper_data_importlog' variable.", sep="\n")
    }
    
    #If you can read this, you've made it!
    print("Data acquisition & parsing was successful!")
  },
  warning = function(w) {print(w)},
  error = function(e) {print(e)}
)

# Remove error messages and flags
rm(list=ls(pattern="*_flag\\d?$|*_message$"))


