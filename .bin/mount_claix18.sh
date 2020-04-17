#!/usr/bin/env bash
#
# Mount my home folder on CLAIX18 locally thru SSHFS.

# Mount source and destination paths.
username="de217860"
frontend="copy18-$(($RANDOM % 2 + 1))"
domain="hpc.itc.rwth-aachen.de"
hostname="${frontend}.${domain}"
mount_src="${username}@${hostname}:/work/de217860"
mount_dst="/mnt/claix18"

echo -n "Mounting hostname ${hostname}..."

sshfs \
    -o idmap=user,uid=1000,gid=1000 \
    -o ServerAliveInterval=290 \
    "$mount_src" \
    "$mount_dst"

echo " Done"
