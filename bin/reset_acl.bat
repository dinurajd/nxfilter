@echo off
REM ##############################################
set OPATH=%cd%
set BPATH=%~dp0
cd %BPATH%
cd ..
set NX_HOME=%cd%
cd %OPATH%
REM ##############################################
java -cp "%NX_HOME%"\nxd.jar;"%NX_HOME%"\lib\*; nxd.NxAdmin reset_acl
