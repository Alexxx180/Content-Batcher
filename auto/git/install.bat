@echo off
goto ArchitectureCheck

:GetDirectory
set "%~1=%~n2"
exit /b 0


:ArchitectureCheck
if exist "%ProgramFiles(x86)%" (
	set architecture=64
) else (
	set architecture=32
)


:GitInstall
where git
if not %ERRORLEVEL% == 0 (
	echo Download Git-x%architecture%?
	start https://github.com/git-for-windows/git/releases/download/v2.38.1.windows.1/Git-2.38.1-%architecture%-bit.exe
	echo Continue when Git will be installed.
	pause
	goto GitInstall
)


:ReceivingProject
echo Enter the origin:
set /p source=

if "%source%" == "" exit /b 0
call :GetDirectory project "%source%"
if "%project%" == "" exit /b 0

mkdir logs
echo Project name: "%project%">> logs/setup.log 2>> logs/setup-ERROR.log

mkdir %project%
pushd %project%

git init>> ../logs/setup.log
git remote add origin "%source%">> ../logs/setup.log 2>> ../logs/setup-ERROR.log
git checkout -b develop>> ../logs/setup.log 2>> ../logs/setup-ERROR.log

:OriginCheck
git pull origin develop>> ../logs/setup.log 2>> ../logs/setup-ERROR.log

if not %ERRORLEVEL% == 0 (
	echo Can't pull from origin
	git remote remove origin>> ../logs/setup.log 2>> ../logs/setup-ERROR.log
	echo Enter the origin again:
	set /p source=
	git remote add origin "%source%">> ../logs/setup.log 2>> ../logs/setup-ERROR.log
	goto OriginCheck
)

popd


:CreatingSender
echo @echo off> sender.bat
echo echo What is done now?>> sender.bat
echo set /p message=>> sender.bat
echo Project name: "%project%"^>^> ../logs/%%DATE%%.log 2^>^> ../logs/%%DATE%%-ERROR.log>> sender.bat
echo pushd "%project%">> sender.bat
echo git pull origin develop^>^> ../logs/%%DATE%%.log 2^>^> ../logs/%%DATE%%-ERROR.log >> sender.bat
echo git add .^>^> ../logs/%%DATE%%.log 2^>^> ../logs/%%DATE%%-ERROR.log>> sender.bat
echo git commit -m "%%message%%"^>^> ../logs/%%DATE%%.log 2^>^> ../logs/%%DATE%%-ERROR.log>> sender.bat
echo git push origin develop^>^> ../logs/%%DATE%%.log 2^>^> ../logs/%%DATE%%-ERROR.log>> sender.bat
echo popd>> sender.bat

:DeleteFile
(goto) 2>nul & del "%~f0"