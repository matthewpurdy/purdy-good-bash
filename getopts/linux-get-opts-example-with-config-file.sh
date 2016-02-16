#!/bin/bash

 ######################################################
 ## functions
 ###################################################### 

function usage() {
  cat << EOF
  usage: $0 -m <message> 
  
  this script uses arguments from command line and runs echos arguments
  
  OPTIONS:
     -h
     -v <verbose flag>
     -c <config path>
     
  EXAMPLES:
     $0 -h
     $0 -vc <config path> 
     $0 -c <config path> 
     
  NOTES:
    -h is help
    -v is verbose flag
    
EOF

}

function string_trim() {
  echo "$(echo -e "${1}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's/^[\t]*//' -e 's/[\t]*$//')"
}

function parse_properties() {
  save_IFS=$IFS
  IFS=$'\n'
  
  for raw_line in $(cat $config_path)
  do
    line=$(string_trim "$raw_line")
    if [ -n "$line" ]; then
      if [[ "$line" != "#"* ]]; then
        echo "${line}"
      fi
    fi
  done
  
  IFS=$save_IFS
}

 ######################################################
 ## parsing args and validating parameters
 ###################################################### 

timestamp=$(date +"%Y%m%d%H%M%S")
config_path=
verbose_flag=

while getopts "hvc:" OPTION
do
  case $OPTION in
    h)
        usage
        exit 0
        ;;
    v)
        verbose_flag=true
        ;;
    c)
        config_path=$OPTARG
        ;;
    ?)
        usage
        exit 1
  esac
done

if [ -z "$config_path" ]; then usage; exit -1; fi

script_path=$(readlink -f $0)
parent_path=$(dirname $script_path)
target_path=${parent_path}/../target

save_IFS=$IFS
IFS=$'\n'
for var in $(parse_properties "$config_path"); do
  eval $var
done
IFS=$save_IFS

if [ -z "$message" ]; then message="NO_MESSAGE"; fi

if [ -n "$verbose_flag" ]; then
  echo "timestamp           => $timestamp"
  echo "script path         => $script_path"
  echo "parent path         => $parent_path"
  echo "target path         => $target_path"
  echo "config_path         => $config_path"
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

