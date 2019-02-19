/* 1) Program Name: SAS HW11 */
/* Date Created: 10/17/2018 */
/* Author: Vertika Sharma */
/* Purpose: Practice subsetting datasets*/

/*2) Assign librefs to location of data */
libname hwdata 'F:\Texas_A&M\3rd Semester\STAT604\HW11' access=readonly;
libname mylib 'F:\Texas_A&M\3rd Semester\STAT604\mylib';

/*3) Assign fileref for output pdf file */
filename vsfile 'F:\SAS\VSharma_H11_output.pdf';

/*4) Create new permanenent dataset */
data mylib.jobs;
	set hwdata.tabled1x;

	/*4a) Remove missing values */
	where not missing(State);

	/*4b) Assign labels to variables */
	label Aug_2017='August 2017'
		Sept_2017='September 2017'
		Oct_2017='October 2017'
		Nov_2017='November 2017'
		Dec_2017='December 2017'
		Jan_2018='January 2018'
		Feb_2018='February 2018'
		Mar_2018='March 2018'
		Apr_2018='April 2018'
		May_2018='May 2018'
		June_2018='June 2018'
		July_2018='July 2018'
		Aug_2018='August 2018';

	/*4c) Create new report date variable */
	
	format report_date mmddyy10;
	report_date='18Oct2018'd;
	label report_date='Report Date';

	/*4d) Create new annual change variable */
	format annual_change PERCENT8.1;
	annual_change=(Aug_2018-Aug_2017)/Aug_2017;
	label annual_change='Annual Change';
    run;
/*5) Create new temporary dataset with values of annual change more than 5 percent */
	data work.temp1;
		set mylib.jobs;
		where annual_change>=0.05;
		keep Industry State Aug_2017 Aug_2018 report_date annual_change;
	run;

/*6) Create new temporary dataset where number of jobs is at least one more in Aug 2018 than 2017 */
    data work.temp2;
		set mylib.jobs;
		where Aug_2018-July_2018>=1;
		drop Aug_2017 Sep_2017 Oct_2017 Nov_2017 Dec_2017 report_date annual_change;
	run;

/*7) Create new temporary dataset of service industries */
	data work.temp3;
		set mylib.jobs;
		where Industry contains 'SERVICES' 
		and not missing(annual_change);
		keep Industry State Aug_2017 Aug_2018 report_date annual_change;
		format Aug_2017 Aug_2018 COMMA7.0;
	run;

/*8) Create new temporary dataset of southern states */
	data work.temp4;
		set mylib.jobs;
		where State in ('Texas', 'Oklahoma', 'Arkansas', 'Louisiana', 'Mississippi', 'Tennessee', 'Alabama', 'Florida', 'Georgia', 'South Carolina', 'North Carolina')
		or State like 'Tennessee%' and Industry ne 'GOVERNMENT';
		drop Aug_2017 Sep_2017 Oct_2017 Nov_2017 Dec_2017 report_date;
	run;

/*9) Open ODS PDF file */
ods pdf file=vsfile  bookmarkgen=no;

/*10) Print descriptor portion of jobs */
proc contents data=mylib.jobs;
title '#10. Descriptor Portion of Cleaned Jobs DataSet';
run;

/*11) Print list of temp datasets without details */
proc contents data=work._ALL_ NODS;
title '#11. List of Temporary DataSets';
run;

/*12) Print data from temp5 with labels */
proc print data=work.temp1 noobs label;
title '12 Records with over 5% Annual Change';
var annual_change State Industry Aug_2018 Aug_2017;
run;


/*13) Print data of all temporary datasets */
proc print data=work.temp2 noobs label;
title '#13 Records with Recent Monthly Increase';
var Industry State Jan_2018 Feb_2018 Mar_2018 Apr_2018 May_2018 June_2018 July_2018 Aug_2018;
run;

proc print data=work.temp3 label;
title '#13 Services ';
var State Aug_2017 Aug_2018 annual_change Industry report_date;
run;

proc print data=work.temp4 noobs label;
title '#13 Southern States ';
var Industry State Jan_2018 Feb_2018 Mar_2018 Apr_2018 May_2018 June_2018 July_2018 Aug_2018 annual_change;
run;

ods pdf close; 



