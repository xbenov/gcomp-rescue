#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
NC='\033[0m'

script_dat='sudo stat -L -c "%a %U %G %n" $(sudo find /etc/mysql) >> /tmp/dat_ls_out'
script_web='sudo stat -L -c "%a %U %G %n" $(sudo find /var/www /usr/share/phpmyadmin/config.inc.php) >> /tmp/web_ls_out'

#gather info about directories and files on DAT
#get file stats on remote machine and save output to file
sshpass -p "vagrant" ssh vagrant@10.10.30.81 "$script_dat"

#copy file to local files
sshpass -p "vagrant" rsync -e 'ssh -o StrictHostKeyChecking=no -p 22' --rsync-path="sudo rsync" vagrant@10.10.30.81:/tmp/dat_ls_out /home/kali/check_tasks/files/dat_ls_out
sshpass -p "vagrant" ssh vagrant@10.10.30.81 "rm /tmp/dat_ls_out"

#gather info about directories and files on WEB
#execute ls -l on remote machine and save output to file
sshpass -p "vagrant" ssh vagrant@10.10.30.71 "$script_web"

#copy file to local files
sshpass -p "vagrant" rsync -e 'ssh -o StrictHostKeyChecking=no -p 22' --rsync-path="sudo rsync" vagrant@10.10.30.71:/tmp/web_ls_out /home/kali/check_tasks/files/web_ls_out
sshpass -p "vagrant" ssh vagrant@10.10.30.71 "rm /tmp/web_ls_out"

#check owner and group on DAT and WEB
if [ $(grep -F -c "datservice mysql" files/dat_ls_out) == $(wc -l < files/dat_ls_out) ]
then
  echo -e "TASK 5: DAT - Owner and group set - ${GREEN}DONE${NC}" >&1
else
  echo -e "TASK 5: DAT - Owner and group set - ${RED}WRONG${NC}" >&2
fi

if [ $(grep -F -c "webdev www-data" files/web_ls_out) == $(wc -l < files/web_ls_out) ]
then
  echo -e "TASK 5: WEB - Owner and group set - ${GREEN}DONE${NC}" >&1
else
  echo -e "TASK 5: WEB - Owner and group set - ${RED}WRONG${NC}" >&2
fi

#check permissions of files on DAT and WEB
if [ $(grep -F -c "750 " files/dat_ls_out) == $(wc -l < files/dat_ls_out) ]
then
  echo -e "TASK 5: DAT - Permissions set - ${GREEN}DONE${NC}" >&1
else
  echo -e "TASK 5: DAT - Permissions set - ${RED}WRONG${NC}" >&2
fi

if [ $(grep -F -c "750 " files/web_ls_out) == $(wc -l < files/web_ls_out) ]
then
  echo -e "TASK 5: WEB - Permissions set - ${GREEN}DONE${NC}" >&1
else
  echo -e "TASK 5: WEB - Permissions set - ${RED}WRONG${NC}" >&2
fi
