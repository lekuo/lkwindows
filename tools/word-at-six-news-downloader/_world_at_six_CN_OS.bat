rem @each off
rem -- http://www.cbc.ca/podcasting/pastpodcasts.html?3#ref3
N:
cd N:\_world_at_six

rem -- get mp3 file name
rem - set mydate="%Date%.mp3"
rem - set mydate=%mydate:/=_%
set year=%date:~6,4%
set month=%date:~3,2%
set day=%date:~0,2%
set mydate=%year%_%month%_%day%

_wget1.11.4.exe -q -O .\world_at_six\%mydate%.mp3 http://podcast.cbc.ca/w6/worldatsix.mp3