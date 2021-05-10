log close _all 	// closes any previously opened log file	

cd "C:\Users\hatho\Desktop\University Stuff\Economics\ECO375\Assignment 2\

local surname WANG

local firstname William

cap log close
log using "ECO375_`surname'_`firstname'_Assignment_2.log", replace text
set more off

clear

display "ECO375_Assignment_2" _n "`surname' `firstname' `studentnumber'" _n c(current_date) c(current_time)

use "daAssignment2.dta", clear

datasignature

describe	

xtset code_numeric year_numeric

********************************************************************************
* Descriptive Statistics
********************************************************************************

sum fhpolrigaug

sum polity4

sum lrgdpch

sum age_veryyoung

sum age_young

sum age_midage

sum age_old

sum age_veryold

sum education

sum lpop

sum fhpolrigaug if colony == 1

sum polity4 if colony == 1

sum fhpolrigaug if colony == 0

sum polity4 if colony == 0

sum fhpolrigaug if socialist == 1

sum polity4 if socialist == 1

sum fhpolrigaug if socialist == 0

sum polity4 if socialist == 0

********************************************************************************
* Freedom House index as outcome variable
********************************************************************************
// Base SLR robust
reg fhpolrigaug L1.lrgdpch, robust

// Base SLR robust and clustered by country
reg fhpolrigaug L1.lrgdpch, vce(cluster code_numeric)

// Base robust country fixed effects
reg fhpolrigaug L1.lrgdpch i.code_numeric, robust

// Base robust country and year fixed effects
reg fhpolrigaug L1.lrgdpch i.code_numeric i.year, robust

testparm i.year

// Base robust country and year fixed effects with lagged demographic controls subsample
reg fhpolrigaug L1.lrgdpch i.code_numeric i.year L1.age_young L1.age_midage L1.age_old L1.age_veryold L1.education L1.lpop, robust

gen demo_sample1=(e(sample)==1)

reg fhpolrigaug L1.lrgdpch i.code_numeric i.year if demo_sample1 == 1, robust

testparm i.year

// Base robust country and year fixed effects with lagged demographic controls
reg fhpolrigaug L1.lrgdpch i.code_numeric i.year L1.age_young L1.age_midage L1.age_old L1.age_veryold L1.education L1.lpop, robust

// F tests for exclusions
testparm i.year

test L1.age_midage L1.age_old L1.age_veryold L1.age_young

test L1.age_midage L1.age_old L1.age_veryold L1.age_young L1.education L1.lpop

********************************************************************************
* Polity4 index as outcome variable
********************************************************************************

// Base SLR robust
reg polity4 L1.lrgdpch, robust

// Base SLR robust and clustered by country
reg polity4 L1.lrgdpch, vce(cluster code_numeric)

// Base robust country fixed effects
reg polity4 L1.lrgdpch i.code_numeric, robust

// Base robust country and year fixed effects
reg polity4 L1.lrgdpch i.code_numeric i.year, robust

testparm i.year

// Base robust country and year fixed effects with lagged demographic controls Subsample
reg polity4 L1.lrgdpch i.code_numeric i.year L1.age_young L1.age_midage L1.age_old L1.age_veryold L1.education L1.lpop, robust

gen demo_sample2=(e(sample)==1)

reg polity4 L1.lrgdpch i.code_numeric i.year if demo_sample2 == 1, robust

testparm i.year

// Base robust country and year fixed effects with lagged demographic controls
reg polity4 L1.lrgdpch i.code_numeric i.year L1.age_young L1.age_midage L1.age_old L1.age_veryold L1.education L1.lpop, robust


// F tests for exclusions
testparm i.year

test L1.age_midage L1.age_old L1.age_veryold L1.age_young

test L1.age_midage L1.age_old L1.age_veryold L1.age_young L1.education L1.lpop

log close