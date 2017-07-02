@echo off

SET PATH=%PATH%;%CC65%

SET ORICUTRON="..\..\..\oricutron\"
set PATH_VID="usr\share\presto"
SET ORIGIN_PATH=%CD%

set VERSION="0.0.1"





%OSDK%\bin\xa.exe -v -R -cc src\vidplay.asm -o release\vidplay.o65
co65  release\vidplay.o65 


cl65 -ttelestrat src/vidplay.c release/vidplay.s  ..\oric-common\lib\ca65\telestrat\hires.s -o release\orix\bin\vidplay 






IF "%1"=="NORUN" GOTO End

copy  release\orix\bin\vidplay %ORICUTRON%\usbdrive\bin\vidplay


cd %ORICUTRON%
OricutronV4 -mt
cd %ORIGIN_PATH%
:End


