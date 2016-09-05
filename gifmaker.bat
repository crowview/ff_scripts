@ECHO OFF

SET input=F:\anime\[Kagura] Hades Project Zeorymer [BDRip 1440x1080 x264 Hi10P TrueHD]\[Kagura] Hades Project Zeorymer - 2 [BDRip 1440x1080 x264 Hi10P TrueHD].mkv
SET output=machine
SET start=20:06
SET duration=0.5
SET fps=24
SET scale=480

if "%1"=="test" goto test


:gifmake

ffmpeg -ss %start% -i "%input%" -t %duration% -c:v libx264 -crf 15 -vf scale=-2:480 -preset veryslow -an -sn -y infile.mp4

ffmpeg -y -i infile.mp4 -vf fps=%fps%,scale=%scale%:-1:flags=lanczos,palettegen palette.png

ffmpeg -i infile.mp4 -i palette.png -filter_complex "fps=%fps%,scale=%scale%:-1:flags=lanczos[x];[x][1:v]paletteuse" -y %output%.gif

DEL palette.png

DEL infile.mp4

DEL *_test.mp4

set to_play=%output%.gif

goto play


:test

ffmpeg -ss %start% -i "%input%" -t %duration% -c:v libx264 -crf 35 -vf scale=-2:%scale% -preset veryfast -an -sn -y "%output%"_test.mp4

set to_play="%output%"_test.mp4


:play 

start ffplay -i %to_play% -loop 0
