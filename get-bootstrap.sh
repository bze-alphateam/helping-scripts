#!/bin/bash

# Download and Run
# wget https://raw.githubusercontent.com/bze-alphateam/useful-scripts/master/get-bootstrap.sh
# chmod u+x get-bootstrap.sh
# ./get-bootstrap.sh

###################################
## Grab latest BZEdge bootstrap ##
###################################

#Function to check for running process
check_process() {
  [ "$1" = "" ]  && return 0
  [ `pgrep -n $1` ] && return 1 || return 0
}


echo " "
echo " "
echo "  ---------------- READ THIS ----------------  "
echo " "
echo "      Grabbing current BZEdge bootstrap       "
echo " "
echo "To do this right we need to delete your BZEdge files"
echo " "
echo "We will leave your wallet.dat and config files alone"
echo " "
echo "Are you ok with that? (yes or no)"
read -i "yes" ALLOW

if [ "$ALLOW" == "no" ] || [ "$ALLOW" == "n" ]; then
    echo "Exiting Script..."
    exit 1
fi


#Check if the BZEdge daemon is currently running

echo " "
echo " "
echo "Checking for a running BZEdge daemon"
check_process "bzedged"
[ $? -eq 1 ] && echo "Safely stopping BZEdge daemon" && `cd ~` && `./bzedge-cli stop`

echo " "
echo " "
echo "Discount Double Check"
check_process "bzedged"
[ $? -eq 1 ] && echo "----ISSUE BZEdge daemon still running, you need to close it first" && exit 1


if [ -d ~/.bzedge ]

then

cp .bzedge/wallet.dat .
cp .bzedge/bzedge.conf .
cp .bzedge/masternode.conf .
sudo rm -r .bzedge
mkdir .bzedge
mv wallet.dat .bzedge/wallet.dat
mv bzedge.conf .bzedge/bzedge.conf
mv masternode.conf .bzedge/masternode.conf

echo " "
echo " "
echo "----------------------------------------------"
echo "| Files deleted while saving conf and wallet |"
echo "----------------------------------------------"

fi


#Download compressed bootstrap file
echo " "
echo " "
echo "-----------------------------------------"
echo "| Downloading current BZEdge bootstrap |"
echo "-----------------------------------------"

wget https://downloads.vidulum.app/bootstrap.zip


#Decompress
echo " "
echo " "
echo "-------------------------------------------------------"
echo "| Pulling all of the needles out of the new hay stack |"
echo "-------------------------------------------------------"

unzip bootstrap.zip


#Move everything to the Vidulum datadir
echo " "
echo " "
echo "----------------------------------------------"
echo "| Putting new needles into the new hay stack |"
echo "----------------------------------------------"
mv bootstrap/blocks ~/.bzedge/blocks
mv bootstrap/chainstate ~/.bzedge/chainstate
mv bootstrap/peers.dat ~/.bzedge/peers.dat

#Clean up
echo " "
echo " "
echo " Removing the hay stack "

rm bootstrap.zip
rm -r bootstrap

#Run the wallet and allow it to finish sync
echo " "
echo " "
echo "-----------------------------------------------------"
echo "| You can now start your BZEdge daemon  ./bzedged |"
echo "-----------------------------------------------------"
