#!/usr/bin/env zsh

echo Task "Sync archive" starts at $(date "+%y-%m-%d %H.%M.%S")
# Trailing slashes are important as they point to the children of the paths.
source $HOME/.zshrc-local
echo "PATH_ARCHIVE_SRC = $PATH_ARCHIVE_SRC"
echo "PATH_ARCHIVE_DEST = $PATH_ARCHIVE_DEST"
echo "Sync this: "
ls -al "$PATH_ARCHIVE_SRC"
rsync -avz "$PATH_ARCHIVE_SRC" "$PATH_ARCHIVE_DEST"

if [[ $? -eq 0 ]]; then
    echo "success"
else
    echo "fail"
fi
