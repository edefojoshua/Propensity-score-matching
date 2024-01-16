ssc install psmatch2

use "C:\Users\joe62\OneDrive - Aberystwyth University\Apps\Desktop\HES_Extract_SDEC_in_Stata\Joshua\Data\STATA\Glangwili pathway 1t.dta"
gen length_of_stay = 0
replace length_of_stay  = LoS

save "C:\Users\joe62\OneDrive - Aberystwyth University\Apps\Desktop\HES_Extract_SDEC_in_Stata\Joshua\Data\STATA\Glangwili pathway 1tr.dta", replace

use "C:\Users\joe62\OneDrive - Aberystwyth University\Apps\Desktop\HES_Extract_SDEC_in_Stata\Joshua\Data\STATA\Glangwili pathway 1tr.dta"

append using "C:\Users\joe62\OneDrive - Aberystwyth University\Apps\Desktop\HES_Extract_SDEC_in_Stata\Joshua\Data\STATA\data from me\Glangwili ED patients with length of stay(2).dta"

order NHSNumber Age sex t length_of_stay

ttest length_of_stay, by(t)

* diff is 357minutes higer in non treatment group than in treatment group

*check if biased by confounding variable

encode sex, generate(sex1)
logistic t Age sex1

* odd ratio showed (1.02113, .8347214 )  It is clear that the relationship between our treatment and outcome is being confounded by x1 and x2, each having the effect in this case of increasing the observed treatment effect.

* propensity score matching uding nearest neighbour which is by default
teffects psmatch ( length_of_stay) (t Age sex1)

* diff is 413 min after psmatch