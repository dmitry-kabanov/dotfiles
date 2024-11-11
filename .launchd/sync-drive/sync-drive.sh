#!/usr/bin/env zsh

set -o pipefail

dir=$(realpath $(dirname $0))
logfile=${dir}/rsync.log

echo Task "Sync drive" starts at $(date "+%y-%m-%d %H.%M.%S")
# Trailing slash on SRC directory is important
# as it points to the files inside this directory.
# Exclude directories are from https://apple.stackexchange.com/q/376521/246355
rsync -avz --hard-links --delete \
    --exclude=.Spotlight-V100 \
    --exclude=.fseventsd \
    --exclude=.DocumentRevisions-V100 \
    --exclude=.TemporaryItems \
    --exclude=.Trashes \
    --exclude=.PKInstallSandboxManager \
    --exclude=.PKInstallSandboxManager-SystemSoftware \
    --exclude=.DS_Store \
    --exclude='._*' \
    /Volumes/T7-APFS/ \
    /Volumes/T7S-T7Backup/ \
    2>&1 | tee ${logfile}


code=$?
echo "Exit code $code"
if [[ $code -eq 0 ]]; then
    echo "success"
else
    echo "fail"
fi
