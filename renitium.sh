#!/bin/sh

script_dir="${0%/*}"
. $script_dir/string_utils.sh

config=$1
if [ ! -f "$config" ]; then
    echo "provide a config json file as the first argument!"
    exit 1
fi

user=$(dequote_string "$(cat "$config" | jq '.remote_user')")
host=$(dequote_string "$(cat "$config" | jq '.remote_host')")

data_crypts=$(cat "$config" | jq '.crypts')
crypt_count=$(echo "$data_crypts" | jq '. | length')
crypt_index=0
while [ "$crypt_index" -lt "$crypt_count" ]; do
    crypt=$(echo "$data_crypts" | jq ".[$crypt_index]")
    crypt_index=$((crypt_index + 1))

    crypt_name=$(dequote_string "$(echo "$crypt" | jq .name)")
    crypt_device=$(dequote_string "$(echo "$crypt" | jq .device)")
    crypt_key_path=$(dequote_string "$(echo "$crypt" | jq .key_path)")
    $script_dir/unlock-data-crypt.sh "$user" "$host" "$crypt_key_path" "$crypt_device" "$crypt_name"
done

mounts=$(cat "$config" | jq '.mounts')
mount_count=$(echo "$mounts" | jq '. | length')
mount_index=0
while [ "$mount_index" -lt "$mount_count" ]; do
    mount=$(echo "$mounts" | jq ".[$mount_index]")
    mount_index=$((mount_index + 1))

    mount_path=$(dequote_string "$(echo "$mount" | jq .path)")
    $script_dir/mount-data-device.sh "$user" "$host" "$mount_path"
done

services=$(cat "$config" | jq '.services')
service_count=$(echo "$services" | jq '. | length')
service_index=0
while [ "$service_index" -lt "$service_count" ]; do
    service=$(echo "$services" | jq ".[$service_index]")
    service_index=$((service_index + 1))

    service_name=$(dequote_string "$(echo "$service" | jq .name)")
    $script_dir/start-service.sh "$user" "$host" "$service_name"
done

