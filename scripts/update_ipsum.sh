#!/bin/bash
git pull
curl --compressed https://raw.githubusercontent.com/stamparm/ipsum/master/ipsum.txt 2>/dev/null | grep -v "#" | cut -f 1 > ipsum.ipset
git commit -a -m "autoupdate"
git push
echo Done
