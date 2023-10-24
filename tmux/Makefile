conf_dir=$(conf_base)/tmux

install:
	@mkdir -p $(conf_dir)
	@mkdir -p $(bin_dir)
	@ln -s -i $$PWD/tmux.conf $(conf_dir)/tmux.conf
	@ln -s -i $$PWD/notmux.sh $(bin_dir)/notmux
	@ln -s -i $$PWD/auto_tmux.sh $(bash_setup_dir)/012_auto_tmux.sh
