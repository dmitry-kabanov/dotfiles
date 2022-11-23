if [[ "$(uname)" == "Darwin" ]]; then
    name=com.dmitrykabanov.sync-archive.plist
    src=$HOME/.launchd/sync-archive
    target=$HOME/Library/LaunchAgents

    sed -e "s|workdir|${src}|" "${src}/${name}" >"${target}/${name}"
    launchctl load "${target}/${name}"
else
    echo "Not macOS"
fi
