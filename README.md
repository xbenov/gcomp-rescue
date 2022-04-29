# gcomp-rescue
Cyber-security game with database system designed and implemented using Cyber Sandbox Creator
 and prepared using Ansible playbooks.
 
## Introduction
This is an exercise format cyber-security game with an attacker and defender scenario. The game creates a virtual system of a web and database servers with an attacker and management machines, from which you will be performing various security related tasks. 

## Instructions

### Linux/macOS

1.  Enable [virtualization in BIOS](https://www.tactig.com/enable-intel-vt-x-amd-virtualization-pc-vmware-virtualbox/).
2.  Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
    -   VirtualBox on Linux is sensitive to kernel versions. First, update the system (including the kernel), and only then install the latest Virtualbox. **IMPORTANT**: Don’t install the distro-repository version of VirtualBox. Really do install the latest version from [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)
    -   VirtualBox requires x86 CPU architecture, so it will **not** work on ARM Mac.
3.  Install [Vagrant](https://www.vagrantup.com/downloads.html). The official website should be preferred as a source. Repositories of Linux distributions could have outdated versions.
4.  Install `pip` using the command `$ sudo apt-get install python3-pip`.
5.  Install `setuptools` with `$ pip3 install setuptools`.
6.  Install KYPO topology definition `$ pip3 install kypo-topology-definition~=0.5.0 --extra-index-url https://gitlab.ics.muni.cz/api/v4/projects/2358/packages/pypi/simple`.
7.  Install CSC with `$ pip3 install sandboxcreator`.

Note: Instead of installing steps 4--7, you can (in most cases) use Vagrant commands directly to build virtual environments.

### [](#windows-10)Windows 10

1.  Enable [virtualization in BIOS](https://www.tactig.com/enable-intel-vt-x-amd-virtualization-pc-vmware-virtualbox/).
2.  Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
3.  Install [Vagrant](https://www.vagrantup.com/downloads.html).
4.  Ensure Hyper-V is disabled (Programs and Features > Turn Windows features on or off > Hyper-V)
    -   Sometimes it is not enough to disable Hyper-V in Settings; you may need to use the command `bcdedit /set hypervisorlaunchtype off` and restart the computer.
    -   Windows Update can turn Hyper-V on again, be sure to check it again after installing updates.
5.  Install [Python 3 with PIP](https://www.python.org/downloads/windows/).
6.  Install KYPO topology definition `$ pip3 install kypo-topology-definition~=0.5.0 --extra-index-url https://gitlab.ics.muni.cz/api/v4/projects/2358/packages/pypi/simple`.
7.  Install CSC with `$ pip3 install sandboxcreator`.

Note: Instead of installing steps 4--7, you can (in most cases) use Vagrant commands directly to build virtual environments.
### Required software versions for all operating systems

-   Python >= 3.7
-   VirtualBox >= 6.1
-   Vagrant >= 2.2.5
-   Ansible >= 2.5 (required only if using the option `--ansible-installed`)

## Build the sandbox
Simply navigate to the directory of this exercise and execute this command `manage-sandbox build -v`.
The build speed depends on your internet download speed as you need to get the OS boxes from Vagrant and download many packages that are installed on the servers. The OS boxes have 7.5 GB and the packages should be less than 1 GB.

## Play
Now, decide which scenario you want to try and open either `DEFEND-Database-server-game` or `ATTACK-Database-server-game` file. Read through the instructions and start completing the tasks.
