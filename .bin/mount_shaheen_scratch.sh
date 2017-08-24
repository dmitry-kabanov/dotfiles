#!/usr/bin/env bash
sshfs \
    kabanod@shaheen.hpc.kaust.edu.sa:/scratch/kabanod \
    $HOME/shaheen-scratch \
    -o idmap=user,uid=1000,gid=1000
