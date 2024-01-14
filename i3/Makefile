install:
	-@mkdir -p $(conf_base)/i3
	-@mkdir -p $(conf_base)/i3status
	-@mkdir -p $(conf_base)/dunst
	-@ln -Ts -$(clobber) $$PWD/i3_config $(conf_base)/i3/config
	-@ln -Ts -$(clobber) $$PWD/i3status_config $(conf_base)/i3status/config
	-@ln -Ts -$(clobber) $$PWD/dunstrc $(conf_base)/dunst/dunstrc
	-@ln -Ts -$(clobber) $$PWD/picom.conf $(conf_base)/picom.conf
	-@ln -Ts -$(clobber) $$PWD/tpicom.sh $(conf_base)/tpicom
