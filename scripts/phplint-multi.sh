#!/bin/bash

VALID_VERSIONS="5.3,5.4,5.5,5.6,7.0,7.1,7.2"

if [ -z "${1}" ]; then
    echo "Please enter at least one php version number, like '5.6' or '5.3,7.0'"
    exit 1
fi

for i in ${1//,/ }
do
   if [[ ! $VALID_VERSIONS =~ "$i" ]]; then
    echo "You can only pass these PHP versions: $VALID_VERSIONS"
    exit 1
   fi
done

for i in ${1//,/ }
do
   if [[ "$i" == "5.3" ]];then
      source $HOME/.phpbrew/bashrc
      phpbrew use 5.3.29
   elif [[ "$i" == "5.4" ]];then
      source $HOME/.phpbrew/bashrc
      phpbrew use 5.4.45
   elif [[ "$i" == "5.5" ]];then
      source $HOME/.phpbrew/bashrc
      phpbrew use 5.5.38
   elif [[ "$i" == "5.6" ]];then
      source $HOME/.phpbrew/bashrc
      phpbrew use 5.6.34
   elif [[ "$i" == "7.0" ]];then
      source $HOME/.phpbrew/bashrc
      phpbrew use 7.0.28
   elif [[ "$i" == "7.1" ]];then
      source $HOME/.phpbrew/bashrc
      phpbrew use 7.1.15
   elif [[ "$i" == "7.2" ]];then
      source $HOME/.phpbrew/bashrc
      phpbrew use 7.2.3
   fi

   VERSION=`php -v | head -1`
   echo "Running lint on $VERSION..."
   "php-parallel-lint" "${@:2}"

   rc=$?

   source $HOME/.phpbrew/bashrc
   phpbrew use 7.0.28

   if [[ $rc != 0 ]] ; then
     # A non-zero return code means an error occurred, so tell the user and exit
     exit $rc
   fi

done
