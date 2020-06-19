ho "Enter the IP and/or range for initial scan: "
read ips
echo "-----------------------"
echo "Working.........."
FIRSTDIR='nmap-initial'
mkdir "$FIRSTDIR"
nmap $ips -oA "$FIRSTDIR/nmap-initial" | grep "Nmap scan report for" | cut -d " " -f5 > ip_list.txt
cat ip_list.txt
read -p "Proceed to second level scan? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "Working.........."
	SECDIR='nmap-scsvo'
	mkdir -p "$SECDIR"
	sudo nmap -iL ip_list.txt -sC -sV -O -oA "$SECDIR/nmap-scsvo"
	read -p "Proceed to final TCP scan?? " -n 1 -r
	echo    
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		FULLDIR='nmap-fulltcp'
		mkdir -p "$FULLDIR"
		echo "Working.........."
		sudo nmap -iL ip_list.txt -sC -sV -O -p- -oA "$FULLDIR/nmap-fulltcp"
	fi
	
fi
