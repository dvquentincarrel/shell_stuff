install:
	-ln -Ts $(PWD)/xinit.sh $(HOME)/.xinitrc
	-ln -Ts $(PWD)/xinit.sh $(HOME)/.xprofile
	which lightdm >/dev/null && make install-lightdm || echo "Lightdm not found, skipping"

install-lightdm:
	echo "Adding the lightdm script to properly order screens..."
	sudo cp $(PWD)/lightdm-display-setup-script.sh /etc/lightdm/lightdm-display-setup-script.sh
	echo -e "\e[1;96mAttention!\e[m"
	echo "To complete the installation, you should add the following line inside your '/etc/lightdm/lightdm.conf' file, below the '[LightDM]' line:"
	echo -e '\e[1mdisplay-setup-script = /etc/lightdm/lightdm-display-setup-script.sh\e[m'
