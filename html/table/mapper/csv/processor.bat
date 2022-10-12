echo ^<table^>>>!result!
echo+>>!result!

set /a len=!table.len!-1

echo Processing
echo ..........
for /l %%r in (0, 1, !len!) do (

	echo ^<tr^>>>!result!
	set /a row.len=!table[%%r].len!-1

	for /l %%c in (0, 1, !row.len!) do (
		set borders=
		set /a y=%%r
		set /a x=%%c

		set cell=!table[%%r][%%c]!
		call highlighting.bat borders progress

		echo|set /p="<td!borders!>!cell!</td>">>!result!
		echo|set /p="!progress!"
	)

	set /a loading=%%r+1
	echo [!loading! / !table.len!]

	echo+>>!result!
	echo ^</tr^>>>!result!
	echo+>>!result!
)

echo ^</table^>>>!result!