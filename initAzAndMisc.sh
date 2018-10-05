# This file is meant to be sourced as it only init variable values
# usage: source initvars.sh

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

az storage blob upload-batch --destination $artifactsStorageContainer --source "$DIR/artifacts/" --account-name $artifactsStorageAccount

policyExpirationYear=$((`date +%Y`+2))
policyExpirationDateTime="$policyExpirationYear-`date +%m-%d`T23:59:59Z"
az storage container policy create --name "artifactsreadonly" --container-name "$artifactsStorageContainer" --account-name "$artifactsStorageAccount" --expiry "$policyExpirationDateTime" --permissions "r"
artifactsSas=`az storage container generate-sas --name $artifactsStorageContainer --account-name $artifactsStorageAccount --policy-name "artifactsreadonly" --output tsv`
artifactsPrefix="https://${artifactsStorageAccount}.blob.core.windows.net/${artifactsStorageContainer}/"
artifactsSuffix="?${artifactsSas}"

deploymentName="setup_starting_`date +%y%m%d_%HH%MM%SS.%N`"

#Start deployment
echo "Starting deployment \"$deploymentName\" ..."
