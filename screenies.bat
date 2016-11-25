@echo off
rem 	for screencapping genga/douga credits

set dirpath=.\folderthatholdsanimevideos
set credtime=23:57
set append=_genga
echo Working...
for %%f in ("%dirpath%\*.*") do (
    set "infile=%%~nf"
    set "extn=%%~xf"
    setlocal ENABLEDELAYEDEXPANSION
    ffmpeg -v error -ss %credtime% -i "%dirpath%\!infile!!extn!" -vframes 1 -y "!infile!%append%".jpg 
    if not exist "!infile!%append%".jpg echo Failed to create !infile!%append%.jpg
    endlocal
)
