#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/initvars.sh
source $DIR/initAzAndMisc.sh

az group deployment create --name "$deploymentName" --resource-group "$rg" \
	--template-file "$DIR/template.json" \
	--parameters uniquesuffix="$suffix" \
	--parameters tshirtSize="$dsvmSize" \
	--parameters location="$location" \
	--parameters vNetIpRange="$vNetIpRange" \
	--parameters defaultSubnetIpRange="$defaultSubnetIpRange" \
	--parameters idsvmSubnetIpRange="$idsvmSubnetIpRange" \
	--parameters dsvmAdminUsername="$adminUsername" \
	--parameters dsvmAdminPassword="$adminPassword" \
	--parameters artifactsPrefix="$artifactsPrefix" \
	--parameters artifactsSuffix="$artifactsSuffix" \
	--parameters nbVMs=1 \
	--parameters typeOfVM="mainDSVM"

source $DIR/endOfScripts.sh

echo "if deployment was successful, you should be able to ssh to ${adminUsername}@${dsvmUrl}"
