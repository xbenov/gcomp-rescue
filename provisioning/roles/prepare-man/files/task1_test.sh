#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
NC='\033[0m'

#check password for root user on localhost
field=$(mysql -u gcomp -pAVeryStrongP455 -h 10.10.30.81 -BNe 'USE mysql; SELECT password FROM user WHERE user="root" AND host="localhost"')

if [ "$field" != '' ]
then
  echo -e "TASK 1: Root password set - ${GREEN}DONE${NC}" >&1
else
  echo -e "TASK 1: Root password set - ${RED}WRONG${NC}" >&2
fi

#check remote root removal
field=$(mysql -u gcomp -pAVeryStrongP455 -h 10.10.30.81 -BNe 'USE mysql; SELECT * FROM user WHERE user="root" AND host!="localhost"')

if [ "$field" == '' ]
then
  echo -e "TASK 1: Remote root removed - ${GREEN}DONE${NC}" >&1
else
  echo -e "TASK 1: Remote root removed - ${RED}WRONG${NC}" >&2
fi

#check anonymous user removal
field=$(mysql -u gcomp -pAVeryStrongP455 -h 10.10.30.81 -BNe 'USE mysql; SELECT * FROM user WHERE user=""')

if [ "$field" == '' ]
then
  echo -e "TASK 1: Anonymous users removed - ${GREEN}DONE${NC}" >&1
else
  echo -e "TASK 1: Anonymous users removed - ${RED}WRONG${NC}" >&2
fi

#check test user and database removal
field=$(mysql -u gcomp -pAVeryStrongP455 -h 10.10.30.81 -BNe 'USE mysql; SELECT * FROM user WHERE user="test"')

if [ "$field" == '' ] && ! mysql -u gcomp -pAVeryStrongP455 -h 10.10.30.81 -BNe 'USE test;' 2>/dev/null
then
  echo -e "TASK 1: Test database and user removed - ${GREEN}DONE${NC}" >&1
else
  echo -e "TASK 1: Test database and user  removed - ${RED}WRONG${NC}" >&2
fi
