#!/bin/sh

user=$1
host=$2
mount_path=$3

ssh $user@$host "[ ! -e $mount_path ] && mkdir $mount_path ; mount $mount_path"

