@echo off
REM ##############################################
echo Adding firewall rules.
netsh advfirewall firewall add rule name=NxFilter_53_in protocol=UDP dir=in localport=53 action=allow > NUL
netsh advfirewall firewall add rule name=NxFilter_19002_in protocol=TCP dir=in localport=19002 action=allow > NUL
netsh advfirewall firewall add rule name=NxFilter_19003_in protocol=TCP dir=in localport=19003 action=allow > NUL
netsh advfirewall firewall add rule name=NxFilter_19004_in protocol=TCP dir=in localport=19004 action=allow > NUL
netsh advfirewall firewall add rule name=NxFilter_19003_out protocol=TCP dir=out remoteport=19003 action=allow > NUL
netsh advfirewall firewall add rule name=NxFilter_19004_out protocol=TCP dir=out remoteport=19004 action=allow > NUL
netsh advfirewall firewall add rule name=NxFilter_80_in protocol=TCP dir=in localport=80 action=allow > NUL
REM ##############################################
set BPATH=%~dp0
cd %BPATH%
cd ..
set NX_HOME=%cd%
REM ##############################################
prunsrv install NxFilter --Jvm=auto --StartMode=jvm --StopMode=jvm --StartClass=nxd.Main --StopTimeout=3 --Startup=auto --Classpath="%NX_HOME%"\nxd.jar;"%NX_HOME%"\lib\*; --JvmMx=512 ++Environment NX_HOME="%NX_HOME%"
net start NxFilter
pause