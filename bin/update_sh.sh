#!/bin/sh
cd $(dirname $0)
cd ..
export NX_HOME=$PWD
export PATH=$PATH:/usr/bin:/usr/local/bin
java -Xms256m -Xmx512m -cp $NX_HOME/nxd.jar:$NX_HOME/lib/*: nxd.util.ShallaUpdate "$@"
