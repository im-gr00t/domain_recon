#!/bin/bash

# Check if user is supplying an argument 
if [ -z "$1" ]
then
	echo "Usage: $0 --help";
	exit 2;

# Check for valid help flag
elif [ "$1" == "-h" -o "$1" == "--help" ]
then
	echo "Usage: $0 [options] <directory>";
	echo "Options:";
	echo -e "\t-h, --help\tDisplay this help message";
	echo -e "\t-d, --directory\tSpecifies desired directory to save all tools in (will be created if it doesn't exist)";
	echo -e "Example:";
	echo -e "\t$0 --directory /opt";
	exit 2;
fi

DIR=$2
# Check for valid directory
if [ "$1" == "-d" -o "$1" == "--directory" -a -d ${DIR} ]
then
	echo "[+] Using directory to save all tools in: ${DIR}";
	# Create the directory
	mkdir ${DIR};

	# cd into the directory
	cd ${DIR};

	# Update system, download required dependencies and packages
	echo "[+] Updating system"
	sudo apt update && sudo apt install golang git python3.7;

	# Get subfinder
	# Credit: https://github.com/subfinder
	# Repo: https://github.com/subfinder/subfinder
	echo "[+] Downloading subfinder";
	go get github.com/subfinder/subfinder;
	sudo mv -f ~/go ~/subfinder;
	sudo mv -f ~/subfinder .;

	# Create soft link
	sudo ln -sf $(pwd)/subfinder/bin/subfinder /usr/bin/subfinder;

	# Get sublist3r
	# Credit to Auther: aboul3la and TheRook
	# Repo: https://github.com/aboul3la/Sublist3r
	echo "[+] Downloading sublist3r";
	git clone https://github.com/aboul3la/Sublist3r.git;
	cd Sublist3r/;
	pip install -r requirements.txt;
	cd ../;

	# Create soft link
	sudo ln -sf $(pwd)/Sublist3r/sublist3r.py /usr/bin/sublist3r;

	# Get assetfinder
	# Credit to Author: tomnomnom
	# Repo: https://github.com/tomnomnom/assetfinder
	echo "[+] Downloading assetfinder";
	go get -u github.com/tomnomnom/assetfinder;
	sudo mv -f ~/go ~/assetfinder;
	sudo mv -f ~/assetfinder .;

	# Create soft link
	sudo ln -sf $(pwd)/assetfinder/bin/assetfinder /usr/bin/assetfinder;

	# Finished
	echo "[+] Done...";
	exit 0;
else
	echo "Usage: $0 --help";
	exit 2;
fi
