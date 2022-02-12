#!/bin/bash
curl --compressed https://raw.githubusercontent.com/stamparm/ipsum/master/ipsum.txt 2>/dev/null | grep -v "#" | cut -f 1 > ipsum.ipset
echo Done
