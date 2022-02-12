#!/bin/bash

#ipsum
#sudo ipset create ipsum -exist hash:net family inet hashsize 32768 maxelem 200000
ipset -q flush ipsum
for ip in $(cat ipsum.ipset); do ipset add ipsum $ip; done

#badip_detected
#ipset create badip_detected -exist hash:net family inet hashsize 32768 maxelem 200000
ipset -q flush badip_detected
for ip in $(cat badip_detected.ipset); do ipset add badip_detected $ip; done
