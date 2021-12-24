# Nextcloud Install Script
[Github Repository Here](https://github.com/ryanc410/nextcloud-install-script.git)
Written by [Ryan C](mailto:ryanhtown713@outlook.com)

---
# Table of Contents
<ul>
  <li><a href="#pre-requisites">Pre Requisites</a></li>
  <li><a href="#cloning-the-repository">Cloning the Repository</a></li>
  <li><a href="#usage">Usage</a></li>
  <li><a href="#options">Options</a></li>
  <li><a href="#dns">DNS Settings</a></li>
</ul>

# Pre Requisites
1. Preferably a fresh install of Ubuntu Server version >= 18
2. DNS record for a nextcloud subdomain. Script automatically installs nextcloud in a subdomain of the domain specified when executing script.
3. The ability to execute commands with root privileges or using the sudo command.
---
### Cloning the Repository (#cloning)
````bash
git clone https://github.com/ryanc410/nextcloud-install-script.git
Cloning into 'nextcloud-install-script'...
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 3 (delta 22), reused 3 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), 1.44 MiB | 4.72 MiB/s, done.
cd nextcloud-install-script
chmod +x nextcloud.sh
sudo ./nextcloud.sh --domain example.com --ip 192.168.1.1
````

### Usage
Installs Nextcloud **version 23.0.0**
Script **MUST** be executed with the Domain in which nextcloud will become a subdomain to, and the IP Address that resolves to said Domain.
The script updates the server first, then installs a LAMP Stack.
---
### Packages installed by script:
- ***apache2***
- ***apache2-utils***
- ***mariadb-server*** 
- ***mariadb-client***
- ***php7.4***
- ***php7.4-gd*** 
- ***php7.4-curl*** 
- ***php7.4-zip*** 
- ***php7.4-xml*** 
- ***php7.4-mbstring*** 
- ***php7.4-bz2*** 
- ***php7.4-intl*** 
- ***php7.4-bcmath*** 
- ***php7.4-gmp***
- ***php7.4-mysql***
- ***php7.4-cli***
- ***php7.4-common***
- ***php7.4-json***
- ***php7.4-opcache***
- ***php7.4-readline***
- ***php7.4-fpm*** 
- ***php-imagick*** 
- ***php-common*** 
- ***libapache2-mod-php7.4*** 
- ***imagemagick*** 
- ***unzip***
- ***certbot***
- ***python3-certbot-apache***
---
### Apache Modules Enabled by Script:
- ***rewrite*** 
- ***headers*** 
- ***env*** 
- ***dir*** 
- ***mime*** 
- ***setenvif*** 
- ***ssl***
---
### Options
**Specifying the Domain**
`./nextcloud.sh -d [arg]` or `./nextcloud.sh --domain [arg]`
An acceptable argument to the domain option would be `example.com` or `example.org` or `example.site` etc.
There should already be DNS records that allocate a subdomain of nextcloud to said Domain or else this script will fail.
Instructions on setting DNS Records can be found [HERE](#DNS)
**Specifying the IP Address**
***This is strictly for the virtual host file in case you are/plan on hosting multiple sites or have multiple IP address on one server***
`./nextcloud.sh -i [arg]` or `./nextcloud.sh --ip [arg]`

# DNS
