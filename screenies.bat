@echo off
rem 	for screencapping genga/douga credits

rem 	directory can't have japanese chars but file can?
set dirpath=.\folderthatholdsanimevideos
set credtime=22:45
set append=genga
set i=0
echo Working...
setlocal ENABLEDELAYEDEXPANSION
for %%f in ("%dirpath%"\*.*) do (
ffmpeg -v error -ss %credtime% -i "%%f" -vframes 1 -y "%%~nf"%append%.jpg 
if exist "%%~nf"%append%.jpg set /a i=i+1
)
echo Created %i% images.
endlocal
