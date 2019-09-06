#!/bin/bash

# TODO: implement and `getopt'
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
	echo -e "\t-d, --domain\tSpecifies desired directory to save all tools in (will be created if it doesn't exist)";
	echo -e "Example:";
	echo -e "\t$0 --domain example.com";
	exit 2;
fi

DOMAIN=$2
# Check for valid command line option
if [ "$1" == "-d" -o "$1" == "--domain" ]
then
	# Create the directory to store output
	mkdir -p ~/Documents/$2/RECON/DNS/

	# Run amass
	echo "[+] Starting amass"
	amass enum -o ~/Documents/${DOMAIN}/RECON/DNS/amass_output.txt
	echo "[+] amass is done..."

	# Run subfinder as background process
	echo "[+] Starting subfinder"
	subfinder -d ${DOMAIN} -o ~/Documents/${DOMAIN}/RECON/DNS/subfinder_output.txt
	echo "[+] subfinder is done..."

	# Run sublister as background process
	echo "[+] Starting sublist3r"
	sublist3r -d ${DOMAIN} -o ~/Documents/${DOMAIN}/RECON/DNS/sublist3r_output.txt
	echo "[+] sublist3r is done..."

	# Run assetfinder as background process
	echo "[+] Starting assetfinder"
	assetfinder -subs-only ${DOMAIN} | tee -a ~/Documents/${DOMAIN}/RECON/DNS/assetfinder_output.txt
	echo "[+] assetfinder is done..."

	# Run findomain as background process
	echo "[+] Starting findomain"
	findomain -a -t ${DOMAIN} -o txt
	mv ${DOMAIN}*.txt findomain_output.txt
	mv findomain_output.txt ~/Documents/${DOMAIN}/RECON/DNS/findomain_output.txt
	echo "[+] findomain is done..."
else
	echo "Usage: $0 --help"
fi
