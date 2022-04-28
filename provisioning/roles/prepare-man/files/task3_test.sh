#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
NC='\033[0m'

#get config files
sshpass -p "vagrant" rsync -e 'ssh -o StrictHostKeyChecking=no -p 22' vagrant@10.10.30.81:/etc/mysql/mariadb.conf.d/50-server.cnf /home/kali/check_tasks/files/mysql_conf
sshpass -p "vagrant" rsync -e 'ssh -o StrictHostKeyChecking=no -p 22' vagrant@10.10.30.71:/usr/share/phpmyadmin/config.inc.php /home/kali/check_tasks/files/phpmyadmin_conf

#check mysql ssl config
ssl_ca=$(grep -E '^ssl-ca.*ca-cert.pem' /home/kali/check_tasks/files/mysql_conf)
ssl_cert=$(grep -E '^ssl-cert.*server-cert.pem' /home/kali/check_tasks/files/mysql_conf)
ssl_key=$(grep -E '^ssl-key.*server-key.pem' /home/kali/check_tasks/files/mysql_conf)
ssl_true=$(grep -E '^ssl.*=.+true' /home/kali/check_tasks/files/mysql_conf)

if [ "$ssl_ca" != "" ] && [ "$ssl_cert" != "" ] && [ "$ssl_key" != "" ] && [ "$ssl_true" != "" ]
then
  echo -e "TASK 3: Mysql ssl configuration - ${GREEN}DONE${NC}" >&1
else
  echo -e "TASK 3: Mysql ssl configuration - ${RED}WRONG${NC}" >&2
fi

#check phpmyadmin ssl config
ssl_ca=$(grep -E 'ssl_ca.*ca-cert.pem' /home/kali/check_tasks/files/phpmyadmin_conf)
ssl_cert=$(grep -E 'ssl_cert.*client-cert.pem' /home/kali/check_tasks/files/phpmyadmin_conf)
ssl_key=$(grep -E 'ssl_key.*client-key.pem' /home/kali/check_tasks/files/phpmyadmin_conf)
ssl_true=$(grep -E 'ssl.*=.+true' /home/kali/check_tasks/files/phpmyadmin_conf)

if [ "$ssl_ca" != "" ] && [ "$ssl_cert" != "" ] && [ "$ssl_key" != "" ] && [ "$ssl_true" != "" ]
then
  echo -e "TASK 3: Phpmyadmin ssl configuration - ${GREEN}DONE${NC}" >&1
else
  echo -e "TASK 3: Phpmyadmin ssl configuration - ${RED}WRONG${NC}" >&2
fi




