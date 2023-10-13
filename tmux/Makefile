conf_dir=$$HOME/.config/tmux
bin_dir=$$HOME/.local/bin

install:
	@mkdir -p $(conf_dir)
	@mkdir -p $(bin_dir)
	@ln -s -i $$PWD/tmux.conf $(conf_dir)/tmux.conf
	@ln -s -i $$PWD/notmux.sh $(bin_dir)/notmux
	@cat auto_tmux.sh >> ../composite_sh_setup.sh
