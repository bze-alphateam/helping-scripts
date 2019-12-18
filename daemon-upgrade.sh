#!/bin/bash

# Download and Run
# wget https://raw.githubusercontent.com/bze-alphateam/useful-scripts/master/daemon-upgrade.sh
# chmod u+x daemon-upgrade.sh
# ./daemon-upgrade.sh

#Upgrade Node to current release
sudo apt install unzip

echo " "
echo " "
echo "Upgrading BZEdge daemon and client"

echo " "
./bzedge-cli stop

echo " "
echo " "
echo "Waiting for 15 seconds while daemon stops"
sleep 15

rm bzedged
rm bzedge-cli

echo " "

if [ -e ~/.vidulum-params/sprout-groth16.params ]
then
echo "Groth 16 Sapling params already present!"
else
echo "Downloading Groth16 Sapling params"

wget -O .vidulum-params/sprout-groth16.params https://github.com/vidulum/sapling-params/releases/download/sapling/sprout-groth16.params
fi

echo " "

if [ -e ~/.vidulum-params/sapling-spend.params ]
then
echo "Sapling-spend params already present!"
else
echo "Downloading Sapling-spend params"

wget -O .vidulum-params/sapling-spend.params https://github.com/vidulum/sapling-params/releases/download/sapling/sapling-spend.params
fi

echo " "

if [ -e ~/.vidulum-params/sapling-output.params ]
then
echo "Sapling-output params already present!"
else
echo "Downloading Sapling-output params"

wget -O .vidulum-params/sapling-output.params https://github.com/vidulum/sapling-params/releases/download/sapling/sapling-output.params
fi


echo " "
wget -q --show-progress https://github.com/vidulum/vidulum/releases/download/v2.0.2/VDL-Linux.zip

echo " "
unzip VDL-Linux.zip

rm VDL-Linux.zip

mv VDL-Linux/bzedge-cli .
mv VDL-Linux/bzedged .
mv VDL-Linux/bzedge-tx .

chmod u+x bzedge-cli
chmod u+x bzedged
chmod u+x bzedge-tx

rm -r VDL-Linux

./bzedged -daemon=1

echo "napping again 10s"
sleep 10

echo " "
echo " "

#Trying too hard
#echo "The next line should be  protocolversion:  170009"
#./bzedge-cli getnetworkinfo | grep -i 'protocolversion'
echo "Done"
