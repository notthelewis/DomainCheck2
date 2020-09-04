#!/bin/bash

dn=$(echo $1 | cut -d/ -f1 --complement | cut -d/ -f3 --complement | sed 's/\///g')

if [[ $2 == 0  ||  $2 == 2 ]]; then
  ./whois.sh $dn > ./log/$dn.html && printf "\n" && ./dig.sh $dn >> ./log/$dn.html
  cat ./log/$dn.html
fi

if [[ $2 == 1  ||  $2 == 3 ]]; then
  ./whois.sh $dn > ./log/$dn.html && ./digX.sh $dn >> ./log/$dn.html
  cat ./log/$dn.html|sed 's/has address/A/g' | sed 's/has IPv6 address/AAAA/g'| sed 's/descriptive text/TXT/g' | sed 's/mail is handled by/MX/g' | sed 's/name server/NS/g' | sed 's/has SOA record/SOA/g'
fi
