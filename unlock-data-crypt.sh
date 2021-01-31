#!/bin/sh

user=$1
host=$2
key_path=$3
device=$4
name=$5

cat $key_path | ssh $user@$host "/sbin/cryptsetup open --type luks --key-file - $device $name"

