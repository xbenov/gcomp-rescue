# Defend scenario

A company hired you to review and fix potential security issues in their database and web system, which the inexperienced son of the company owner tried to set up on his own. Their internal network has a web server and a database server for now. Both use Debian 10 as operating system. The web server contains Apache 2 service for web management with phpMyAdmin set up for remote management of databases. The database server has a Mysql/Mariadb service as the database.

Login to your management machine with username kali and password kali.

________________
## Task 1: MySQL/MariaDB configuration

### Task assignment:
On the database server, log in to the mysql service as the root user, there is no password. Check the user table and fix the following basic security issues:
* Add password for root user on localhost
* Remove remote root user
* Remove anonymous users
* Remove test user and test database

### Hints:
To use the mysql service type “mysql -u USER”, where USER is the name of the user to log in as.
A simple query to check the user table is “SELECT user,host,password FROM mysql.user”
Use an internet search engine to find how to perform these simple tasks as mysql queries.
________________
## Task 2: phpMyAdmin configuration

### Task assignment:
On the web server, set an alias for the phpMyAdmin web app in the Apache configuration file. Next open the phpMyAdmin configuration file and review the settings. Configure a blowfish secret and remove leftover credentials for connection to MySQL which were left behind.
### Hints:
The path to the phpMyAdmin configuration file: /usr/share/phpmyadmin/config.inc.php
The path to the Apache configuration file for alias change is: /etc/apache2/apache2.conf

________________
## Task 3: SSL communication

### Task assignment:
We want to secure our communication from phpMyAdmin to MySQL using SSL. We already have our certificate and key files for server and client, which can be found on the database server in /etc/mysql/ssl directory. 
We now need to copy the CA certificate, client key and client certificate to the web server. 
After that, open and edit the MySQL configuration file and set up SSL configuration settings. There’s a peculiarity in the commented out SSL settings provided in the configuration file and it’s that “ssl = on” is not a valid setting. The correct setting that you must use is “ssl = true”. 
Do the same on the web server side with the phpMyAdmin configuration file. Leave the ssl_verify setting as false.
Don’t forget to change the appropriate owner and group for all files used for SSL, so that Apache which runs under www-data and Mysql which runs under mysql can read them.
## Hints:

________________
## Task 4: Linux user accounts security

### Task assignment:
On both WEB and DAT servers there are user accounts with weak passwords. On one server, there is also an account that is obviously unnecessary and should be removed. Configure password policy to force users to use stronger passwords. Use cracklib PAM module to set these password policies:
* Number of retries:                 3
* Minimal length:                12
* Upper case letters:                at least 2
* Lower case letters:                at least 4
* Digit letters:                        at least 3
* Other letters:                        at least 1
* Difference from previous:        4
* Can not use username in password
* Policy applies also for root user

After setting the new password policies, change passwords for all users. Check group permissions for user accounts. Only user accounts with gcomp prefix in their name should have sudo group assigned. 

### Hints:
man pam_cracklib
man gpasswd
________________
## Task 5: File permissions

### Task assignment:
There are some files for which we should set permissions, owner and group. 
On the web server, navigate to /var/www directory and change all directories and files inside to owner webdev and to group www-data. Also change the file permissions to all directories and files to 750. Also apply these same permissions, owner and group to file “/usr/share/phpmyadmin/config.inc.php”.

On the database server, navigate to /etc/mysql directory and change all directories and files inside to owner datservice and to group mysql. Also change the file permissions to all directories and files to 750.
### Hints:

