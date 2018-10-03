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

#publish artifacts
storageAccountExists=`az storage account list --query "[].name" --output tsv | grep $artifactsStorageAccount | wc -l`
if [ "$storageAccountExists" == "0" ]; then
	echo "Storage account \"$artifactsStorageAccount\" could not be found. Creating new storage account..."
	az storage account create -g $rg --location $location --name $artifactsStorageAccount --sku Standard_LRS --https-only true --kind StorageV2
else
	echo "Using existing storage account \"$artifactsStorageAccount\""
fi

storageContainerExists=`az storage container exists --account-name $artifactsStorageAccount --name $artifactsStorageContainer --output tsv | grep True | wc -l`
if [ "$storageContainerExists" == "0" ]; then
	echo "Storage container \"$artifactsStorageContainer\" could not be found. Creating new container..."
	az storage container create --account-name $artifactsStorageAccount --name $artifactsStorageContainer --public-access off
else
	echo "Using existing container \"$artifactsStorageContainer\""
fi

az storage blob upload-batch --destination $artifactsStorageContainer --source "$DIR/setup1artifacts/" --account-name $artifactsStorageAccount

az storage container policy create --name "readonly" --container-name $artifactsStorageContainer --account-name $artifactsStorageAccount
az storage container generate-sas --name $artifactsStorageContainer --account-name $artifactsStorageAccount XXX


deploymentName="setup1_starting_`date +%y%m%d_%HH%MM%SS.%N`"

#Start deployment
echo "Starting deployment \"$deploymentName\" ..."

az group deployment create --debug --name "$deploymentName" --resource-group "$rg" \
	--template-file "$DIR/setup1template.json" \
	--parameters uniquesuffix="$suffix" \
	--parameters tshirtSize="$dsvmSize" \
	--parameters location="$location" \
	--parameters vNetIpRange="$vNetIpRange" \
	--parameters defaultSubnetIpRange="$defaultSubnetIpRange" \
	--parameters idsvmSubnetIpRange="$idsvmSubnetIpRange" \
	--parameters dsvmAdminUsername="$adminUsername" \
	--parameters dsvmAdminPassword="$adminPassword"
#--parameters "@{$DIR/setup1parameters.json}"

if [ $?  == 0 ];
then
	echo "Template has been successfully deployed"
else
	echo "Template was NOT successfully deployed"
	exit 1
fi
