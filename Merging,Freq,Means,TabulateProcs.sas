/* 1) Program Name: SAS HW16 */
/* Date Created: 11/19/2018 */
/* Author: Vertika Sharma */
/* Last Submitted: 11/20/2018 */
/* Program Location: F:\Texas_A&M\3rd Semester\STAT604\HW16\Assignment16 */
/* Purpose: Practice merging, freq, means, tabulate procedure */

/* Assign libnames to location of data */
libname hwdata 'F:\Texas_A&M\3rd Semester\STAT604\HW16';
/* Assign fileref for output pdf file */
filename vsfile 'F:\SAS\VSharma_HW16_output.pdf';

/* 2) Create three new datasets */

/* Sort the two datasets */
proc sort data=tmp1.final4 out=work.final4 (rename=(Team=School));
by team;
run;

proc sort data=tmp1.hi_scores out=work.hi_scores;
by school;
run;

/* Single data step for merge */
data hwdata.tourney2012 work.AT_HOME (drop= region seed) work.ALLDATA;
merge work.final4 (in=fin) work.hi_scores (in=hi);
by school;
if fin=1 then
output hwdata.tourney2012;
else if fin=0 and hi=1 then
output work.AT_HOME;
output work.ALLDATA;
run;

/* 3) Set up printing ods */
ods pdf file=vsfile; 
options nonumber dtreset orientation=landscape;

/* 4) Change order of observations */
proc sort data=work.AT_HOME;
by descending calc_ppg descending calc_pts descending fgm;
run;

/* 5) Print top 25 players */
proc print data=work.AT_HOME (obs=25) noobs label;
var rank name school conf fgm calc_pts calc_ppg;
label conf='Conference'
      fgm='FGM'
	  calc_pts='Total Point'
	  calc_ppg='Points per Game';
title1 "2012 NCAA Mens Basketball Championship";
title3 "Top 25 Players Not Playing in Tournament";
footnote "Scoring Totals as of March 1, 2012";
run; 

/* 6) Suppress date and footnotes in output file */
options nodate pageno=3;
footnote;

/* 7) Print frequency count for ALLDATA dataset */
proc freq data=work.ALLDATA;
tables conf*region / norow nocol nopercent missing;
where region ne '';
title1 "2012 NCAA Men's Basketball Championship";
title2 "Number of Players or Unrepresented Schools from Each Conference by Region";
run;

/* 8) Use means procedure on tourney2012 dataset */
proc means data = hwdata.tourney2012 maxdec=2 mean median q1 q3;
var calc_ppg;
class region position;
title1 "2012 NCAA Men's Basketball Championship";
title2 "Pre-Tournament Scoring by Region and Position";
run;


/* 9) Use means procedure on tourney2012 dataset */
proc tabulate data = hwdata.tourney2012;
table region*position all, calc_ppg*(N mean median q1 q3);
var calc_ppg;
class region position;
title1 "2012 NCAA Men's Basketball Championship";
title3 "Pre-Tournament Scoring by Region and Position";
run;

/* 10) Close output pdf */
ods pdf close;
