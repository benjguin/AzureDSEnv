# AzureDSEnv

Some code for a data science workshop environment setup in Azure

Here is an example on how to use it. 

1/ update file `initvars.sh`

2/ deploy a first DSVM

```bash
./setup1.sh
```

3/ deploy 2 additional VMs

```bash
./setup2.sh 2 "grpone"
```


4/ deploy 1 additional VMs

```bash
./setup2.sh 1 "grptwo"
```
