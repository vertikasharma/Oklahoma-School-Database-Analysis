/* 1) Program Name: SAS HW17 */
/* Date Created: 11/27/2018 */
/* Author: Vertika Sharma */
/* Last Submitted: 11/27/2018 */
/* Program Location: F:\Texas_A&M\3rd Semester\STAT604\HW17\Assignment17 */
/* Purpose: Practice user-defined format datasets */


/* Assign fileref for input csv file */
filename csvfile 'F:\Texas_A&M\3rd Semester\STAT604\HW17\OKSchools.csv';



/* 2) Assign fileref for output pdf file */
filename vsfile 'F:\SAS\VSharma_HW17_output.pdf';

/* Set up printing ods */
ods pdf file=vsfile; 
options nodate dtreset orientation=landscape pageno=2;
footnote;

/* 3) Create user defined format for school divisions */
proc format;
value divi 	0-69 = 'B'
				70-106 = 'A'
				107-180 = '2A'
				181-314 = '3A'
				315-720 = '4A'
				721-1250 = '5A'
				1251- high = '6A'
				other='Non-HS';
/* Create user defined format for class size categories */
value classsz low - <10= 'Very Small'
				 10 - <14 = 'Small'
				 14 -<18 ='Medium'
				 18 -<22 ='Large'
				 22-high ='Very Large'
				 .='Missing values';
run;

/* 5) Read data from csv file */
data work.OKSchools;
length School $ 60 LocCity $ 70 MailCity $50 County $55 Teachers $65 
Grade8 7.2 Grade9 7.2 Grade10 7.2 Grade11 7.2 Grade12 7.2 Ungraded 7.2 PreTotal 7.2 ElemTotal 7.2 HSTotal 7.2 STRatio 7.2;
infile csvfile dlm=',' firstobs=2 dsd;
input School $ LocCity $ MailCity $ County $ Teachers $
Grade8 Grade9 Grade10 Grade11 Grade12 Ungraded PreTotal ElemTotal HSTotal STRatio;
run;

/* 6) Print first 25 observations */
proc print data=work.OKSchools (obs=25) noobs;
title1 "Oklahoma School Analysis";
title2 "Partial Listing";
footnote "Based on NCES Data";
run;

/* 7) Distribution of class sizes based on STRatio */
proc freq data=work.OKSchools;
tables STRatio /nocum missing;
label STRatio='Class Size';
format STRatio classsz.;
title1 "Oklahoma School Analysis";
title2 "Distribution of Class Sizes Based on Student/Teacher Ratio";
run;

/* 8) Summary of OKSchools data */
proc sort data=work.OKSchools out=work.sortedOKSchools;
by HSTotal;
run;

proc summary data=work.sortedOKSchools;
var STRatio;
class HSTotal;
by HSTotal;
output out=work.SummaryData mean=Ratio;
format HSTotal divi. STRatio classsz.;
title1 "Oklahoma School Analysis";
title3 "Average Student-Teacher Ratio by School Division";
run;

/* 9) Print descriptor portion of summary data */
proc print data=work.SummaryData noobs label;
by HSTotal;
run;


/* 10) Close PDF */
ods pdf close;

