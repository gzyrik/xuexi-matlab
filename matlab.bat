@ECHO OFF
rem 直接调用m文件: -r <文件短名>
rem start %~dp0\bin\win32\matlab.exe -nojvm -c %~dp0\licenses\license.lic -nosplash %*
start %~dp0\bin\win32\matlab.exe -nojvm -nosplash %*
