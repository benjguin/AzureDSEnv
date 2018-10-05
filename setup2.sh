#!/bin/bash

nbAdditionalVMs=$1
suffixForAdditionalVMs=$2

echo "will create $nbAdditionalVMs VM(s) with a suffix of \"$suffixForAdditionalVMs\""

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/initvars.sh
source $DIR/initAzAndMisc.sh

az group deployment create --name "$deploymentName" --resource-group "$rg" \
	--template-file "$DIR/template.json" \
	--parameters uniqueSuffix="$suffix" \
	--parameters vmSuffix="$suffixForAdditionalVMs" \
	--parameters tshirtSize="$dsvmSize" \
	--parameters location="$location" \
	--parameters vNetIpRange="$vNetIpRange" \
	--parameters defaultSubnetIpRange="$defaultSubnetIpRange" \
	--parameters idsvmSubnetIpRange="$idsvmSubnetIpRange" \
	--parameters dsvmAdminUsername="$adminUsername" \
	--parameters dsvmAdminPassword="$adminPassword" \
	--parameters artifactsPrefix="$artifactsPrefix" \
	--parameters artifactsSuffix="$artifactsSuffix" \
	--parameters nbVMs=$nbAdditionalVMs \
	--parameters typeOfVM="individualDSVM"

source $DIR/endOfScripts.sh
