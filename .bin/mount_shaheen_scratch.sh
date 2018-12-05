#!/usr/bin/env bash
#
# Mount Shaheen scratch folder locally thru SSHFS.

# Mount source and destination paths.
mount_src="kabanod@shaheen.hpc.kaust.edu.sa:/scratch/kabanod"
mount_dst="$HOME/shaheen-scratch"

sshfs \
    -o idmap=user,uid=1000,gid=1000 \
    -o ServerAliveInterval=240 \
    "$mount_src" \
    "$mount_dst"
