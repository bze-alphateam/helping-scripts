#!/bin/bash


## Create BZEdge bootstrap ##

#drop to root dir
cd ~


#if bootstrap exists delete it
if [ -d ~/bootstrap ]

then

sudo rm -r bootstrap

fi


mkdir bootstrap && cd bootstrap


cp -r ~/.bzedge/blocks .
cp -r ~/.bzedge/chainstate .
cp ~/.bzedge/peers.dat .

cd ~

#compress
zip vdl_bootstrap.zip bootstrap


#upload file to hosting service (transfer.sh good for 14 days)
#curl --upload-file ./vdl_bootstrap.tar.gz https://transfer.sh/vdl_bootstrap.tar.gz
