What makes this version of the tool quicker is the fact that it tries to use contiguous memory writes in 1 command. 
There is a more complicated version, which I will upload shortly- that one is connected to a PHP, HTML & CSS front end, and has a few extra little quirks compared to this version. 
Output from this one (including time command for proof of how quick it can run)

$ time ./init.sh google.com 0

   Domain Name: GOOGLE.COM
   Registry Domain ID: 2138514_DOMAIN_COM-VRSN
   Registrar WHOIS Server: whois.markmonitor.com
   Registrar URL: http://www.markmonitor.com
   Updated Date: 2019-09-09T15:39:04Z
   Creation Date: 1997-09-15T04:00:00Z
   Registry Expiry Date: 2028-09-14T04:00:00Z
   Registrar: MarkMonitor Inc.
   Registrar IANA ID: 292
   Registrar Abuse Contact Email: abusecomplaints@markmonitor.com
   Registrar Abuse Contact Phone: +1.2083895740
   Domain Status: clientDeleteProhibited https://icann.org/epp#clientDeleteProhibited
   Domain Status: clientTransferProhibited https://icann.org/epp#clientTransferProhibited
   Domain Status: clientUpdateProhibited https://icann.org/epp#clientUpdateProhibited
   Domain Status: serverDeleteProhibited https://icann.org/epp#serverDeleteProhibited
   Domain Status: serverTransferProhibited https://icann.org/epp#serverTransferProhibited
   Domain Status: serverUpdateProhibited https://icann.org/epp#serverUpdateProhibited
   Name Server: NS1.GOOGLE.COM
   Name Server: NS2.GOOGLE.COM
   Name Server: NS3.GOOGLE.COM
   Name Server: NS4.GOOGLE.COM
   DNSSEC: unsigned
   URL of the ICANN Whois Inaccuracy Complaint Form: https://www.icann.org/wicf/
>>> Last update of whois database: 2019-10-01T16:47:57Z <<<
Trying "google.com"
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 21300
;; flags: qr rd ra; QUERY: 1, ANSWER: 11, AUTHORITY: 0, ADDITIONAL: 0

;; QUESTION SECTION:
;google.com.                    IN      ANY

;; ANSWER SECTION:
google.com.             113     IN      A       108.177.126.101
google.com.             113     IN      A       108.177.126.138
google.com.             113     IN      A       108.177.126.113
google.com.             113     IN      A       108.177.126.100
google.com.             113     IN      A       108.177.126.139
google.com.             113     IN      A       108.177.126.102
google.com.             278     IN      AAAA    2a00:1450:4013:c01::64
google.com.             338198  IN      NS      ns1.google.com.
google.com.             338198  IN      NS      ns2.google.com.
google.com.             338198  IN      NS      ns4.google.com.
google.com.             338198  IN      NS      ns3.google.com.

Received 224 bytes from 89.238.141.181#53 in 7 ms

	real    0m0.076s
	user    0m0.011s
	sys     0m0.014s




In order to use, you'll need to follow these steps: 

ON A RHEL BASED SYSTEM:
sudo yum install whois bind-utils -y 

ON A DEBIAN BASED SYSTEM: 
sudo apt install whois dnsutils -y

These are the only two dependencies. Once it has these two utilities, the tool needs to be treated as any other executable: 

sudo chmod +x dig.sh  digX.sh  init.sh  whois.sh

Then, to run in the directory:

./init.sh <DOMAIN_NAME> <EXTENDED_CHECK>

Examples of commands:

	 ./init.sh google.com 0 - quick check, recursive [ANY] query

	 ./init.sh google.com 2 - quick check, non-recursive query 

	 ./init.sh google.com 1 - extended check, recursive [ANY] query 

	 ./init.sh google.com 3 - extended check, non-recursive query 

<DOMAIN_NAME> parameter

Domain name is firstly sanitized. This means that:

http://
https://
ftp://


Will be removed, as the protocol that it's accessing does not make a difference. 

Anything including and after a trailing slash on the domain will be removed. 

So, if you typed: 

https://website1.com/anything.else.not.including.another.forward.slash

The only part which will be taken is:
website1.com

<EXTENDED_CHECK> parameter 

:THIS IS BROKEN INTO TWO CATEGORIES 
  
		0 or 2 
  
		1 or 3

0 and 2 will both run the base checks, without the extended checks. 
1 and 3 will run the extended checks. 

2 & 3 both employ the use of the recursion workaround script, which negates dig request failures due to RFC8482. For further information, visit:
https://tools.ietf.org/html/rfc8482
