## Nextcloud Install Script
----
#### Description
The script uses variables provided by the user and installs a LAMP Stack with Nextcloud on top.
----
#### Usage<br> 
Clone the repository:<br>
***git clone https://github.com/ryanc410/nextcloud-install.git***<br>
CD into Directory:<br>
***cd nextcloud-install***<br>
Make script executable:<br>
***chmod +x nextcloud.sh***<br>
Open script in your preferred text editor and  fill in the variables at the top:<br>
***nano nextcloud.sh***<br>

## Variables
#### DOMAIN
This is the domain name that will be used to access the nextcloud instance.

#### DB_ROOT_PW
This is the Mysql Database Server root user's password.

#### DB_USER
Nextcloud database username

#### DB_USER_PASS
The password for the nextcloud database user

## Save and close the file
CTRL-X then Y<br>
Run the script<br>
***./nextcloud.sh***<br>
