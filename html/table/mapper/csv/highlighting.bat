set zone=
set /a len=!areas.len!-1
for /l %%w in (0, 1, !len!) do (
	if "!cell!" == "!areas[%%w]!" (
		set zone=!area! 
		set "%~2=?"
		goto borderChecks
	)
)

set /a len=!ways.len!-1
for /l %%w in (0, 1, !len!) do (
	if "!cell!" == "!ways[%%w]!" (
		set "%~2=."
		goto borderChecks
	) 
)

set "%~2=^!"
set /a len=!walls.len!-1
for /l %%w in (0, 1, !len!) do (
	if "!cell!" == "!walls[%%w]!" exit /b 0
)
set class= class="!bs[1]! !bs[2]!"
set "%~1=!class!"
set "%~2=$"
exit /b 0

:borderChecks
set way=
set class= !bs[3]! !bs[4]! !bs[5]! !bs[6]!
for /l %%w in (0, 1, !len!) do (

	set way=!ways[%%w]!
	call checks.bat class
	if "!class!" == "" exit /b 0
)

if "!class!" == " !bs[3]! !bs[4]! !bs[5]! !bs[6]!" SET class= !bs[2]!
set class= class="!zone!!bs[0]!!class!"
set "%~1=!class!"