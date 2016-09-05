@echo off
REM vidconcat.bat
REM list MP4 videos to concatenate in the arguments
REM use -o option to specify an output filename, sans extension

set output=concat_output
if exist concat_list.txt del concat_list.txt
goto cond

:loop
if "%1"=="-o" goto outname
echo file '%1' >> concat_list.txt
shift /1
goto cond

:outname
shift /1
set output=%1
shift /1

:cond
if not "%1"=="" goto loop
if not exist concat_list.txt goto usage 
echo Working...
ffmpeg -v error -f concat -i concat_list.txt -c copy %output%.mp4
if errorlevel 1 goto usage
echo Created %output%.mp4
goto end

:usage 
echo vidconcat.bat
echo usage: vidconcat vid1.mp4 [vid2.mp4 vid3.mp4...] [-o outname]
echo.

:end