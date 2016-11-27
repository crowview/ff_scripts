REM probe.bat

IF "%1"=="" (
ECHO Usage: probe path\to\video
ECHO takes a single video argument and tells you the width, height, pixel ratio, and display ratio of each video stream, ignoring non-video streams
) ELSE (
ffprobe -v error -show_entries format=size:width,height,sample_aspect_ratio,display_aspect_ratio,r_frame_rate,avg_frame_rate,bit_rate -select_streams v -unit "%1"
)
