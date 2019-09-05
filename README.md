## Domain Recon
A simple bash script I wrote to download tools that enumerate Subdomains on a given site and execute them on the given site.

## The tools currently being used are:
- [subfinder](https://github.com/subfinder/subfinder)
- [sublist3r](https://github.com/aboul3la/Sublist3r)
- [assetfinder](https://github.com/tomnomnom/assetfinder)

### Installation
This downloads all tools into the directory `/opt`:  
`$ ./setup.sh --directory /opt`

### Usage
Runs all recon tools on the domain `example.com`:  
`$ ./recon.sh --domain example.com`

## Contact
`Follow and DM me on Twitter @_im_gr00t if you'd like me to add more tools :)`
