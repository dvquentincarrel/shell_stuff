install:
	-ln -Ts $(PWD)/xprofile.sh $(HOME)/.xprofile
	-ln -Ts $(PWD)/xinit.sh $(HOME)/.xinitrc
	-ln -Ts $(PWD)/xsession.sh $(HOME)/.xsession
	-ln -Ts $(PWD)/xsession.sh $(HOME)/.xsessionrc
	which lightdm >/dev/null && make install-lightdm || echo "Lightdm not found, skipping"

install-lightdm:
	echo "Adding the lightdm script to properly order screens..."
	sudo cp $(PWD)/lightdm-display-setup-script.sh /etc/lightdm/lightdm-display-setup-script.sh
	echo -e "\e[1;96mAttention!\e[m"
	echo "To complete the installation, you should add the following line inside your '/etc/lightdm/lightdm.conf' file, below the '[LightDM]' line:"
	echo -e '\e[1mdisplay-setup-script = /etc/lightdm/lightdm-display-setup-script.sh\e[m'
