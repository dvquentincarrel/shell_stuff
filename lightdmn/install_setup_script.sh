#!/bin/env bash
if [[ $EUID -ne 0 ]]; then
    echo "The script must be run as root"
    exit 1
fi

echo "Adding the lightdm script to properly order screens..."
cp $PWD/lightdm-display-setup-script.sh /etc/lightdm/lightdm-display-setup-script.sh
if grep -qF 'display-setup-script = /etc/lightdm/lightdm-display-setup-script.sh' /etc/lightdm/lightdm.conf; then
    echo "Script already used in the config file"
    exit 0
fi

if grep -qE '^ *display-setup-script ?= ?' /etc/lightdm/lightdm.conf; then
    printf "There is already a display-setup-script set somewhere in the config file\n"
    printf "In the file:\n"
    printf "\x1b[96m/etc/lightdm/lightdm.conf\x1b[m\n"
    printf "please add the following line inside the [LightDM] section:\n"
    printf "\x1b[96mdisplay-setup-script = /etc/lightdm/lightdm-display-setup-script.sh\n\x1b[m"
    exit 1
fi

echo "Inserting the relevant line inside /etc/lightdm/lightdm.conf ..."
sed -i 's;\[LightDM\];&\ndisplay-setup-script = /etc/lightdm/lightdm-display-setup-script.sh;' /etc/lightdm/lightdm.conf
