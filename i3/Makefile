conf_dir=$$HOME/.config
bin_dir=$$HOME/.local/bin

install:
	@mkdir -p $(conf_dir)/i3
	@mkdir -p $(conf_dir)/dunst
	@ln -s -i $$PWD/i3_config $(conf_dir)/i3/config
	@ln -s -i $$PWD/dunstrc $(conf_dir)/dunst/dunstrc
	@ln -s -i $$PWD/picom.conf $(conf_dir)/picom.conf
	@ln -s -i $$PWD/tpicom.sh $(bin_dir)/tpicom
