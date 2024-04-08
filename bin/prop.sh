#!/bin/env bash

function prop_value(){
  sed -n -r "s/^[ \t]*($1)[ \t]*=[ \t]*([\']([^\']+)[\']|[\"]([^\"]+)[\"]|([^ \t\'\"\r]+)|([^ \t\'\"\r]+([ \t]+[^ \t\'\"\r]+)+))[ \t\r]*$/\3\4\5\6/p"
}

function prop_from(){
  key=$1
  while [ -n "$2" ] ; do
    if [ "--env" = "$2" ] ; then
      value=$( env | prop_value $key )
    else
      value=$( [ -r "$2" ] && cat "$2" | prop_value $key || true )
    fi
    [ -n "$value" ] && break || true
    shift
  done
  echo $value
}

function prop_export(){
  keys=()
  froms=()
  prefix=""
  suffix=""
  mode="-k"
  # parse params
  while [ -n "$1" ] ; do
    case "$1" in
      "--prefix" ) prefix="$2" ; shift ;;
      "--suffix" ) suffix="$2" ; shift ;;
      "-k" ) mode="-k" ;;
      "-f" ) mode="-f" ;;
      *)
        case $mode in
          "-k" ) keys+=( "$1" ) ;;
          "-f" ) froms+=( "$1" ) ;;
        esac
        ;;
    esac
    shift
  done
  # do export
  for key in "${keys[@]}" ; do
     export $prefix$key$suffix="$( prop_from $key ${froms[@]} )"
  done
}

function --help(){
  case "$1" in
    prop_value ) echo '
Output the value specified in the first parameter of the property from standard input to standard output.

Use:
cat ./file.properties | prop.sh prop_value <key1>
'   ;;
    prop_from ) echo '
Output the value specified in the first parameter of the property from one or more files.

Use:
prop.sh prop_from <key1> <file1> [ <file2> [...]]

If the value is not found in the first specified file or it is empty, then the search is performed in the next one. To read values from environment variables, specify the literal `--env`.
'   ;;
    prop_export ) echo '
Exporting a list of specified keys to environment variables.

Use:
prop.sh prop_export <key1>  [ <key2> [...]] -f <file1> [ <file2> [...]] [ --prefix <prefix> ] [ --suffix <suffix> ]
'   ;;
    *) echo '
Shell script library for reading parameters from `*.properties` files.
Based on the `sed` command.

Use:
prop.sh <command> [ <arg1> [ ... ]]

List of available commands:'
declare -F |cut -d" " -f3|sort|xargs -i echo -e "\t{}"
echo '
To view the help for each command, use:
prop.sh --help <command>
'
    ;;
  esac
}

[ -z "$1" ] || $@
