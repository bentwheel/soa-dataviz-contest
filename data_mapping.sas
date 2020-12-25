/*
* Filename:   data_mapping.sas
* Purpose:    Maps data to calculated fields useful for data visualization.
* Author:     C. Seth Lester, ASA
* Date:       23 Dec 2020
*/

/* Update this path if using a different environment or local repo url */
filename loader '/folders/myfolders/sasuser.v94/git-local/soa-dataviz-contest/contest_loader.sas';

/* Run contest_loader.sas script - generally need to run this only once per session to make sure you're rocking the most updated SOA file. */
*%include loader;

/* Manipulate the data */
data sales_data_mapped;
	set soa_data.sales_data;
	attrib
		not_taken
			length=3
			label='Purchased Quote with Nonmissing App Date'
			format=boolc.
	;
	
	if ~missing(app_received_dt) and missing(purchase_dt) then not_taken=1;
		else not_taken=0;
run;

