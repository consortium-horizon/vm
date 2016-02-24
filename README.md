# Consortium Apps Vagrant Based Testing Environement

## Introduction

This project automates the setup of a LEMP development environment and checkout latest version github/consortium/apps 

## Requirements

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant](http://vagrantup.com)

* [Cygwin](https://www.cygwin.com/) or any other ssh-capable terminal shell for the `vagrant ssh` command

## How To Build The Virtual Machine

Building the virtual machine is this easy:

    host $ git clone https://github.com/consortium-horizon/vm.git
    host $ cd vm
    host $ vagrant up --provision

If the base box is not present that command fetches it first.

    host $ vagrant ssh
    Welcome to Ubuntu 14.04 LTS ...
    ...
    vagrant@vagrant:~$

Ports 8080 and 3306 on guest and forwarded to 8080 and 3306 respectively.

Go to localhost:8080/forum to install vanilla

Database is vanilla
User is root
Password is vanilla

## What's In The Box

* Ubuntu 14.04 x64
* MySQL
* Nginx
* php5-fpm

## Recommended Workflow

The recommended workflow is

* edit files in the host computer

* run within the virtual machine

Your home/www folder is synced to `/var/www` on the guest.

## Database
* For mysql the default user is root: `mysql -u root -p vanilla`

## Virtual Machine Management

When done just log out with and suspend the virtual machine

    host $ vagrant suspend

then, resume to hack again

    host $ vagrant resume

Run

    host $ vagrant halt

to shutdown the virtual machine, and

    host $ vagrant up

to boot it again.

You can find out the state of a virtual machine anytime by invoking

    host $ vagrant status

Finally, to completely wipe the virtual machine from the disk **destroying all its contents**:

    host $ vagrant destroy # DANGER: all is gone

Please check the [Vagrant documentation](http://docs.vagrantup.com/v2/) for more information on Vagrant.
