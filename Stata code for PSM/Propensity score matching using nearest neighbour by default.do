*************************************
* Propensity score matchinh using Stata software
* Joshua W. Edefo
* email: edefojoshua2000@yahoo.com
* 16/01/2024
*************************************
* Install the module
ssc install psmatch2

* Get the data and transformed it for analysis
use "C:\Users\joe62\OneDrive - Aberystwyth University\Apps\Desktop\HES_Extract_SDEC_in_Stata\Joshua\Data\STATA\Glangwili pathway 1t.dta"
gen length_of_stay = 0
replace length_of_stay  = LoS

save "C:\Users\joe62\OneDrive - Aberystwyth University\Apps\Desktop\HES_Extract_SDEC_in_Stata\Joshua\Data\STATA\Glangwili pathway 1tr.dta", replace

use "C:\Users\joe62\OneDrive - Aberystwyth University\Apps\Desktop\HES_Extract_SDEC_in_Stata\Joshua\Data\STATA\Glangwili pathway 1tr.dta"

append using "C:\Users\joe62\OneDrive - Aberystwyth University\Apps\Desktop\HES_Extract_SDEC_in_Stata\Joshua\Data\STATA\data from me\Glangwili ED patients with length of stay(2).dta"

order NHSNumber Age sex t length_of_stay

* Conduct t test to check for difference between the SDEC group and non-SDEC group without considering confounding variables
ttest length_of_stay, by(t)

* difference is 357 minutes higer in non-SDEC group than in SDEC group

*Check if biased by confounding variable
encode sex, generate(sex1)
logistic t Age sex1

* odd ratio showed (1.02113, .8347214 ), It is clear that the relationship between our intervention (SDEC) and outcome is being confounded by Age and Sex, each having the effect in this case of increasing the observed treatment effect.

* Propensity score matching using nearest neighbour which is by default
teffects psmatch ( length_of_stay) (t Age sex1)

* After psmatch (propensity score matching), the difference is now 413 minutes higher in non-SDDEC group compared to SDEC group 