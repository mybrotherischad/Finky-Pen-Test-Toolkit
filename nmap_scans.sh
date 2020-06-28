#!/bin/bash
echo "Enter the IP and/or range for initial scan: "
read ips
echo "-----------------------"
echo "Working.........."
TOPDIR=$(date +%Y%m%d%H%M%S)
FIRSTDIR='nmap-initial'
mkdir "$TOPDIR"
mkdir "$TOPDIR/$FIRSTDIR"
nmap $ips -oA "$TOPDIR/$FIRSTDIR/nmap-initial" | grep "Nmap scan report for" | cut -d " " -f5 > $TOPDIR/ip_list.txt
cat $TOPDIR/ip_list.txt
#read -p "Proceed to second level scan? " -n 1 -r
#echo
#if [[ $REPLY =~ ^[Yy]$ ]]
#then
	echo "Working on second level scan.........."
	SECDIR='nmap-scsvo'
	mkdir -p "$TOPDIR/$SECDIR"
	sudo nmap -iL $TOPDIR/ip_list.txt -sC -sV -O -oA "$TOPDIR/$SECDIR/nmap-scsvo"
	#read -p "Proceed to final TCP scan?? " -n 1 -r
	#echo    
	#if [[ $REPLY =~ ^[Yy]$ ]]
	#then
		FULLDIR='nmap-fulltcp'
		mkdir -p "$TOPDIR/$FULLDIR"
		echo "Working on final level scans.........."
		sudo nmap -iL $TOPDIR/ip_list.txt -sC -sV -O -p- -oA "$TOPDIR/$FULLDIR/nmap-fulltcp"
	#fi
	
#fi
