#!/bin/bash
set -e

HEROKU=false

while getopts “h” OPTION
do
    case $OPTION in
        h)
             echo "Heroku reset"
             HEROKU=true
             ;;
        ?)
             echo "fail"
             exit
             ;;
     esac
done
if  $HEROKU ; then
    heroku run rake db:reset
    heroku run rake db:migrate
else
    rake db:migrate:reset
    rake db:seed
fi

