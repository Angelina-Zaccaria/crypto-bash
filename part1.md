# Part 1: Setting Up Ubuntu
Students set up the virtual machine (VM) they will use throughout the rest of the workshop. There is an Ubuntu VM with the relevant packages and workshop files already installed or students can download the files on a fresh or existing VM if they would prefer.

There are 3 options:
1. Use an existing VM - fastest if you already have an Ubuntu/Kali VM that you like, 30 second setup
2. Use the preconfigured course VM - fastest for beginners, 4 min download + 2 min setup
3. Create a fresh VM - most educational for beginners, 15 min download + 25 min setup

## Option 1: Use an Existing VM

Confirm that you already have OpenSSL installed on your Ubuntu/Kali VM by running `openssl version`. This course uses version 3.0.x, so if you have version 1.1.1x and run into any issues you may just need to use slightly different syntax. You should already have git and a text editor installed.

Run the following command to clone this repository to get the workshop files:
```
git clone https://github.com/Angelina-Zaccaria/crypto-bash
```

## Option 2: Use the Preconfigured Course VM

Download the VirtualBox platform package appropriate for your host machine [here](https://www.virtualbox.org/wiki/Downloads). You can also use VMware if you prefer, though these instructions are based on VirtualBox.

Download the [preconfigured OVA file](https://drive.google.com/file/d/1RspmNPYvht3T8ORKd8MSw2_sENx5bBYq/view?usp=sharing) of Ubuntu 22.04.1 LTS with the workshop files in this GitHub repository already on the VM.

Install VirtualBox as directed by your system (all default settings are fine).

Import the course VM by going to `File > Import Appliance`. Select the OVA file location and import using the default settings. Select the VM, click `Settings`, and under `System > Motherboard` change the `Base Memory` to the highest value that is still green (signifying what is a reasonable amount based on the memory capacity of your host machine). Click `OK` to save your changes and click the green start arrow to start the VM. Once you finish the installation you no longer need to keep the OVA file.

If you receive an error message saying that you need to enable virtualization on your computer, Google the instructions for accessing the BIOS for your machine, enable the appropriate virtualization settings, and restart your machine.

Once you start the VM, sign into the `student` account using the password `password`.

Launch the Terminal application from the sidebar and execute the following commands to enter the workshop materials directory to be used throughout the rest of the workshop, view the files, and update to the most recent version:

```
cd crypto-bash
ls
git pull --rebase origin main
```

## Option 3: Create a Fresh VM

Download the VirtualBox platform package appropriate for your host machine [here](https://www.virtualbox.org/wiki/Downloads). You can also use VMware if you prefer, though these instructions are based on VirtualBox.

Download the most recent version of Ubuntu [here](https://ubuntu.com/download/desktop). Please note that this workshop was developed using Ubuntu 22.04.1 LTS

Install VirtualBox as directed by your system (all default settings are fine). 

To create your new VM, go to `New`, call it `Crypto Bash VM`, and set `Type` as `Linux` and `Version` as `Ubuntu (64-bit)`. Keep clicking continue through  the default settings except change `Memory` from `1024 MB` to the highest value that is still green (signifying what is a reasonable amount based on the memory capacity of your host machine) and change virtual hard disk size from 10 GB to 12 GB.

Click `Start`. When it asks you to select a start-up disk, click the file symbol with the green arrow, click `Add`, then open the Ubuntu ISO file you downloaded, hit `Choose`, and then `Start`

Hit enter for `Try or Install Ubuntu`

`View > Scaled mode` and adjust the window size until you can sufficiently interact with the VM. You can always change this later.

Once it boots, click `Install Ubuntu`, default language settings

Use minimal installation, check download updates, and don’t check install third-party software 

`Erase disk and install Ubuntu` (this does not erase anything on your host machine, only the contents of your empty newly created VM)

`Install Now`, `Continue` to write changes to disk, go through the setup pages

Click `Restart Now` when prompted, and just click `Enter` when prompted (the installation media is automatically ejected and you no longer need to keep the ISO file)

Sign into the account you created, click through the setup settings, install updates and restart when prompted

Launch the Terminal by going to the grid on the bottom left for Show Applications, select Terminal, and right click to `Add to Favorites`. Run the following commands:
```
sudo apt-get update
sudo apt dist-upgrade
sudo apt install git vim
git clone https://github.com/Angelina-Zaccaria/crypto-bash
cd crypto-bash
ls
```

To modify window size, click on the top right menu within Ubuntu, click `Settings > Displays > Resolution`. Select a resolution within Ubuntu that works best for your screen, typically 1280 x 720 (16:9) for full screen or 1024 x 768 (4:3) to multitask with the host operating system. Adjust the size of the VM window to match the ratio you choose. **The recommended VM configuration for this workshop is 1280 x 720 and then opening this GitHub repository in Firefox side by side with the Terminal inside the VM.**

## → [Part 2: Symmetric Cryptography](part2.md)
