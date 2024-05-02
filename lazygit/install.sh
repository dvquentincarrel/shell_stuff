#!/bin/sh
dependencies="lazygit"
configs="config.yml"

lazygit_conf_dir="$HOME/.config/lazygit"

mkdir -p "$lazygit_conf_dir"

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "To install the files, run:"
    echo "\t./install.sh"
    echo "To uninstall the files, run:"
    echo "\t./install.sh -u"
    exit 0
elif [ "$1" = "-u" ]; then
    mode=uninstall
    operation=Uninstalling
else
    mode=install
    operation=Installing
fi

echo "Dependencies check:"
for dependency in $dependencies; do
    which $dependency >/dev/null && output='\e[32mOK' || output='\e[31mnot found' 
    echo -e "    $dependency $output\e[m"
done

echo "$operation configs..."
for config in $configs; do
    if [ $mode = "uninstall" ]; then
        rm "$lazygit_conf_dir/$config"
    elif ! [ -e "$lazygit_conf_dir/$config" ]; then
        ln -Ts "$PWD/$config" "$lazygit_conf_dir/$config"
    fi
done

