# This file is meant to be sourced as it only init variable values
# usage: source initvars.sh

if [ $?  == 0 ];
then
	echo "Template has been successfully deployed"
else
	echo "Template was NOT successfully deployed"
	exit 1
fi

az vm list -g $rg --query "[].{name: name,location: location,username: osProfile.adminUsername}" --output table
