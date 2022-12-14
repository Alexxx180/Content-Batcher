@echo off
echo ^<^!-- Automatically generated by Content Batcher --^>>"%~2"
echo ^<^!-- © XEtreme Team 2022 --^>>>"%~2"

set source=%~1
set result=%~2
set delimiter=%~3
set trim=%~4

SETLOCAL ENABLEDELAYEDEXPANSION

echo Listen config
echo .............

SET /a ways.len=0
SET /a walls.len=0
SET /a areas.len=0

for /F "usebackq tokens=* delims=" %%A in ("config/ways.cfg") do (
	SET ways[!ways.len!]=%%A
	SET /a ways.len+=1
)

for /F "usebackq tokens=* delims=" %%A in ("config/walls.cfg") do (
	SET walls[!walls.len!]=%%A
	SET /a walls.len+=1
)

for /F "usebackq tokens=* delims=" %%A in ("config/areas.cfg") do (
	SET areas[!areas.len!]=%%A
	SET /a areas.len+=1
)

echo Listen classes
echo ..............

SET /p area=<"classes/areas.txt"

SET /a bs.len=0
for /F "usebackq tokens=* delims=" %%A in ("classes/borders.txt") do (
	SET bs[!bs.len!]=%%A
	SET /a bs.len+=1
)

call parser.bat "%~1"

ENDLOCAL