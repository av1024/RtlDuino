@echo off
if %1x==x goto no_dir
if not exist %1\ota.bin goto error
PATH=%1;%2;%PATH%
if exist %2\ota.bin del %2\ota.bin
copy /b %1\ota.bin %2\ota.bin
copy /b %1\ram_all.bin %2\ram_all.bin
cd %2
start JLinkGDBServer.exe -device Cortex-M3 -if SWD -ir -endian little -speed 3500 
%3arm-none-eabi-gdb.exe -x gdb_img.jlink
taskkill /F /IM JLinkGDBServer.exe
goto end
:no_dir
PATH=D:\MCU\SEGGER\JLink_V612i;%LOCALAPPDATA%\Arduino15\packages\realtek\tools\ameba_tools\arm-none-eabi-gcc\4.8.3-2014q1\bin;%PATH% 
start JLinkGDBServer.exe -device Cortex-M3 -if SWD -ir -endian little -speed 3500 
arm-none-eabi-gdb.exe -x gdb_img.jlink
taskkill /F /IM JLinkGDBServer.exe
goto end
goto end
:error
echo Error: ram_all.bin ??
:end