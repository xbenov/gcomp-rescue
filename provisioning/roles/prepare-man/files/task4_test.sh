#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
NC='\033[0m'

#get config files to check
sshpass -p "vagrant" rsync -e 'ssh -o StrictHostKeyChecking=no -p 22' vagrant@10.10.30.81:/etc/pam.d/common-password /home/kali/check_tasks/files/common-password-dat
sshpass -p "vagrant" rsync -e 'ssh -o StrictHostKeyChecking=no -p 22' vagrant@10.10.30.71:/etc/pam.d/common-password /home/kali/check_tasks/files/common-password-web

#get /etc/shadow and /etc/group files to check
sshpass -p "vagrant" rsync -e 'ssh -o StrictHostKeyChecking=no -p 22' --rsync-path="sudo rsync" vagrant@10.10.30.81:/etc/shadow /home/kali/check_tasks/files/sh-dat
sshpass -p "vagrant" rsync -e 'ssh -o StrictHostKeyChecking=no -p 22' --rsync-path="sudo rsync" vagrant@10.10.30.71:/etc/shadow /home/kali/check_tasks/files/sh-web
sshpass -p "vagrant" rsync -e 'ssh -o StrictHostKeyChecking=no -p 22' vagrant@10.10.30.81:/etc/group /home/kali/check_tasks/files/gr-dat
sshpass -p "vagrant" rsync -e 'ssh -o StrictHostKeyChecking=no -p 22' vagrant@10.10.30.71:/etc/group /home/kali/check_tasks/files/gr-web

#grep lines with config
dat_conf="`grep pam_cracklib.so /home/kali/check_tasks/files/common-password-dat`"
web_conf="`grep pam_cracklib.so /home/kali/check_tasks/files/common-password-web`"

#list of required configs
configs=("retry=3" "difok=4" "minlen=12" "dcredit=3" "ucredit=2" "lcredit=4" "ocredit=1" "reject_username" "enforce_for_root")

#default values
web=1
dat=1

#check web config
for str in ${configs[@]}; do
  if ! grep -F -q $str <<< $web_conf
  then
    web=0
  fi
done

#check dat config
for str in ${configs[@]}; do
  if ! grep -F -q $str <<< $dat_conf
  then
    dat=0
  fi
done

#print output
if [ "$web" == '1' ] && [ "$dat" == '1' ]
then
  echo -e "TASK 4: Password policy - ${GREEN}DONE${NC}" >&1
else
  echo -e "TASK 4: Password policy - ${RED}WRONG${NC}" >&2
fi

#check password changes
web=1
dat=1

#grep user lines
dat_gcomp="`grep gcomp-dat /home/kali/check_tasks/files/sh-dat`"
dat_datsrv="`grep datservice /home/kali/check_tasks/files/sh-dat`"
web_gcomp="`grep gcomp-web /home/kali/check_tasks/files/sh-web`"
web_webdev="`grep webdev /home/kali/check_tasks/files/sh-web`"

#check web passwords
if grep -F -q MdB63Iun <<< $web_gcomp || grep -F -q Vd7hkkIV <<< $web_webdev
then
  web=0
fi

#check dat passwords
if grep -F -q UYPPl1Zt <<< $dat_gcomp || grep -F -q IHa3Jflx <<< $dat_datsrv
then
  dat=0
fi

#print output
if [ "$web" == '1' ] && [ "$dat" == '1' ]
then
  echo -e "TASK 4: Password change - ${GREEN}DONE${NC}" >&1
else
  echo -e "TASK 4: Password change - ${RED}WRONG${NC}" >&2
fi

#check user group change
web=1
dat=1

#grep user lines
dat_gr="`grep sudo /home/kali/check_tasks/files/gr-dat`"
web_gr="`grep sudo /home/kali/check_tasks/files/gr-web`"

#check web user group
if grep -F -q webdev <<< $web_gr
then
  web=0
fi

#check dat user group
if grep -F -q datservice <<< $dat_gr
then
  web=0
fi

#print output
if [ "$web" == '1' ] && [ "$dat" == '1' ]
then
  echo -e "TASK 4: Group sudo removed - ${GREEN}DONE${NC}" >&1
else
  echo -e "TASK 4: Group sudo removed - ${RED}WRONG${NC}" >&2
fi

#check deletion of unnecessary user
#print output
if ! grep -q -E '^test' /home/kali/check_tasks/files/sh-dat
then
  echo -e "TASK 4: Unnecessary user removed - ${GREEN}DONE${NC}" >&1
else
  echo -e "TASK 4: Unnecessary user removed - ${RED}WRONG${NC}" >&2
fi
