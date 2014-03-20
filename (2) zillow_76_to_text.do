* (2) zillow_76_to_text.do
* this code does a quick clean of atype 76
* 	(1) merge final list of properties. keep only atype 76. remove all non alpha-numeric characters. replaces with spaces.
*	(2) export text file

clear all
set more off

do "D:/Dan's Workspace/GitHub Repository/zillow_projects/removesym.ado"
global dir "D:/Dan's Workspace/Zillow/"
cd "$dir"

**** (1)
use "$dir/data/zillow_stacked_merged", clear
merge m:1 pid using "$dir/data/zillow_property_list_final"
keep if _merge == 3
keep if atype == 76
drop _merge

removesym avalue, spanish basic
removesym avalue, ext
replace avalue = trim(avalue)
tempfile keep76
save `keep76', replace
drop if missing(avalue)

save "$dir/data/atype76", replace

use "$dir/data/atype76", clear

outfile pid avalue using "$dir/data/atype76.txt", replace noquote wide

sample .0001
outfile pid avalue using "D:/Dan's Workspace/GitHub Repository/zillow_projects/atype76.txt", replace noquote wide


exit, STATA clear
