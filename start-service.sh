#!/bin/sh

user=$1
host=$2
service_name=$3

ssh $user@$host "systemctl start $service_name"

