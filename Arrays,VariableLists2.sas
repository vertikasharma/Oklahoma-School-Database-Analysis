/* 1) Program Name: SAS HW15 */
/* Date Created: 11/12/2018 */
/* Author: Vertika Sharma */
/* Last Submitted: 11/12/2018 */
/* Program Location: F:\Texas_A&M\3rd Semester\STAT604\HW15\Assignment15 */
/* Purpose: Practice arrays and variable lists*/

/* Assign libnames to location of data */
libname hwdata 'F:\Texas_A&M\3rd Semester\STAT604\HW15';
/* Assign fileref for output pdf file */
filename vsfile 'F:\SAS\VSharma_H15_output.pdf';

/* 2) Create narrow dataset empcharity */
data hwdata.empcharity (keep = i employee_id organization);
set tmp1.charity (keep = employee_id charity:);
array charity {*} charity:;
do i=1 to dim(charity);
if charity{i} ne '' then do;
organization = charity{i};
output;
end;
end;
run;

/* 3) Sort empcharity dataset for merging */
proc sort data=hwdata.empcharity;
by organization;
run;

/* 4) Sorted copy of charities dataset */
proc sort data=tmp1.charities out=work.charitysorted (rename=(Charity=organization));
by organization;
run;

/* 5) Match merge the two datasets */
data work.mmdata (keep= employee_id i organization category);
merge hwdata.empcharity (in=emps) work.charitysorted (in=cell);
by organization;
if emps=1 and cell=1;
run;

/* 6) Transpose procedure to transform dataset */
proc sort data=work.mmdata;
by employee_id;
run;

proc transpose data= work.mmdata
out=work.rotate (rename=(col1=CH_Type1 col2=CH_Type2 col3=CH_Type3 col4=CH_Type4 col5=CH_Type5 col6=CH_Type6 col7=CH_Type7 col8=CH_Type8 col9=CH_Type9 col10=CH_Type10));
by employee_id;
var category;
run;


/* 7) Merge final dataset */
data work.finaldata;
merge tmp1.charity  work.rotate;
by employee_id;
array type{*} CH_type:;
array amount{*} Amount:;
child_d=0;
amount_d=0;
disease_d=0;
do j=1 to dim(type);
	if type{j}='Children' then
		child_d=sum(child_d,amount{j});
	else if type{j}='Disease' then
		disease_d=sum(disease_d,amount{j});
	total_d=sum(total_d,amount{j});
end;
label child_d='Donations for Children' 
	  disease_d='Donations for Disease'
	  total_d='Total Amount';

run;


/* 8) Print contents and data of final dataset */
ods pdf file=vsfile;
   /* Print descriptor portion */
proc contents data=work.finaldata varnum;
run;
  /* Print data portion */
proc print data=work.finaldata (keep=employee_id name department salary child_d disease_d total_d) noobs label;
run;

