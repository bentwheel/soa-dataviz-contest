/*
* Filename:   data_mapping.sas
* Purpose:    Maps data to calculated fields useful for data visualization.
* Author:     C. Seth Lester, ASA
* Date:       23 Dec 2020
*/

/* Update this path if using a different environment or local repo url */
filename loader '/home/demoselest/sasuser.viya/soa-dataviz-contest/contest_loader.sas';

/* Run contest_loader.sas script - generally need to run this only once per session to make sure you're rocking the most updated SOA file. */
*%include loader;

/* Manipulate the data */
data sales_data_mapped;
	set soa_data.sales_data;
	attrib
		not_taken
			length=3
			label='UW quote not purchased'
			format=boolc.
		dtq_or_withdrawn
			length=3
			label='UW declined to quote'
			format=boolc.
		no_app_submitted
			length=3
			label='Application not submitted'
			format=boolc.
		speed_to_app
			label='Days between Quote and App Received Dates'
			format=best3.
		speed_to_uw_dec
			label='Days between Quote and UW Decision Dates'
			format=best3.
		speed_to_purchase
			label='Days between Quote and Purchase Dates'
			format=best3.
		purchase_quoted_ben_diff
			label='Difference between App. and Purchase Ben. Amt.'
			format=dollar10.
		purchase_quoted_prem_diff
			label='Difference between App. and Purchase Prem.'
			format=dollar7.2
	;
	if ~missing(quote_dt) and missing(app_received_dt) then no_app_submitted=1;
	else do;
		no_app_submitted=0;
		speed_to_app = app_received_dt - quote_dt;
	end;
	if ~no_app_submitted and (upcase(uw_dec)='DECLINED' or upcase(uw_dec)='WITHDRAWN') then dtq_or_withdrawn=1;
	else do;
		dtq_or_withdrawn=0;
		speed_to_uw_dec = uw_dec_dt - quote_dt;
	end;
	if ~dtq_or_withdrawn and missing(purchase_dt) then not_taken=1;
	else do;
		not_taken=0;
		speed_to_purchase = purchase_dt - quote_dt;
	end;
	if upcase(uw_dec)='RATED' and ~not_taken then do;
			purchase_quoted_ben_diff = purchase_ben - quoted_ben;
			purchase_quoted_prem_diff = purchase_prem - quoted_prem;
	end;
	else do;
			purchase_quoted_ben_diff=0;
			purchase_quoted_prem_diff=0;
	end;
run;

