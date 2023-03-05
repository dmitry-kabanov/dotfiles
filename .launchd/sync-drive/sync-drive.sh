#!/usr/bin/env zsh

dir=$(realpath $(dirname $0))
logfile=${dir}/rsync.log

echo Task "Sync drive" starts at $(date "+%y-%m-%d %H.%M.%S")
# Trailing slash on SRC directory is important
# as it points to the files inside this directory.
rsync -avz --hard-links --delete \
    --exclude=.DocumentRevisions-V100 \
    --exclude=.Spotlight-V100 \
    --exclude=.TemporaryItems \
    --exclude=.Trashes \
    --exclude=.fseventsd \
    --exclude='._*' \
    /Volumes/T7-APFS/ \
    /Volumes/T7S-T7Backup/ \
    2>&1 | tee ${logfile}


if [[ $? -eq 0 ]]; then
    echo "success"
else
    echo "fail"
fi
