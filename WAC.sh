#!/usr/bin/env bash

#===========================================================================#
#                          Wireless Connector Automatic			    #
#									    #
#                        Script write by BlackCat			    #
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


#################################################
# ETHERNET
#################################################
function ethernet(){
clear
echo -e $white ""
echo "     ===================================== "
echo "              __      ___   ___ "
echo "              \ \    / /_\ / __|"
echo "               \ \/\/ / _ \ (__ "
echo "                \_/\_/_/ \_\___|v1.1"
echo ""
echo "     ===================================== "
echo -e $white"          Wireless Automatic Connector"
echo "     ===================================== "
echo -e $cyan ""
echo -e "     $okegreen"1"$white)$cyan  CONNECT TO STATIC IP"
echo -e "     $okegreen"2"$white)$cyan  CONNECT TO DYNAMIC IP  "
echo -e "     $okegreen"3"$white)$cyan  BACK  "
echo ""
echo -n -e $BlueF'     \033[4mwac\033[0m >> '; tput sgr0
read wac
echo -e $okegreen"     --------------------------------------------------   ";
		if test $wac == '1'
			then
				echo -e $cyan"Scanning your interface...."
				sleep 2
				iwconfig
				echo -e $cyan"Choose your interface you want: "
				read interface
				ip link set $interface up
				echo -e $cyan"Insert your address and prefix: "
				read addr
				echo -e $cyan"Insert your broadcast address: "
				read broad
				ip addr add $addr broadcast $broad dev $int
				echo -e $cyan"Insert your gateway: "
				read gateway
				ip route add default via $gateway
		elif test $wac == '2'
			then
				clear
				echo -e $cyan"Scanning your interface...."
				sleep 1
				iwconfig
				echo -e $cyan"Choose your interface you want: "
				read int
				ip link set $int up
				echo -e $cyan"Obtaining ip address"
				dhclient -i $int
				echo -e $cyan"Succesfully"
				sleep 1
				echo -e $cyan"Test your connection!"
				ping -c3 www.google.com
				clear
		elif test $wac = '3'
			then
				menu
				else
					echo ""
				fi
					echo ""
					echo -n -e $red " Back to Last Menu? ( Yes / No ) :"
					read back
				if [ $back != 'y' ] && [ $back != 'Y' ] && [ $back != 'yes' ] && [ $back != 'Yes' ]
					then
					clear
					exit
				elif [ $back != 'y' ] && [ $back != 'Y' ] && [ $back != 'yes' ] && [ $back != 'Yes' ]
					then
					menu
				fi

}

#################################################
# ABOUT
#################################################
function about {
clear
echo -e $white ""
echo "     ===================================== "
echo "              __      ___   ___ "
echo "              \ \    / /_\ / __|"
echo "               \ \/\/ / _ \ (__ "
echo "                \_/\_/_/ \_\___|v1.1"
echo ""
echo "     ===================================== "
echo -e $white"          Wireless Automatic Connector"
echo "     ===================================== "
echo ""
echo "      WAC (Wireless Automatic Connector) is an open"
echo "      source program which is using to connect wifi"
echo "      wpa or wpa-2psk quickly and easily."
}

#################################################
# MENU
#################################################
function menu(){
clear
echo -e $white ""
echo "     ===================================== "
echo "              __      ___   ___ "
echo "              \ \    / /_\ / __|"
echo "               \ \/\/ / _ \ (__ "
echo "                \_/\_/_/ \_\___|v1.1"
echo ""
echo "     ===================================== "
echo -e $white"          Wireless Automatic Connector"
echo "     ===================================== "
echo -e $cyan ""
echo -e "     $okegreen"1"$white)$cyan  CONNECT TO ETHERNET (DYNAMIC/STATIC IP)"
echo -e "     $okegreen"2"$white)$cyan  CONNECT TO WIFI WPA2-PSK (CREATE NEW CONF)  "
echo -e "     $okegreen"3"$white)$cyan  CONNECT TO WIFI WPA2-PSK (LOAD OLD CONF)  "
echo -e "     $okegreen"4"$white)$cyan  CONNECT TO WIFI WPA  "
echo -e "     $okegreen"5"$white)$cyan  ABOUT  "
echo -e "     $okegreen"6"$white)$cyan  EXIT  "
echo ""
echo -n -e $BlueF'     \033[4mwac\033[0m >> '; tput sgr0
read wac
echo -e $okegreen"     --------------------------------------------------   ";
		if test $wac == '1'
			then
			ethernet
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
		elif test $wac == '3'
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
		elif test $wac == '4'
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
		elif test $wac == '5'
			then
				about
		elif test $wac == '6'
		    then
		        clear
		        exit
			else
				echo ""
			fi
				echo ""
				echo -n "      Back to menu (y/n)?"
				ead back
				if [ $back != 'y' ] && [ $back != 'Y' ] && [ $back != 'yes' ] && [ $back != 'Yes' ]
					then
					clear
					exit
				elif [ $back != 'n' ] && [ $back != 'N' ] && [ $back != 'no' ] && [ $back != 'No' ]
					then
					menu
fi
}

#################################################
# BANNER
#################################################
clear
echo -e $white ""
echo "     ===================================== "
echo "              __      ___   ___ "
echo "              \ \    / /_\ / __|"
echo "               \ \/\/ / _ \ (__ "
echo "                \_/\_/_/ \_\___|v1.1"
echo ""
echo "     ===================================== "
echo -e $white"          Wireless Automatic Connector"
echo "     ===================================== "
echo -e $cyan ""
echo -e "     $okegreen"1"$white)$cyan  CONNECT TO ETHERNET (DYNAMIC/STATIC IP)"
echo -e "     $okegreen"2"$white)$cyan  CONNECT TO WIFI WPA2-PSK (CREATE NEW CONF)  "
echo -e "     $okegreen"3"$white)$cyan  CONNECT TO WIFI WPA2-PSK (LOAD OLD CONF)  "
echo -e "     $okegreen"4"$white)$cyan  CONNECT TO WIFI WPA  "
echo -e "     $okegreen"5"$white)$cyan  ABOUT  "
echo -e "     $okegreen"6"$white)$cyan  EXIT  "
echo ""
echo -n -e $BlueF'     \033[4mwac\033[0m >> '; tput sgr0
read wac
echo -e $okegreen"     --------------------------------------------------   ";
		if test $wac == '1'
			then
			ethernet
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
		elif test $wac == '3'
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
		elif test $wac == '4'
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
		elif test $wac == '5'
			then
				about
		elif test $wac == '6'
		    then
		        clear
		        exit
			else
				echo ""
			fi
				echo ""
				echo -n "      Back to menu (y/n)?"
				ead back
				if [ $back != 'y' ] && [ $back != 'Y' ] && [ $back != 'yes' ] && [ $back != 'Yes' ]
					then
					clear
					exit
				elif [ $back != 'n' ] && [ $back != 'N' ] && [ $back != 'no' ] && [ $back != 'No' ]
					then
					menu
fi
