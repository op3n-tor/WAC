#!/usr/bin/env bash

#===========================================================================#
#                          WIFI Connector Automatic			    #
#									    #
#                        Script write by BlackCat        		    #
#	                 Contact me blackcat@gmail.com                      #
#===========================================================================#

# Color
cyan='\e[0;36m'
green='\e[0;34m'
okegreen='\033[92m'
lightgreen='\e[1;32m'
white='\e[1;37m'
red='\e[1;31m'
yellow='\e[1;33m'
BlueF='\e[1;34m'

################################################
# OPTIONS
################################################

again='n'
while  [ $again == 'n' ] || [ $again == 'n' ];
    do

#################################################


#################################################
# BANNER
#################################################
clear
echo -e $okegreen ""
echo "     ____              _______     _________       		"
echo "     \   \            /   /   \   /   ______|         		"
echo "      \   \    /\    /   /     \ /   /                		"
echo "       \   \  /  \  /   /   _   \   |               		"
echo "        \   \/    \/   /   ___   \  |             		"
echo "         \     /\     /   /   \   \  \ _____  			"
echo "          \___/  \___/___/     \___\ _______| v1.0      	"             
echo ""
echo -e $white"     -----------------------------------------"
echo -e $white"          WIFI Automatic Connector"
echo -e $white"     -----------------------------------------"
echo -e $cyan ""
echo -e $white"     [$okegreen"1"$white]$cyan  CONNECT TO WIFI WPA2-PSK (CREATE NEW CONF)  "
echo -e $white"     [$okegreen"2"$white]$cyan  CONNECT TO WIFI WPA2-PSK (LOAD OLD CONF)  "
echo -e $white"     [$okegreen"3"$white]$cyan  CONNECT TO WIFI WPA  "
echo -e $white"     [$okegreen"4"$white]$cyan  EXIT  "
echo ""
echo -n -e $BlueF'     \033[4mwac\033[0m >> '; tput sgr0
read wac
echo -e $okegreen"     --------------------------------------------------   ";
		if test $wac == '1'
			then
				iwconfig
				echo
				echo -e $cyan"What your wireless interface?"
				read interface
				echo
				ifconfig $interface up
				iwlist $interface scan | grep "ESSID"
				echo -e $cyan"What your ESSID?"
				read essid
				iwconfig $interface ESSID "$essid"
				echo
				echo -e $cyan"Enter your ESSID password:"
				stty -echo
				read pass
				stty echo
				echo -e $cyan"Enter your *.conf name:"
				read conf
				wpa_passphrase "$essid" $pass > /etc/$conf.conf
				wpa_supplicant -D wext -i $interface -c /etc/$conf.conf -B
				dhclient $interface
				echo
				echo "Test your connection!"
				ping -c3 google.com
		elif test $wac == '2'
			then
				iwconfig
                		echo
                		echo -e $cyan"What your wireless interface?"
                		read interface
               			echo
                		ifconfig $interface up
				iwlist $interface scan | grep "ESSID"
                		echo -e $cyan"What your ESSID?"
                		read essid
                		iwconfig $interface ESSID "$essid"
                		echo
				echo -e $cyan"What name of file .conf to load?"
				read conf
				wpa_supplicant -D wext -i $interface -c /etc/$conf.conf -B
                		dhclient $interface
                		echo
                		echo "Test your connection!"
				ping -c3 google.com
		elif test $wac == '3'
			then
				iwconfig
               			echo
               			echo -e $cyan"What your wireless interface?"
                		read interface
                		echo "Check your interface active or nonactive"
				ifconfig
				echo
                		ifconfig $interface up
                		iwlist $interface scan | grep "ESSID"
                		echo -e $cyan"What your ESSID?"
                		read essid
                		iwconfig $interface ESSID "$essid"
                		echo
                		dhclient $interface
                		echo
				echo "Test your connection!"
				ping -c3 google.com
		elif test $wac == '4'
		      then
		        clear
		        exit
			fi
				echo -n -e "Do you want to exit (y/n)? ";
					read again
						while  [ $again != 'n' ] && [ $again != 'N' ] && [ $again != 'y' ] && [ $again != 'Y' ];
							do
						       	echo -n "Do you want to exit (y/n)?";
						       	read again;
						    done
				done
