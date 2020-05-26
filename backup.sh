#!/bin/bash
set -e
source .env
access_key=$AZURE_STORAGE_BACKUPS_ACCESS_KEY
account_name=$AZURE_STORAGE_BACKUPS_ACCOUNT_NAME
environment=$ENVIRONMENT

usage () {
    printf "*********\n";
    printf "* This script creates a tarball of the data_dir and uploads it to azure blob storage backups\\n"
    printf "* Usage:./backup.sh or ./backup.sh -d for a dry run\n";
    printf "*********\n";
}

options='dhp:'

while getopts $options opt; do
  case $opt in
    d  ) arg_1="--dryrun"; printf "Uploading in $arg_1 mode...\n\n" ;;
    h  ) usage; exit;;
    \? ) echo "Unknown option: -$OPTARG" >&2; exit 1;;
    :  ) echo "Missing option argument for -$OPTARG" >&2; exit 1;;
    *  ) echo "Unimplemented option: -$OPTARG" >&2; exit 1;;
  esac
done
date=$(date +"%Y-%m-%d-%H-%M")
FILENAME="${environment}-data_dir_${date}.tar.gz"
echo $access_key
echo $account_name

echo $FILENAME

rm -rf ${environment}-data_dir_*
tar czvf $FILENAME ./data_dir

az storage blob upload-batch --account-key $access_key --account-name \
$account_name -d geoserver-backups -s . --pattern $FILENAME $arg_1
rm -rf $FILENAME
