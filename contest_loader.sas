/*
* Filename:   contest_loader.sas
* Purpose:    Extracts contest data from SOA website, parses it into SAS datasets with 
*             appropriately-typed fields.
* Author:     C. Seth Lester, ASA
* Date:       19 Dec 2020
*/

options 
	dlcreatedir
	fmtsearch = (mylib mylib.special); 
;

/* Create macro variables holding download URLs */
%let csv_url="https://www.soa.org/globalassets/assets/files/resources/research-report/2020/data-visualization-csv-files.zip";

/* The code to download and decompress zipfile contents inspired by the following link:
https://blogs.sas.com/content/sasdummy/2014/01/29/using-filename-zip/ */

/* detect proper delim for UNIX vs. Windows */
%let delim=%sysfunc(ifc(%eval(&sysscp. = WIN),\,/));
%let exper_path=%quote(data-visualization-csv-files&delim.Group_Experience_50.csv);
%let sales_path=%quote(data-visualization-csv-files&delim.Data Visualization - Mockup Sales Data.csv);
%put &exper_path;
 
/* Establish filepath & fileref for zipfile download */
%let ziploc = %sysfunc(getoption(sasuser))&delim.soa_data.zip;
%put &ziploc;
filename zip_dl "&ziploc";
 
/* Download the ZIP file from the Internet*/
proc http
	method='GET'
	url=&csv_url
	out=zip_dl;
run;

/* Create fileref for zipfile contents */
filename exper_z zip "&ziploc" member="&exper_path";
filename sales_z zip "&ziploc" member="&sales_path";

/* Create data download directory if it does not exist, assign libref to directory */
libname soa_data "/home/demoselest/sasuser.viya/soa-dataviz-contest/soa_data";

/* Parse boolean values in CSV files */
proc format;
	invalue booln(upcase just)
		'TRUE'=1
		'FALSE'=0
		other=.
	;
	value boolc
		1='TRUE'
		0='FALSE'
	;
	invalue $purchasefix(just)
		'$-'='$0'
		other=_same_
	;
run;

/* Read data from downloaded zipped CSV files into SAS datasets */
data soa_data.sales_data;
	attrib
		id
			label="ID"
		age
			label="Age"
		gender
			label="Gender"
			length=$1
		smoker
			label="Smoker"
			length=$2
		loc
			label="Location"
			length=$20
		quoted_ben
			label="Quoted Benefit"
			informat=dollar10.
			format=dollar10.
		quoted_term
			label="Quoted Term"
		quoted_prem
			label="Quoted Premium"
			informat=dollar7.2
			format=dollar7.2
		quote_dt
			label="Date of Quote"
			informat=mmddyy10.
			format=date9.
		app_received_dt
			label="Date Application Received"
			informat=mmddyy10.
			format=date9.
		height
			label="Height (inches)"
		weight
			label="Weight (lbs)"
		bmi
			label="BMI"
			informat=4.2
		accel_dec
			label="Accelerated Decision"
			informat=booln.
			format=boolc.
		uw_dec
			label="UW Decision"
			length=$20
		uw
			label="Underwriter"
			length=$30
		pct_loading
			label="Percent Loading"
			format=percent8.
		per_mille_loading
			label="Per Mille Loading"
			format=dollar9.
		uw_dec_dt
			label="Date of UW Decision"
			format=date9.
			informat=mmddyy10.
		purchase_dt
			label="Date of Purchase"
			format=date9.
			informat=mmddyy10.
		_purchase_ben
			length=$20
			informat=$purchasefix.
		_purchase_prem
			length=$20
			informat=$purchasefix.
		purchase_ben
			label="Purchase Benefit"
			informat=dollar10.
			format=dollar10.
		purchase_prem
			label="Purchase Premium"
			informat=dollar7.2
			format=dollar7.2
		campaign
			label="Campaign"
			length=$30
		;
	infile
		sales_z
		firstobs=2
		dsd
		dlm=','
	;
	input
		id
		age
		gender $
		smoker $
		loc $
		quoted_ben
		quoted_term
		quoted_prem
		quote_dt
		app_received_dt
		height
		weight
		bmi
		accel_dec 
		uw_dec $
		uw $
		_pct_loading
		per_mille_loading
		uw_dec_dt
		purchase_dt
		_purchase_ben $
		_purchase_prem $
		campaign $
	;
	
	if _pct_loading ne . then pct_loading = _pct_loading/100;
		else pct_loading = .;
	if ~missing(_purchase_prem) then purchase_prem = input(_purchase_prem, dollar7.2);
		else purchase_prem = .;
	if ~missing(_purchase_ben) then purchase_ben = input(_purchase_ben, dollar10.);
	drop _pct_loading _purchase_prem _purchase_ben;
run;
	



