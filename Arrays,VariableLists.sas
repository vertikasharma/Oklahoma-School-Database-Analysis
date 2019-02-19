/* 1) Program Name: SAS HW14 */
/* Date Created: 11/01/2018 */
/* Author: Vertika Sharma */
/* Last Submitted: 11/01/2018 */
/* Program Location: F:\Texas_A&M\3rd Semester\STAT604\HW14\Assignment14 */
/* Purpose: arrays and variable lists*/

/* Assign libnames to location of data */
libname hwdata 'F:\Texas_A&M\3rd Semester\STAT604\HW14' access=readonly;
libname mylib 'F:\Texas_A&M\3rd Semester\STAT604\mylib';

/*2) Create new cleandata dataset */
data mylib.cleandata (drop=firstexam secondexam finalexam);
set hwdata.stat747 (rename=(exam1=firstexam exam2=secondexam finalexam=examfinal));

/*2a) Convert exam1 and exam2 from character to numeric */
select(firstexam);
when ('ND')
exam1=0;
otherwise exam1=input(firstexam, 6.);
end;

select(secondexam);
when ('ND')
exam2=0;
otherwise exam2=input(secondexam, 6.);
end;

/*2b) Create new variable examfinal based on value of CertScore */
label examfinal='Final Exam';
select(examfinal);
when('ND', 'EX')
if (CertScore='') then
examfinal=0;
else 
examfinal=CertScore;
when(examfinal<CertScore)
examfinal=CertScore;
otherwise
examfinal=input(examfinal, 6.); 
end;

/*2c) Replace minimum exam score by final exam score */
if (examfinal>min(exam1,exam2)) then do;
if (exam1>exam2) then 
exam2=examfinal;
else if (exam1<exam2) then
exam1=examfinal;
else if (exam1=exam2) then
exam1=examfinal;
end;

/*2d) Create new variable GPA */
GPA=round((0.4*mean(of Homework1-Homework12)+0.6*mean(of exam:)),0.001);
run;

/* Set up output pdf file */
ods pdf file="F:\Texas_A&M\3rd Semester\STAT604\HW14\VSharma_HW14_output.pdf";

/*3) Add proc to dataset and print descriptor portion of cleandata */
proc contents data=mylib.cleandata;
ods proclabel='Grades Data - Descriptor';
run;

/*4) Print data portion of cleandata along with labels*/
proc print data=mylib.cleandata label;
ods proclabel='Final Grades';
var student examfinal GPA;
run;

/*5) Create new dataset for speakers */
data work.confdata (drop=temp target);
set hwdata.conference;
by spekrID;
/*5a) Add label for speakers */
label SpekrID= 'Speaker';

/*5b) Create variable audiences with values of target */
retain Audiences;
length Audiences $100;
if (first.spekrID) then do;
Audiences='';
temp=0;
end;

audiences=catx(',',audiences,target);
temp+1;
if (last.spekrID) then do;
if (temp=0 or temp=4) then audiences='ALL';

/*5c) Add label for registration date */
label regdte='Registration Date';
output;
end;
run;


/*6) Print data for confdata */
proc print data=work.confdata label;
ods proclabel='Presentation Proposals';
run;

ods pdf close;
