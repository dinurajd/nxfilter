#!/bin/sh
cd $(dirname $0)
cd ..
export NX_HOME=$PWD
export PATH=$PATH:/usr/bin:/usr/local/bin
case $1 in
'-d')
	nohup java -Djava.net.preferIPv4Stack=true -Xmx512m -Djava.security.egd=file:/dev/./urandom -cp $NX_HOME/nxd.jar:$NX_HOME//lib/*: nxd.Main > /dev/null 2>&1 &
	;;
*)
	#java -Xmx512m -cp $NX_HOME/nxd.jar:$NX_HOME//lib/*: nxd.Main
	java -Djava.net.preferIPv4Stack=true -Xmx512m -Djava.security.egd=file:/dev/./urandom -cp $NX_HOME/nxd.jar:$NX_HOME//lib/*: nxd.Main
	;;
esac
