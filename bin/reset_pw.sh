#!/bin/sh
cd $(dirname $0)
cd ..
export NX_HOME=$PWD
export PATH=$PATH:/usr/bin:/usr/local/bin
java -cp $NX_HOME/nxd.jar:$NX_HOME/lib/*: nxd.NxAdmin reset_pw
