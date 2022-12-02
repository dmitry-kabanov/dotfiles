if [[ "$(uname)" == "Darwin" ]]; then
    name=com.dmitrykabanov.sync-archive
    plist=${name}.plist

    osacompile -l JavaScript -o  ${name}.app ${name}.js

    src=$HOME/.launchd/sync-archive
    target=$HOME/Library/LaunchAgents
    sed -e "s|workdir|${src}|" "${src}/${plist}" >"${target}/${plist}"
    launchctl load "${target}/${plist}"
else
    echo "Not macOS"
fi
