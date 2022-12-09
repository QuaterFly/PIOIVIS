@echo off
color 0A
setlocal enabledelayedexpansion

rem Getting argument
set n=%~1

rem If argument is null
if "%n%" == "" (
echo The argument mustn`t be null
goto WrongArgument
)


rem Check on letters in argument
@echo %n%|findstr /R "[^0-9]"
If %ERRORLEVEL% == 0 (
	echo The string contains one or more non numeric characters
	goto WrongArgument
)

set k=0

set m=0

rem Finding the biggest number
for /l %%i in (0,1,9) do (

	rem Setting counter
	set m=%%i

	rem Deleting numbers from 0 to 9
	Call Set "n=%%n:!m!=%%"

	rem When after deleting numbers argument is null then counter is the biggest number
	if /i "!n!" == "" (
		goto finfor
	)
)

:finfor
for /l %%x in (1,1,%m%) do (
	rem Every first file is .txt
	if !k! == 0 (
		cd Result
		@echo.>%%x.txt
		cd ..
		set k=1
	) else ( rem Every second file is .doc and contains date
		cd Result
		date /t >%%x.doc
		cd ..
		set k=0
	)
)

rem If argument is wrong
:WrongArgument

pause