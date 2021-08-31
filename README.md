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

## **Variables**<br>
**MYSQL_ROOT_PW**
***This is the Mysql Database Server root user's password.*** 

#### **MYSQL_USER**
***New Mysql user that is created when the script is run***

#### **MYSQL_USER_PW**
***The password for the newly created mysql user***

#### **nextcloud_user**
***This will be the Username that will be used to login to nextcloud***

#### **ncuser_pass**
***Password for Nextcloud User***

Save and close the file<br>
***CTRL-X then Y***<br>
Run the script<br>
***./nextcloud.sh***<br>
