@echo off
REM ##############################################
echo Deleting firewall rules.
netsh advfirewall firewall delete rule name=NxFilter_53 > NUL
netsh advfirewall firewall delete rule name=NxFilter_19002_in > NUL
netsh advfirewall firewall delete rule name=NxFilter_19003_in > NUL
netsh advfirewall firewall delete rule name=NxFilter_19004_in > NUL
netsh advfirewall firewall delete rule name=NxFilter_19003_out > NUL
netsh advfirewall firewall delete rule name=NxFilter_19004_out > NUL
REM ##############################################
set BPATH=%~dp0
cd %BPATH%
cd ..
REM ##############################################
net stop NxFilter
prunsrv delete NxFilter
