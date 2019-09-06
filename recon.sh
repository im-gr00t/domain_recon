#!/bin/bash

# TODO: implement `getopt'
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
        # Display target being enumerated
        echo -e "\e[31m[+]\e[0m \e[36mTarget:\e[0m \e[93m${DOMAIN}\e[0m"

        # Create the directory to store output
        mkdir -p ~/Documents/${DOMAIN}/RECON/DNS/

        # Run subfinder
        echo -e "\e[31m[+]\e[0m \e[36mStarting subfinder: \e[0m\e[93mforeground\e[0m"
        subfinder -d ${DOMAIN} -o ~/Documents/${DOMAIN}/RECON/DNS/subfinder_output.txt

        # Run sublister
        echo -e "\e[31m[+]\e[0m \e[36mStarting sublist3r: \e[0m\e[93foreground\e[0m"
        sublist3r -d ${DOMAIN} -o ~/Documents/${DOMAIN}/RECON/DNS/sublist3r_output.txt

        # Run assetfinder
        echo -e "\e[31m[+]\e[0m \e[36mStarting assetfinder: \e[0m\e[93mforeground\e[0m"
        assetfinder -subs-only ${DOMAIN} | tee -a ~/Documents/${DOMAIN}/RECON/DNS/assetfinder_output.txt

        # Run amass
        echo -e "\e[31m[+]\e[0m \e[36mStarting amass: \e[0m\e[93mforeground\e[0m"
        amass enum -o ~/Documents/${DOMAIN}/RECON/DNS/amass_output.txt -d ${DOMAIN}
else
        echo "Usage: $0 --help"
fi
