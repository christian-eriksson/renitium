# Renitium

Tool to bring up a remote system by unlocking and mounting encrypted drives and start system services.

## Dependencies

You will need to install:

* [jq](https://stedolan.github.io/jq/download/)
* a ssh client (used to connect to the remote system)

## Usage

You will probably want to run the application as root, as cryptkeys are usually only readable by root.

```
./renitium.sh <config.json>
```

## config.json

The config file is a json formatted file pointing out the remote system, encrypted devices, listing services, etc.

```json
{
    "remote_user": "<user_name>",
    "remote_host": "<host_address>",
    "crypts": [
        {
            "name": "<mapper_name>",
            "device": "<path_to_dev>",
            "key_path": "<key_file_path>"
        }
    ],
    "mounts": [
        {
            "path": "<mount_path>"
        }
    ],
    "services": [
        {
            "name": "<service_name>"
        }
    ]
}
```

The user and host is used to connect to the root system, you might want to setup automatic ssh login on the remote system for the local user invoking renitium.

Each crypt object defines the `name` of the mapper for the unlocked crypt, the `device`-path eg. `/dev/disk/by-uuid/...` and the `key_path` as the path to the key-file on the local system.

The mount object holds the `path` to the mount, the mount should be defined in `/etc/fstab` on the remote system.

To start on or multiple systemd services each service object defines the `name` of the service.

