set /a shift=!y! - 1
if "!table[%shift%][%x%]!" == "!way!" SET class=!class: t=!

set /a shift=!y! + 1
if "!table[%shift%][%x%]!" == "!way!" SET class=!class: d=!

set /a shift=!x! - 1
if "!table[%y%][%shift%]!" == "!way!" SET class=!class: l=!

set /a shift=!x! + 1
if "!table[%y%][%shift%]!" == "!way!" SET class=!class: r=!

SET "%~1=!class!"