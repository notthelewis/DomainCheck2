What makes this version of the tool quicker is the fact that it tries to use contiguous memory writes in 1 command. 
There is a more complicated version, which I will upload shortly- that one is connected to a PHP, HTML & CSS front end, and has a few extra little quirks compared to this version. 

The main aim of this is a backend bash script so that I can just run it and get the information quickly... How quickly?

$ time ./init.sh google.com 0

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
