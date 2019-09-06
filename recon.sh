#!/bin/bash

# TODO: implement `getopt'
# Check if user is supplying an argument
if [ -z "$1" ]
then
        echo -e "\e[91mUsage: $0 --help\e[0m";
        exit 2;

# Check for valid help flag
elif [ "$1" == "-h" -o "$1" == "--help" ]
then
        echo -e "\e[91mUsage: $0 [options] <directory>\e[0m";
        echo "Options:";
        echo -e "\t-h, --help\tDisplay this help message";
        echo -e "\t-d, --domain\tSpecifies desired directory to save all tools in (will be created if it doesn't exist)";
        echo -e "Example:";
        echo -e "\t$0 --domain example.com";
        exit 2;
fi

# Check for valid command line option
if [ "$1" == "-d" -o "$1" == "--domain" -a "$2" != "" ]
then
        # Check if "--domain" has valid argument
        if [ -z "$2" ]
        then
                echo -e "\e[91mUsage: $0 --help\e[0m"
                exit 2;
        fi
        
        DOMAIN=$2
        DIR=~/Targets/${DOMAIN}/Subdomain_recon
        
        # Display target being enumerated
        echo -e "\e[91m[+]\e[0m \e[36mTarget:\e[0m \e[93m${DOMAIN}\e[0m"
        sleep 3

        # Create the directory to store output
        mkdir -p ${DIR}

        # Run subfinder
        echo -e "\e[91m[+]\e[0m \e[36mStarting subfinder: \e[0m\e[93mforeground\e[0m"
        subfinder -d ${DOMAIN} -o ${DIR}/subfinder_output.txt
        sleep 3

        # Run sublister
        echo -e "\e[91m[+]\e[0m \e[36mStarting sublist3r: \e[0m\e[93foreground\e[0m"
        sublist3r -d ${DOMAIN} -o ${DIR}/sublist3r_output.txt
        sleep 3
        
        # Run assetfinder
        echo -e "\e[91m[+]\e[0m \e[36mStarting assetfinder: \e[0m\e[93mforeground\e[0m"
        assetfinder -subs-only ${DOMAIN} | tee -a ${DIR}/assetfinder_output.txt
        sleep 3

        # Run amass
        echo -e "\e[31m[+]\e[0m \e[36mStarting amass: \e[0m\e[93mforeground\e[0m"
        amass enum -o ${DIR}/amass_output.txt -d ${DOMAIN}
        sleep 3
        
        # Cat and sort -u all domains into a single file called "all_domains_sorted.txt"
        cd $DIR;
        cat *.txt >> all_domains.txt;
        sort -u all_domains.txt >> all_domains_sorted.txt;
        rm all_domains.txt;
        echo -e "\e[91m[+]\e[0m \e[36mDone\e[0m\e[93m...\e[0m"
else
        echo -e "\e[91mUsage: $0 --help\e[0m"
        exit 2
fi
