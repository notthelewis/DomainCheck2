#!/bin/bash

host -t A $1
host -t AAAA $1
host -t TXT $1
host -t MX $1
host -t NS $1
host -t SOA $1
host -t TXT default._domainkey.$1
