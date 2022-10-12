set /a row=0

SET /a table.len=0
SET /a table[!table.len!].len=0

echo Reading
echo .......
for /F "usebackq tokens=* delims=" %%A in ("%source%") do (
	set row.current=%%A
	if defined trim set row.current=!row.current:%trim%=!
	
	set table[!table.len!]=!row.current!
	set /a table.len+=1
)
echo Parsing
echo .......
:nextRow
set row.current=!table[%row%]!

:nextCell
for /F "tokens=1* delims=%delimiter%" %%i in ("!row.current!") do (
	
	set /a cell=!table[%row%].len!

	set table[!row!][!cell!]=%%i
	set /a table[!row!].len+=1

	set row.current=%%j
	if not "!row.current:,=!"=="%%j" goto nextCell

	set /a cell=!table[%row%].len!

	set table[!row!][!cell!]=%%j
	set /a table[!row!].len+=1
)

set /a row+=1
set /a table[!row!].len=0

if !row! LSS !table.len! goto nextRow
echo .......
echo Complete

call processor.bat

ENDLOCAL