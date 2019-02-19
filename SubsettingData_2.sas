/* 1) Program Name: SAS HW12 */
/* Date Created: 10/22/2018 */
/* Author: Vertika Sharma */
/* Purpose: Practice subsetting datasets*/

/*2) Create new temporary narrow dataset */
data work.tempds;
/*2a) Drop variables not to be included */
drop Aug_2017 Sept_2017 Oct_2017 Nov_2017 Dec_2017 Jan_2018 Feb_2018 Mar_2018 Apr_2018 May_2018 June_2018 July_2018 Aug_2018;
 set tmp1.tabled1x;
/*2b) Rename Industry value */
if Industry='PROFESSIONAL AND BUSINESS SERVICES' then INDUSTRY='PROFESSIONAL-BUSINESS SERVICES';
/*2c) change indtsyr to propercase */
Industry=Propcase(Industry);

/*2d) Create dataset */

	if State ne'' then do;
		Length Month $ 15;
Month='August';
	Year='2017';
	Jobs=Aug_2017;
output; 
	Month='September';
	Year='2017';
	Jobs=Sept_2017;
output;
    Month='October';
	Year='2017';
	Jobs=Oct_2017;
output;
  Month='November';
	Year='2017';
	Jobs=Nov_2017;
output;
  Month='December';
	Year='2017';
	Jobs=Dec_2017;
output;
  Month='January';
	Year='2018';
	Jobs=Jan_2018;
output;
 Month='February';
	Year='2018';
	Jobs=Feb_2018;
output;
 Month='March';
	Year='2018';
	Jobs=Mar_2018;
output;
 Month='April';
	Year='2018';
	Jobs=Apr_2018;
output;
 Month='May';
	Year='2018';
	Jobs=May_2018;
output;
 Month='June';
	Year='2018';
	Jobs=June_2018;
output;
 Month='July';
	Year='2018';
	Jobs=July_2018;
output;
 Month='August';
	Year='2018';
	Jobs=Aug_2018;
output;
end;
run;

/*3) Create multiple datasets */
data work.Small work.Medium work.Large work.government (keep= State avg_jobs market_size) work.services (keep= industry State avg_jobs market_size) work.goods (keep= industry State avg_jobs market_size);
set Tmp2.Jobsdata;
/*3a) remove variables not to be included */
drop Aug_2017 Sept_2017 Oct_2017 Nov_2017 Dec_2017 Jan_2018 Feb_2018 Mar_2018 Apr_2018 May_2018 June_2018 July_2018 Aug_2018 rep_date ann_chg;
/*3b) create average jobs variable */
avg_jobs=mean(of Aug_2017-Aug_2018);
label avg_jobs= 'Average Jobs';
/*3c) ignore missing values for avg_jobs */
if avg_jobs ne '' then do;
/*3d) segregate data based on avg_jobs into 3 different datasets */
	if (avg_jobs<100) then do;
	market_size ='Small';
	label market_size='Market Size';
	output work.Small;
	end;
	if (100=<avg_jobs=<750) then do;
	market_size ='Medium';
	label market_size='Market Size';
	output work.Medium;
	end;
	if (avg_jobs>750) then do;
	market_size ='Large';
	label market_size='Market Size';
	output work.Large;
	end;
end;
/*3e) Create 3 datasets based on industry */
select (Industry);
when ('FINANCIAL ACTIVITIES','PROFESSIONAL AND BUSINESS SERVICES','EDUCATION AND HEALTH SERVICES','LEISURE AND HOSPITALITY')
output work.services;
when ('CONSTRUCTION', 'MANUFACTURING')
output work.goods;
when ('GOVERNMENT')
output work.government;
otherwise;
end;
run;
/* #4) Set up output pdf file */
ods pdf file="F:\Texas_A&M\3rd Semester\STAT604\HW12\VSharma_HW12_output.pdf" bookmarkgen=yes bookmarklist=hide;

/* #5) Print procedures for select observations */
proc print data=work.tempds(obs=50) noobs;
title '5.1 - First 50 Observations from Narrow Data Set';
run;

proc print data=work.tempds(firstobs=4462 obs=5512) noobs;
title '5.2 - Last 50 Observations from Narrow Data Set';
run;


proc print data=work.tempds(firstobs=2700 obs=2749) noobs;
title '5.3 - Fifty Observations from Narrow Data Set Beginning with #2700';
run;

/* #6) Print procedures for select observations */

/* #6a) Print 30 obs for small */
proc print data=work.small(obs=30)label;
title '6a - First 30 Observations of Small Markets';
run;
/* #6b) Print 30 obs for medium */
proc print data=work.medium(obs=30)label;
title '6b - First 30 Observations of Medium Markets';
run;
/* #6c) Print all obs for large */
proc print data=work.large label;
title '6c - Large Markets';
run;
/* #6d) select obs from goods*/
proc print data=work.goods(firstobs=70 obs=99) noobs label;
title '6d - Selected Observations from Goods industry';
run;

/* #6e) select obs from services*/
proc print data=work.services(obs=30) label;
where market_size='Small';
title '6e - Small Markets in the Services industry';
run;

/* #6f) all obs from government*/
proc print data=work.government label;
title '6f - Government industry';
run;

/* #7) print data from Vtable*/
proc print data=sashelp.Vtable (where = (libname='WORK'));
var  libname memname crdate nobs nvar;
title '7 - Data Sets in the WORK Library';
run;

ods pdf close;


