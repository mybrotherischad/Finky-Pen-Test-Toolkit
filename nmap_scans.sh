#!/bin/bash
# Don't forget to chmod +x the file
echo "Enter the IP and/or range for initial scan: "
read ips
echo "-----------------------"
echo "Working.........."
nmap $ips -oA nmap-initial | grep "Nmap scan report for" | cut -d " " -f5 > ip_list.txt
cat ip_list.txt
read -p "Proceed to second level scan? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
        echo "Working.........."
        sudo nmap -iL ip_list.txt -sC -sV -O -oA nmap-scsvo
        read -p "Proceed to final TCP scan?? " -n 1 -r
        echo    
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
                echo "Working.........."
                sudo nmap -iL ip_list.txt -sC -sV -O -p- -oA nmap-fulltcp
        fi

fi
