#!/bin/bash

 ######################################################
 ## functions
 ###################################################### 

function usage() {
  cat << EOF
  usage: $0 <message> 

  this script uses arguments from command line and runs echos arguments

  OPTIONS:
     -h
     -v <verbose flag>
     -m <message>

  EXAMPLES:
     $0 -h
     $0 -vm <message>
     $0 -m <message>
     
  NOTES:
    -h is help
    -m is message
    -v is verbose flag

EOF
    
}

 ######################################################
 ## parsing args and validating parameters
 ###################################################### 

timestamp=$(date +"%Y%m%d%H%M%S")
message=
verbose_flag=

while getopts "hvm:" OPTION
do
  case $OPTION in
    h)
        usage
        exit 0
        ;;
    v)
        verbose_flag=true
        ;;
    m)
        message=$OPTARG
        ;;
    ?)
        usage
        exit 1
  esac
done

if [ -z "$message" ]; then message='NO_MESSAGE'; fi

script_path=$(readlink -f $0)
parent_path=$(dirname $script_path)
target_path=${parent_path}/../target

if [ -n "$verbose_flag" ]; then
  echo "timestamp           => $timestamp"
  echo "script path         => $script_path"
  echo "parent path         => $parent_path"
  echo "target path         => $target_path"
  echo "message             => $message"
  echo "verbose_flag        => true"
  echo ""
fi


 ######################################################
 ## executing command
 ###################################################### 

 # echoing command
echo 
echo echo $message
echo 

 # executing command
echo $message

