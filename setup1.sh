#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/initvars.sh

#login to azure using your credentials
az account show 1> /dev/null

if [ $? != 0 ];
then
	az login
fi

#set the default subscription
az account set -s "$subscription"

#Check for existing RG
searchresult=`az group show -g $rg | wc -l`

if [ "$searchresult" == "0" ]; then
	echo "Resource group with name ${rg} could not be found. Creating new resource group.."
	(
		set -x
		az group create --name ${rg} --location ${location} 1> /dev/null
	)
	else
	echo "Using existing resource group..."
fi

deploymentName="setup1 starting `date --rfc-3339=ns`"

#Start deployment
echo "Starting deployment..."

az group deployment create --name "$deploymentName" --resource-group "$rg" \
	--template-file "$DIR/setup1template.json" --parameters "@{$DIR/setup1parameters.json}" \
	--parameters uniquesuffix="$suffix" \
	--parameters tshirtSize="$dsvmSize" \
	--parameters location="$location" \
	--parameters vNetIpRange="$vNetIpRange" \
	--parameters defaultSubnetIpRange="$defaultSubnetIpRange" \
	--parameters idsvmSubnetIpRange="$idsvmSubnetIpRange" \
	--parameters dsvmAdminUsername="$adminUsername" \
	--parameters dsvmAdminPassword="$adminPassword"

if [ $?  == 0 ];
then
	echo "Template has been successfully deployed"
else
	echo "Template was NOT successfully deployed"
	exit 1
fi
