# Debian installation guide

A quick installation guide of debian for the stack web.

## Installation !

### Get the .iso

We use the last version of debian: "stretch".
You can get the .iso file on this url: [debian 9.1.0](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-9.1.0-amd64-netinst.iso)

### Environnemnt infos
In this exercice i use a virtual machine, but the procedure is the same on pysical machine.

> **Installation on pysical machine**
> You can use "Rufus" or other similar tools to copy the .iso on bootable usb device.


> **If you use VM**
> Create a simple VM on your favorite virtualization tool.
> A configuration with 1gb of ram, 1 cpu and 30gb HDD is a goo starting point.

### Starting the machine
Ok we are ready to start the installation of debian 9.

1. Connect the .iso installation file to our WM. (or your botable key if your on pysical machine)
2. Start the machine.
3. Select the Install menu.

> Note, this is self-evident, but you must be connected to internet to follow the instalation guide.

### Configuring the OS
1. Language: english
2. Location: select our location
3. Locales: en_US.UTF-8
4. Keyboard: configure your keyboard
5. Hostname: give a name to your machine, *This name will be visible on the network*
6. Domain: type your domain name
7. Set root password: this password will be known only from the system administrator, *8 caracters min is a good base*
8. Confirm the root password
9. User acount name: Set up your complete name
10. User name: Set up your acount username
11. Password: Set up your password
12. Confirm password

### Configuring disks
13. Partition type: We use *Guided - use entire disk*.
14. Select our disk
15. Partition scheme: All files in one partition
16. Partition recap: Ok -> finish partitioning
17. Write changes to disk: **YES**
18. Scan aditional CD or DVD: **NO**

### Configuring mirror
19. Mirror country: select your country
20. Mirrors list: Select a mirror in the list

### Proxy
21. Leave blank

### Configuring system
22. Send statistics: **NO**
23. Softwares to install:
    - SSH server
    - standard system utilities
24. GRUP boot loader: **YES**
25. Devide for boot loader: Your base disk
26. **REBOOT on your fresh install of debian**
> You can disconect the .iso installation file.

## Your new debian install
Now we have a complete install of debian. You can log you in with your usrername and password. **Never connect with root by default**

### Finalizing the install
Just a few things to finalize to get all the packages up to date.
1. Login with your acount
2. Use `su` to connect you with the root user
3. type the root password
4. run `apt-get update` This will just update the list of packages sources of the system.