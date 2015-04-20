Vagrantfiles
=============
These are a collection of Vagrantfiles to do local (pre-commit) testing using Virtualbox + Vagrant + other things.
These Vagrantfiles use the Vagrant 2.0 formats.



Vagrantfile-Chef-Solo
======================
This is used to do Chef-Solo testing with Vagrant.


Vagrantfile-Chef-Zero
======================
This is used to do Chef-Zero testing with Vagrant.


Vagrant + Docker
=================
2 approaches:

1) dockerfile-centric
	- Dockerfiles + Vagrant to launch them
	
2) pure-vagrant
	- Vagrantfiles for defining and launching docker containers
	
3) dockerhost only
	- Vagrantfile for making a dockerhost only with NFS shared folder
	- great for running docker commands natively without using Vagrant provider

Vagrantfile & Vagrantfile.host
-------------------------------
This is used to do Docker testing with Vagrant using 2 Vagrantfiles.
The Vagrantfile.proxy sets up the vagrant vm host upon which containers run.
The Vagrantfile sets up the containers.




