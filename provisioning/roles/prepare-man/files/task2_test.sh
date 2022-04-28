#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
NC='\033[0m'

#get config files to check
sshpass -p "vagrant" rsync -e 'ssh -o StrictHostKeyChecking=no -p 22' vagrant@10.10.30.71:/etc/apache2/apache2.conf /home/kali/check_tasks/files/apache_conf
sshpass -p "vagrant" rsync -e 'ssh -o StrictHostKeyChecking=no -p 22' vagrant@10.10.30.71:/usr/share/phpmyadmin/config.inc.php /home/kali/check_tasks/files/phpmyadmin_conf

#check blowfish secret configuration
blowfish_conf=$(grep -oE '^\$cfg\[.blowfish_secret.] = ..*;' /home/kali/check_tasks/files/phpmyadmin_conf | cut -f4 -d"'")

if [ ${#blowfish_conf} -ge 32 ]
then
  echo -e "TASK 2: Blowfish secret configured - ${GREEN}DONE${NC}" >&1
else
  echo -e "TASK 2: Blowfish secret configured - ${RED}WRONG${NC}" >&2
fi

#check removal of leftover mysql login credentials
if ! grep -qoE 'user.*gcomp' /home/kali/check_tasks/files/phpmyadmin_conf && ! grep -qoE 'password.*AVeryStrongP455' /home/kali/check_tasks/files/phpmyadmin_conf
then
  echo -e "TASK 2: Login credentials removed - ${GREEN}DONE${NC}" >&1
else
  echo -e "TASK 2: Login credentials removed - ${RED}WRONG${NC}" >&2
fi

#check alias for phpmyadmin in apache
alias=$(grep -oE '^Alias .* /usr/share/phpmyadmin$' /home/kali/check_tasks/files/apache_conf | cut -f2 -d" ")

if [ $alias == '/phpmyadmin-gcomp' ]
then
  echo -e "TASK 2: Phpmyadmin alias configured - ${GREEN}DONE${NC}" >&1
else
  echo -e "TASK 2: Phpmyadmin alias configured - ${RED}WRONG${NC}" >&2
fi
