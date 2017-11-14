@echo off


REM Make file version V0.0.4

rem copy from rm
REM DEFINE VAR 
SET BINARYFILE=vidplay
SET PATH=%PATH%;%CC65%
SET ORICUTRON="..\..\..\oricutron\"
SET VERSION="1.0.0"
SET ORIGIN_PATH=%CD%
set DESCBIN=Play VHI(Hires video files) FILES
SET OTHERS_FILES_TO_LINK=..\oric-common\lib\ca65\telestrat\print.s ..\oric-common\lib\ca65\telestrat\returnline.s ..\oric-common\lib\ca65\telestrat\hires.s 


REM CREATE FOLDERS
IF NOT EXIST build\bin mkdir build\bin
IF NOT EXIST build\usr\share\doc\ mkdir build\usr\share\doc\
IF NOT EXIST build\usr\share\doc\%BINARYFILE% mkdir build\usr\share\doc\%BINARYFILE%
IF NOT EXIST build\usr\share\%BINARYFILE% mkdir build\usr\share\%BINARYFILE%
IF NOT EXIST build\usr\share\man mkdir build\usr\share\man
IF NOT EXIST build\usr\share\ipkg mkdir build\usr\share\ipkg



echo Compiling %BINARYFILE% ...
echo #define VERSION %VERSION% > src\version.h

echo | set /p dummyName=vidplay   1.0.0  Play vhi files > src\ipkg\%BINARYFILE%.csv
copy README.md build\usr\share\doc\%BINARYFILE%\
copy src\ipkg\%BINARYFILE%.csv build\usr\share\ipkg\
copy src\man\%BINARYFILE%.hlp build\usr\share\man\

copy data\*.vhi build\usr\share\%BINARYFILE%\

del /S /F  build\%BINARYFILE%.o65 
del /S /F  build\%BINARYFILE%.o 

%OSDK%\bin\xa.exe -R -cc src\%BINARYFILE%.asm -o build\%BINARYFILE%.o65
co65  build\%BINARYFILE%.o65 -o build\%BINARYFILE%.s
rem $(CO) src/$(PROGRAM).o -o src/$(PROGRAM)_cc65.s


cl65 -ttelestrat src/%BINARYFILE%.c build/%BINARYFILE%.s  %OTHERS_FILES_TO_LINK% -o build\bin\%BINARYFILE%

del /S /F   build\%BINARYFILE%.s



IF "%1"=="NORUN" GOTO End

copy data\*.vhi %ORICUTRON%\usbdrive\usr\share\%BINARYFILE%\
copy src\man\%BINARYFILE%.hlp %ORICUTRON%\usbdrive\usr\share\man\
copy  build\bin\%BINARYFILE% %ORICUTRON%\usbdrive\bin\%BINARYFILE%
copy src\ipkg\%BINARYFILE%.csv %ORICUTRON%\usbdrive\usr\share\ipkg\

cd %ORICUTRON%
OricutronV6 -mt
cd %ORIGIN_PATH%
:End


