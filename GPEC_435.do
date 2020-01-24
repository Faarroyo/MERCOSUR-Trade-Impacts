clear all
capture log close
set more off
cd "C:\Users\feder\Desktop\Stata Documents\dta_files"
log using Arroyo_Federico_GPEC_435.txt,replace
*Federico Arroyo:A13124655
use gravdata_irgn435.dta
*Creating the Log variables
gen lnv=log(trade/pce)
gen lny_d=log(gdp_d/pce)
gen lny_o=log(gdp_o/pce)
gen lny=lny_d + lny_o
gen lnd=log(dist)
gen lng=lny-lnd
tab year, gen(yr)
gen impexp=iso_d+iso_o
*Creating the Log graph
*graph twoway (scatter lnv lng) (lfit lnv lng) if name_o=="Argentina",title("Argentina's Gravity Model Logs") ytitle("log trade") xtitle("log gravity index")
*graph export Argentina.png,replace
*Levels variables
gen nv=trade/pce
gen ny_d=gdp_d/pce
gen ny_o=gdp_o/pce
gen ny=ny_d*ny_o
gen nd=dist
gen ng=ny/nd

*Initial Mercosur Dummy
*Mercosur_o
gen mercosur_o=0
replace mercosur_o=1 if name_o=="Argentina" & year>=1991
replace mercosur_o=1 if name_o=="Brazil" & year>=1991
replace mercosur_o=1 if name_o=="Paraguay" & year>=1991 & year!=2012
replace mercosur_o=1 if name_o=="Uruguay" & year>=1991 
replace mercosur_o=1 if name_o=="Bolivia" & year>=1996
replace mercosur_o=1 if name_o=="Chile" & year>=1996
replace mercosur_o=1 if name_o=="Peru" & year>=2003
replace mercosur_o=1 if name_o=="Colombia" & year>=2004
replace mercosur_o=1 if name_o=="Ecuador" & year>=2004
replace mercosur_o=1 if iso_o=="VEN" & year>=2012
replace mercosur_o=1 if name_o=="Guyana" & year>=2013
replace mercosur_o=1 if name_o=="Surinam" & year>=2013
*mercosur_d
gen mercosur_d=0
replace mercosur_d=1 if name_d=="Argentina" & year>=1991
replace mercosur_d=1 if name_d=="Brazil" & year>=1991
replace mercosur_d=1 if name_d=="Paraguay" & year>=1991 & year!=2012
replace mercosur_d=1 if name_d=="Uruguay" & year>=1991 
replace mercosur_d=1 if name_d=="Bolivia" & year>=1996
replace mercosur_d=1 if name_d=="Chile" & year>=1996
replace mercosur_d=1 if name_d=="Peru" & year>=2003
replace mercosur_d=1 if name_d=="Colombia" & year>=2004
replace mercosur_d=1 if name_d=="Ecuador" & year>=2004
replace mercosur_d=1 if iso_d=="VEN" & year>=2012
replace mercosur_d=1 if name_d=="Guyana" & year>=2013
replace mercosur_d=1 if name_d=="Surinam" & year>=2013

*mercosur_both
gen mercosur_both=mercosur_d*mercosur_o

gen mercosur_c=0
replace mercosur_c=1 if name_o=="Argentina" 
replace mercosur_c=1 if name_o=="Brazil" 
replace mercosur_c=1 if name_o=="Paraguay" 
replace mercosur_c=1 if name_o=="Uruguay"
replace mercosur_c=1 if name_o=="Bolivia"
replace mercosur_c=1 if name_o=="Peru" 
replace mercosur_c=1 if name_o=="Colombia"
replace mercosur_c=1 if name_o=="Ecuador"
replace mercosur_c=1 if name_o=="Chile"
replace mercosur_c=1 if iso_o=="VEN"
replace mercosur_c=1 if name_o=="Guyana"
replace mercosur_c=1 if name_o=="Surinam"
gen mercosur_cd=0
replace mercosur_cd=1 if name_d=="Argentina"
replace mercosur_cd=1 if name_d=="Brazil"
replace mercosur_cd=1 if name_d=="Paraguay"
replace mercosur_cd=1 if name_d=="Uruguay"
replace mercosur_cd=1 if name_d=="Bolivia"
replace mercosur_c=1 if name_o=="Chile"
replace mercosur_cd=1 if name_d=="Peru"
replace mercosur_cd=1 if name_d=="Colombia"
replace mercosur_cd=1 if name_d=="Ecuador"
replace mercosur_cd=1 if iso_d=="VEN"
replace mercosur_cd=1 if name_d=="Guyana"
replace mercosur_cd=1 if name_d=="Surinam"

*Mercosur Countries

gen la_c=0
replace la_c=1 if name_o=="Belize"
replace la_c=1 if name_o=="El Salvador"
replace la_c=1 if name_o=="Guatemala"
replace la_c=1 if name_o=="Honduras"
replace la_c=1 if name_o=="Mexico"
replace la_c=1 if name_o=="Panama"
replace la_c=1 if name_o=="Costa Rica"
replace la_c=1 if name_o=="Nicaragua"
replace la_c=1 if name_o=="Chile"
replace la_c=1 if name_o=="Haiti"
replace la_c=1 if name_o=="Bahamas"
replace la_c=1 if name_o=="Jamaica"
replace la_c=1 if name_o=="Puerto Rico"
replace la_c=1 if name_o=="Trinidad & Tobago"
replace la_c=1 if name_o=="Cuba"
replace la_c=1 if name_o=="Dominican Republic"


gen la_cd=0
replace la_cd=1 if name_o=="Belize"
replace la_cd=1 if name_o=="El Salvador"
replace la_cd=1 if name_o=="Guatemala"
replace la_cd=1 if name_o=="Honduras"
replace la_cd=1 if name_o=="Mexico"
replace la_cd=1 if name_o=="Panama"
replace la_cd=1 if name_o=="Costa Rica"
replace la_cd=1 if name_o=="Nicaragua"
replace la_cd=1 if name_o=="Chile"
replace la_cd=1 if name_o=="Haiti"
replace la_cd=1 if name_o=="Bahamas"
replace la_cd=1 if name_o=="Jamaica"
replace la_cd=1 if name_o=="Puerto Rico"
replace la_cd=1 if name_o=="Trinidad & Tobago"
replace la_cd=1 if name_o=="Cuba"
replace la_cd=1 if name_o=="Dominican Republic"

gen LA_countries=la_cd*la_c

gen mercosur_countries=mercosur_c*mercosur_cd

*Mercosur Strengthening with all associates joined
gen merco_sth=0
replace merco_sth=1 if mercosur_both==1 & year>=2005

*CREATE VISUAL TRADE GRAPHS
preserve
collapse (sum) nv (mean)ny_o, by(year name_o)
sort name_o year
by name_o:gen p4=((ny_o[_n]-ny_o[_n-1])/(ny_o[_n-1]))*100
*twoway (line lny_o year)
twoway line nv year if name_o=="Argentina",xline(1991,lpattern(dash)) xline(2005) title("Argentina's Trade Normalized by PCE") ytitle(Trade)
graph export Argentina.png,replace
twoway line nv year if name_o=="Brazil",xline(1991,lpattern(dash)) xline(2005) title("Brazil's Trade Normalized by PCE") ytitle(Trade)
graph export Brazil.png,replace
twoway line nv year if name_o=="Paraguay",xline(1991,lpattern(dash)) xline(2005,lpattern(dashed)) title("Paraguay's Trade Normalized by PCE") ytitle(Trade)
graph export Paraguay.png,replace
twoway line nv year if name_o=="Uruguay",xline(1991,lpattern(dash)) xline(2005,lpattern(dashed)) title("Uruguay's Trade Normalized by PCE") ytitle(Trade)
graph export Uruguay.png,replace
twoway line nv year if name_o=="Ecuador",xline(1991,lpattern(dash)) xline(2005,lpattern(dashed)) title("Ecuador's Trade Normalized by PCE") ytitle(Trade)
graph export Ecuador.png,replace
twoway line nv year if name_o=="Bolivia",xline(1991,lpattern(dash)) xline(2005,lpattern(dashed)) title("Bolivias's Trade Normalized by PCE") ytitle(Trade)
graph export Bolivia.png,replace
twoway line nv year if name_o=="Peru",xline(1991,lpattern(dash)) xline(2005) title("Peru's Trade Normalized by PCE") ytitle(Trade)
graph export Peru.png,replace
twoway line nv year if name_o=="Colombia",xline(1991,lpattern(dash)) xline(2005) title("Colombia's Trade Normalized by PCE") ytitle(Trade)
graph export Colombia.png,replace
twoway line nv year if name_o=="Chile",xline(1991,lpattern(dash)) xline(2005) title("Chile's Trade Normalized by PCE") ytitle(Trade)
graph export Chile.png,replace
*Graphing GDP
twoway line p4 year if name_o=="Argentina",yline(0,lpattern(dash)) title("Argentina's GDP Growth Normalized by PCE") ytitle(GDP Growth %)
graph export Argentina_gdp.png,replace
twoway line p4 year if name_o=="Brazil",yline(0,lpattern(dash)) title("Brazil's GDP Growth Normalized by PCE") ytitle(GDP Growth %)
graph export Brazil_gdp.png,replace
twoway line p4 year if name_o=="Paraguay",yline(0,lpattern(dash)) title("Paraguay's GDP Growth Normalized by PCE") ytitle(GDP Growth %)
graph export Paraguay_gdp.png,replace
twoway line p4 year if name_o=="Uruguay",yline(0,lpattern(dash)) title("Uruguay's GDP Growth Normalized by PCE") ytitle(GDP Growth %)
graph export Uruguay_gdp.png,replace
twoway line p4 year if name_o=="Ecuador",yline(0,lpattern(dash)) title("Ecuador's GDP Growth Normalized by PCE") ytitle(GDP Growth %)
graph export Ecuador_gdp.png,replace
twoway line p4 year if name_o=="Bolivia",yline(0,lpattern(dash)) title("Bolivias's GDP Growth Normalized by PCE") ytitle(GDP Growth %)
graph export Bolivia_gdp.png,replace
twoway line p4 year if name_o=="Peru",yline(0,lpattern(dash))title("Peru's GDP Growth Normalized by PCE") ytitle(GDP Growth %)
graph export Peru_gdp.png,replace
twoway line p4 year if name_o=="Colombia",yline(0,lpattern(dash)) title("Colombia's GDP Growth Normalized by PCE") ytitle(GDP Growth %)
graph export Colombia_gdp.png,replace
twoway line p4 year if name_o=="Chile",yline(0,lpattern(dash))title("Chile's GDP Growth Normalized by PCE") ytitle(GDP Growth %)
graph export Chile_gdp.png,replace


restore
*Create GDP Graph

gen trade_agreement=0
replace trade_agreement=1 if fta_wto==1 | gatt_o==1 | gatt_d==1

*CREATE COUNTRY PAIR DUMMIES
gen impexp=iso_d+iso_o

*CREATE IMPORTER AND EXPORTER DUMMIES
tab iso_o, gen(ee)
tab iso_d, gen(ii)

*CREATE LEAD OF FTA AND GATT VARIABLES FOR PLACEBO REGRESSIONS
sort impexp year

by impexp: gen merc_lag=mercosur_both[_n-3]
by impexp: gen merc_lead=mercosur_both[_n+3]


*RUN GRAVITY REGRESSIONS, USE PROFESSIONAL QUALITY TABLES (REQUIRES INSTALLING ESTTAB)

*clear esttab settings
eststo clear

*gravity plus country pair fixed effects
eststo : qui reg lnv lny lnd contig comlang_ethno colony trade_agreement mercosur_both merco_sth yr*, robust 

*gravity plus country pair fixed effects, 3 year placebo sample restriction
eststo : qui areg lnv lny lnd contig comlang_ethno colony trade_agreement merc_lag mercosur_both merco_sth yr*, abs(impexp) cluster(impexp) 

*gravity plus country pair fixed effects plus 3 year placebo
eststo : qui areg lnv lny lnd contig comlang_ethno colony trade_agreement merc_lead mercosur_both merco_sth yr*, abs(impexp) cluster(impexp) 

*gravity plus country pair fixed effects plus 3 year placebo
eststo : qui areg lnv lny lnd contig comlang_ethno colony trade_agreement merc_lead merc_lag mercosur_both merco_sth yr*, abs(impexp) cluster(impexp) 


*gravity plus country pair fixed effects, 6 year placebo sample restriction
*eststo : qui areg lnv lny lnd contig comlang_ethno colony trade_agreement mercosur_both merco_sth yr*, abs(impexp) cluster(impexp) 

*gravity plus country pair fixed effects plus 3 and 6 year placebos
*eststo : qui areg lnv lny lnd contig comlang_ethno colony trade_agreement mercosur_both merco_sth yr*, abs(impexp) cluster(impexp) 

*display tables
esttab using gpec_435_real.csv, ar2 se(3) drop(yr* _cons)





log close
