@echo off
rem 	sakugabooru encoder
cls

rem 	input with extension
if not defined input set input=.\DefaultIn.mkv
rem 	output without extension
if not defined output set output=DefaultOut
rem 	time clip starts
if not defined start set start=0
rem 	duration of clip
if not defined duration set duration=0


:beginning

echo INPUT is currently %input%
set /p input=Enter input filepath: 
echo.
echo OUTPUT is currently %output%
set /p output=Enter output name sans ext: 
echo.
echo START is currently %start%
set /p start=Enter start time: 
echo.
echo DURATION is currently %duration%
set /p duration=Enter duration: 
echo.

echo %date% %time% >> encode_log.txt
echo input:		%input% >> encode_log.txt
echo output: 	%output% >> encode_log.txt
echo start:		%start% >> encode_log.txt
echo duration: 	%duration% >> encode_log.txt

if "%1" == "test" goto test 


:final

echo mode: 		booru >> encode_log.txt

if exist *_test.mp4 del *_test.mp4

rem 	edited nainko encoder line
ffmpeg -v warning -stats -ss %start% -i "%input%" -t %duration% -an -sn -c:v libx264 -crf 19 -preset veryslow -tune animation -vf scale="trunc(oh*a/2)*2:480" %output%.mp4

if errorlevel 1 goto end

set playfile="%output%".mp4

rem 	redirects to log file
ffprobe -v error -show_entries stream=index,codec_type,width,height,sample_aspect_ratio,display_aspect_ratio,r_frame_rate,avg_frame_rate,bit_rate -unit "%playfile%" >> encode_log.txt

set loop=0
goto play


:test

echo mode: 		test >> encode_log.txt

rem 	fast encoding to test times. do not upload
ffmpeg -ss %start% -i "%input%" -t %duration% -an -sn -vf scale="trunc(oh*a/2)*2:480" -crf 40 -c:v libx264 -preset veryfast -tune animation -y %output%_test.mp4

if errorlevel 1 goto end

set playfile="%output%"_test.mp4
set loop=1


:play

start ffplay -i %playfile% -loop %loop%

ffprobe -v error -show_entries stream=index,codec_type,width,height,sample_aspect_ratio,display_aspect_ratio,r_frame_rate,avg_frame_rate,duration,bit_rate -unit "%playfile%"

echo. >> encode_log.txt

:end
