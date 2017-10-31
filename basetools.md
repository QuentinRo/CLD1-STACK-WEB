# Installing some basic tooling
To increase our efficiency, we install some tools on our base debian install.

## SUDO
Sudo alows to momentarily gets the privileges of the superuser.
He add a `sudo` command on the system. Then wen we want to launch a command with superuser privileges, we simply use `sudo` before the command, after that the prompt will ask your password.

### Installing sudo
1. Connect you to the root acount with `su`
2. Run `apt-get install sudo` (this will install de sudo package)
3. Type `visudo` To configure de sudoers (this command will open the /etc/suders file with nano editor)
4. We add a new line in this file to give to our account the sudo privileges. Simply replace 'username' by your username.
```bash
# User privilege specifications
username ALL=(ALL) ALL
```
If you want to give the root privileges to an other administrator of your system, simply add it on the sudoers file.

## SSH server
SSH is a protocol that allows to remote connexion to the terminal of your server with a simple SSH client. After installing ssh we simply use a ssh client on your PC to connect you on the ip of your server.

### Installing SSH server
**In our case we installed the ssh server on our machine during debian installation.** But if dont have install ssh-server on our machine, simply run:
```bash
sudo apt-get install openssh-server
```

### Installing an SSH client
Tu use a ssh connexion you need a client on **our local machine.**
- Linux
    - `sudo apt-get install openssh`
- MacOS
    - the ssh command is available by default on the system
- Microsoft windows, serveal tools exist :
    - [cmder](http://cmder.net/)
    - [Putty](http://www.putty.org/)
    - Many others

### Connecting with SSH
Connecting tou your server with ssh, simply use the ssh client you have just installed or type the ssh command with your username and the ip of our server.
```bash
ssh username@192.168.1.1
```

> If you dont know the ip of our server, simply run the `ip addr` command

## VIM
Vim is a pwerful comand line editor. We are going to use it to modify config files.
```bash
sudo apt-get install vim
```

## GIT
Without git our server in a non sense.
```bash
sudo apt-get install git
```

<div align="center">
<hr>

**Installation steps**

[< Previous](debian.md) / [Next >](php.md)

</div>