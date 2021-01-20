@ECHO OFF
:: Surum v1.2.0
:: 08 Nisan, 2020

Set Run_Option=0
:: Anything other than following does nothing
:: 0 = Go to Script Menu
:: 1 = Run Script with Settings in Script File
:: 2 = Run Script with Windows Default
:: 3 = Run Script with Your Setting file (Change file name bellow)
:: 4 = Load Script with Windows Default (Does not run)
:: 5 = Load Script with Your Setting file (Does not run)

:: Script Uzantisi
Set Script_File=CapsWin10.ps1

:: Script Ayar Dosyasi
Set Setting_File=CapsWin10Ayar.csv
:: DO NOT HAVE SPACES IN FILENAME

:: Change these to yes or no
Set Accept_ToS=no
:: no = See ToS
:: yes = Skip ToS (You accepted it)

Set Create_Restore_Point=no
Set Restore_Point_Name=CapsWin10_SistemGeriYukleme
:: DO NOT HAVE SPACES IN NAME

Set Restart_when_Done=yes

:: Update Checks   
:: If update is found it will Auto-download and use that (with your settings)       
Set Script=no
Set Internet_Check=yes 
:: Internet_Check only matters If Script is yes and pings to github.com is blocked 

::----------------------------------------------------------------------
:: Do not change unless you know what you are doing
Set Script_Directory=%~dp0
Set Script_Path=%Script_Directory%%Script_File%

:: DO NOT CHANGE ANYTHING PAST THIS LINE
::----------------------------------------------------------------------
SETLOCAL ENABLEDELAYEDEXPANSION

If /i %Run_Option%==1 Set Run_Option=!Run_Option! -run
If /i %Run_Option%==2 Set Run_Option=!Run_Option! -run wd
If /i %Run_Option%==3 Set Run_Option=!Run_Option! -run %Setting_File%
If /i %Run_Option%==4 Set Run_Option=!Run_Option! -load wd
If /i %Run_Option%==5 Set Run_Option=!Run_Option! -load %Setting_File%

If /i %Accept_ToS%==yes Set Run_Option=!Run_Option! -atos

If /i %Create_Restore_Point%==yes Set Run_Option=!Run_Option! -crp %Restore_Point_Name%

If /i %Internet_Check%==no Set Run_Option=!Run_Option! -sic

If /i %Script%==yes Set Run_Option=!Run_Option! -usc

If /i %Restart_when_Done%==no Set Run_Option=!Run_Option! -dnr

color 4
echo "Dosya !Script_File! Okunuyor!"
echo "Lutfen Bekleyiniz..."
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '!Script_Path!' !Run_Option!" -Verb RunAs
ENDLOCAL DISABLEDELAYEDEXPANSION
