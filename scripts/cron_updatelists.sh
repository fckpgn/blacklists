#!/bin/bash

#cron job sample for ubuntu with installed and working iptables
#
#packages: iptables iptables-persistent ipset ipset-persistent git curl
#
#ipset persistent file path can be different, check it, for my system it is /etc/iptables/ipsets
#
#IPSET rules should be created:
#ipset create ipsum -exist hash:net family inet hashsize 32768 maxelem 200000
#ipset create badip_detected -exist hash:net family inet hashsize 32768 maxelem 200000
#
#IPTABLES rules should be created
#-A INPUT -s YOURIP -p tcp -m tcp --dport 22 -j ACCEPT
#-A INPUT -m set --match-set ipsum src -j DROP
#-A INPUT -m set --match-set badip_detected src -j DROP
#
#Installing (as root, will run every hour at 55min):
#su
#cd /root
#git clone https://github.com/fckpgn/blacklists.git
#crontab -e
#55 * * * * /root/blacklists/scripts/cron_updatelists.sh >/dev/null 2>&1
#
#
curl --compressed https://raw.githubusercontent.com/stamparm/ipsum/master/ipsum.txt 2>/dev/null | grep -v "#" | cut -f 1 > /root/blacklists/ipsum.ipset
curl --compressed https://raw.githubusercontent.com/fckpgn/blacklists/main/badip_detected.ipset > /root/blacklists/badip_detected.ipset

ipset -q flush ipsum
for ip in $(cat /root/blacklists/ipsum.ipset); do ipset add ipsum $ip; done
ipset -q flush badip_detected
for ip in $(cat /root/blacklists/badip_detected.ipset); do ipset add badip_detected $ip; done

ipset save > /etc/iptables/ipsets
