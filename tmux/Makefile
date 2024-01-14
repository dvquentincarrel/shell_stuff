conf_dir=$(conf_base)/tmux

install:
	-@mkdir -p $(conf_dir)
	-@mkdir -p $(bin_dir)
	-@ln -Ts -$(clobber) $$PWD/tmux.conf $(conf_dir)/tmux.conf
	-@ln -Ts -$(clobber) $$PWD/notmux.sh $(bin_dir)/notmux
	-@ln -Ts -$(clobber) $$PWD/auto_tmux.sh $(bash_setup_dir)/012_auto_tmux.sh
