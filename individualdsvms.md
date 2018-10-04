# Create Data Science VM instances

## Designing the solution

**public endpoints**

Possibilities include
- 1/ jumpbox
- 2/ one public IP and a load balancer
- 3/ one public IP per VM

Each VM will typically expose its Jupyter hub endpoint on port 8080 and its ssh endpoint on port 22. Depending on what is used and installed on the VMs, additional ports may be necessary.

So option 2/ seems complex.

Jumpbox also adds some complexity (do we need to add 1 user in the jumpbox per individual VM, should everyone access all VMs from the jumpbox, ...).

Let's choose option 3/.

**possible to add more VMs are attendees ask for them**

The setup should probably consist of 
- An initial setup for the first common data science VM
- An additional setup that can be run several times for additional VMs

## Setups

Initial setup creates the following resources
- VNET
    - default subnet
    - subnet for the individual Data Science VMs (idsvm)
- Common Data Science VM

Additional setup may be run several times. Each run adds:
- x number of individual data science VMs in the idsvm subnet

## How to execute setups

for setup1:

```bash
./setup1.sh
```

for setup2, provide the nb of VMs you want to add (e.g. 4)

```bash
./setup2.sh 4
```

## Resources

- [Data Science and AI Workshops](https://github.com/Azure/DataScienceVM/tree/master/Tutorials/workshop-setup)
- [How to Run Large-Scale Educational Workshops in Deep Learning & Data Science](https://blogs.technet.microsoft.com/machinelearning/2018/01/10/running-large-scale-educational-workshops-in-deep-learning-data-science/)
- [Using Microsoft Azure Data Science Virtual Machines in your teaching and Research Labs](https://blogs.msdn.microsoft.com/uk_faculty_connection/2018/01/11/using-microsoft-azure-data-science-virtual-machines-in-your-teaching-and-research-labs/)

- [a sample ARM template that creates a nb of data science VMs](https://github.com/Azure/DataScienceVM/blob/master/Scripts/CreateDSVM/Ubuntu/multiazuredeploywithext.json)

## Appendix

### Data Science VM images

Here is how you can get a list of the data science VM images. This sample was run on 2018-09-28.

```
$ az vm image list --all --offer "data-science-vm"
Offer                         Publisher       Sku                        Urn                                                                          Version
----------------------------  --------------  -------------------------  ---------------------------------------------------------------------------  ----------
linux-data-science-vm         microsoft-ads   linuxdsvm                  microsoft-ads:linux-data-science-vm:linuxdsvm:1.4.8                          1.4.8
linux-data-science-vm         microsoft-ads   linuxdsvm                  microsoft-ads:linux-data-science-vm:linuxdsvm:1.4.9                          1.4.9
linux-data-science-vm         microsoft-ads   linuxdsvm                  microsoft-ads:linux-data-science-vm:linuxdsvm:1.5.0                          1.5.0
linux-data-science-vm         microsoft-ads   linuxdsvm                  microsoft-ads:linux-data-science-vm:linuxdsvm:1.6.2                          1.6.2
linux-data-science-vm         microsoft-ads   linuxdsvm                  microsoft-ads:linux-data-science-vm:linuxdsvm:1.7.3                          1.7.3
linux-data-science-vm-ubuntu  microsoft-dsvm  linuxdsvmubuntu            microsoft-dsvm:linux-data-science-vm-ubuntu:linuxdsvmubuntu:18.07.02         18.07.02
linux-data-science-vm-ubuntu  microsoft-dsvm  linuxdsvmubuntu            microsoft-dsvm:linux-data-science-vm-ubuntu:linuxdsvmubuntu:18.08.00         18.08.00
linux-data-science-vm-ubuntu  microsoft-dsvm  linuxdsvmubuntu            microsoft-dsvm:linux-data-science-vm-ubuntu:linuxdsvmubuntu:18.09.00         18.09.00
linux-data-science-vm         microsoft-ads   linuxdsvmbyol              microsoft-ads:linux-data-science-vm:linuxdsvmbyol:1.6.2                      1.6.2
linux-data-science-vm         microsoft-ads   linuxdsvmbyol              microsoft-ads:linux-data-science-vm:linuxdsvmbyol:1.7.3                      1.7.3
linux-data-science-vm-ubuntu  microsoft-ads   linuxdsvmubuntu            microsoft-ads:linux-data-science-vm-ubuntu:linuxdsvmubuntu:1.1.6             1.1.6
linux-data-science-vm-ubuntu  microsoft-ads   linuxdsvmubuntu            microsoft-ads:linux-data-science-vm-ubuntu:linuxdsvmubuntu:1.1.7             1.1.7
linux-data-science-vm-ubuntu  microsoft-ads   linuxdsvmubuntu            microsoft-ads:linux-data-science-vm-ubuntu:linuxdsvmubuntu:18.03.03          18.03.03
linux-data-science-vm-ubuntu  microsoft-ads   linuxdsvmubuntu            microsoft-ads:linux-data-science-vm-ubuntu:linuxdsvmubuntu:18.05.00          18.05.00
linux-data-science-vm-ubuntu  microsoft-ads   linuxdsvmubuntu            microsoft-ads:linux-data-science-vm-ubuntu:linuxdsvmubuntu:18.07.01          18.07.01
linux-data-science-vm-ubuntu  microsoft-ads   linuxdsvmubuntu            microsoft-ads:linux-data-science-vm-ubuntu:linuxdsvmubuntu:18.08.00          18.08.00
linux-data-science-vm-ubuntu  microsoft-ads   linuxdsvmubuntu            microsoft-ads:linux-data-science-vm-ubuntu:linuxdsvmubuntu:18.09.00          18.09.00
linux-data-science-vm-ubuntu  microsoft-ads   linuxdsvmubuntubyol        microsoft-ads:linux-data-science-vm-ubuntu:linuxdsvmubuntubyol:1.1.1         1.1.1
linux-data-science-vm-ubuntu  microsoft-ads   linuxdsvmubuntubyol        microsoft-ads:linux-data-science-vm-ubuntu:linuxdsvmubuntubyol:1.1.2         1.1.2
linux-data-science-vm-ubuntu  microsoft-ads   linuxdsvmubuntubyol        microsoft-ads:linux-data-science-vm-ubuntu:linuxdsvmubuntubyol:1.1.6         1.1.6
linux-data-science-vm-ubuntu  microsoft-ads   linuxdsvmubuntubyol        microsoft-ads:linux-data-science-vm-ubuntu:linuxdsvmubuntubyol:1.1.7         1.1.7
linux-data-science-vm-ubuntu  microsoft-ads   linuxdsvmubuntubyol        microsoft-ads:linux-data-science-vm-ubuntu:linuxdsvmubuntubyol:18.03.03      18.03.03
linux-data-science-vm-ubuntu  microsoft-ads   linuxdsvmubuntubyol        microsoft-ads:linux-data-science-vm-ubuntu:linuxdsvmubuntubyol:18.05.00      18.05.00
linux-data-science-vm-ubuntu  microsoft-ads   linuxdsvmubuntubyol        microsoft-ads:linux-data-science-vm-ubuntu:linuxdsvmubuntubyol:18.07.01      18.07.01
linux-data-science-vm-ubuntu  microsoft-ads   linuxdsvmubuntubyol        microsoft-ads:linux-data-science-vm-ubuntu:linuxdsvmubuntubyol:18.08.00      18.08.00
standard-data-science-vm      microsoft-ads   standard-data-science-vm   microsoft-ads:standard-data-science-vm:standard-data-science-vm:1.10.0       1.10.0
standard-data-science-vm      microsoft-ads   standard-data-science-vm   microsoft-ads:standard-data-science-vm:standard-data-science-vm:1.11.0       1.11.0
standard-data-science-vm      microsoft-ads   standard-data-science-vm   microsoft-ads:standard-data-science-vm:standard-data-science-vm:1.12.0       1.12.0
standard-data-science-vm      microsoft-ads   standard-data-science-vm   microsoft-ads:standard-data-science-vm:standard-data-science-vm:2018.07.00   2018.07.00
standard-data-science-vm      microsoft-ads   win12-data-science-vm-csp  microsoft-ads:standard-data-science-vm:win12-data-science-vm-csp:1.10.0      1.10.0
standard-data-science-vm      microsoft-ads   win12-data-science-vm-csp  microsoft-ads:standard-data-science-vm:win12-data-science-vm-csp:1.11.0      1.11.0
standard-data-science-vm      microsoft-ads   win12-data-science-vm-csp  microsoft-ads:standard-data-science-vm:win12-data-science-vm-csp:1.12.0      1.12.0
standard-data-science-vm      microsoft-ads   win12-data-science-vm-csp  microsoft-ads:standard-data-science-vm:win12-data-science-vm-csp:2018.07.00  2018.07.00
windows-data-science-vm       microsoft-ads   windows2016                microsoft-ads:windows-data-science-vm:windows2016:0.0.10                     0.0.10
windows-data-science-vm       microsoft-ads   windows2016                microsoft-ads:windows-data-science-vm:windows2016:0.0.11                     0.0.11
windows-data-science-vm       microsoft-ads   windows2016                microsoft-ads:windows-data-science-vm:windows2016:0.1.12                     0.1.12
windows-data-science-vm       microsoft-ads   windows2016                microsoft-ads:windows-data-science-vm:windows2016:0.2.01                     0.2.01
windows-data-science-vm       microsoft-ads   windows2016                microsoft-ads:windows-data-science-vm:windows2016:0.2.02                     0.2.02
windows-data-science-vm       microsoft-ads   windows2016                microsoft-ads:windows-data-science-vm:windows2016:18.02.00                   18.02.00
windows-data-science-vm       microsoft-ads   windows2016                microsoft-ads:windows-data-science-vm:windows2016:18.06.03                   18.06.03
windows-data-science-vm       microsoft-ads   windows2016                microsoft-ads:windows-data-science-vm:windows2016:18.06.05                   18.06.05
windows-data-science-vm       microsoft-ads   windows2016byol            microsoft-ads:windows-data-science-vm:windows2016byol:0.1.12                 0.1.12
windows-data-science-vm       microsoft-ads   windows2016byol            microsoft-ads:windows-data-science-vm:windows2016byol:0.2.01                 0.2.01
windows-data-science-vm       microsoft-ads   windows2016byol            microsoft-ads:windows-data-science-vm:windows2016byol:0.2.02                 0.2.02
windows-data-science-vm       microsoft-ads   windows2016byol            microsoft-ads:windows-data-science-vm:windows2016byol:18.02.00               18.02.00
windows-data-science-vm       microsoft-ads   windows2016byol            microsoft-ads:windows-data-science-vm:windows2016byol:18.06.03               18.06.03
windows-data-science-vm       microsoft-ads   windows2016byol            microsoft-ads:windows-data-science-vm:windows2016byol:18.06.05               18.06.05
```
