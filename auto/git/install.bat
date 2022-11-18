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
call :GetDirectory project "https://github.com/GameTAS.git"
if "%project%" == "" exit /b 0

mkdir %project%
pushd %project%

git init
git remote add origin "%source%"
git checkout -b develop

:OriginCheck
git pull origin develop

if not %ERRORLEVEL% == 0 (
	echo Can't pull from origin
	git remote remove origin
	echo Enter the origin again:
	set /p source=
	git remote add origin "%source%"
	goto OriginCheck
)

popd

echo @echo off> sender.bat
echo echo What is done now?>> sender.bat
echo set /p message=>> sender.bat
echo pushd "%project%">> sender.bat
echo git pull origin develop>> sender.bat
echo git add .>> sender.bat
echo git commit -m "%%message%%">> sender.bat
echo git push origin develop>> sender.bat
echo popd>> sender.bat

REM Secret technique to self-destroy
:DeleteFile
(goto) 2>nul & del "%~f0"