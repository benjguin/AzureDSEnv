# This file is meant to be sourced as it only init variable values
# usage: source initvars.sh

subscription="Azure bengui"
rg="a_180927a"
suffix="eg123" # the suffix should make names that use it unique yet simple. This sample means "e.g. 123".
location="westeurope"
vNetIpRange="10.9.0.0/16"
defaultSubnetIpRange="10.9.1.0/24"
dsvmSubnetIpRange="10.9.2.0/24"
maindsvmname="ds$suffix"

maindsurl="$maindsvmname.$location.cloudapp.azure.com"

