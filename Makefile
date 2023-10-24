export bin_dir=$${HOME}/.local/bin
export conf_base=$${HOME}/.config
export bash_setup_dir=$${HOME}/.config/bash/setup
export clobber?=i

build:
	@mkdir -p $(bin_dir)
	@mkdir -p $(conf_base)
	@mkdir -p $(bash_setup_dir)
	@make -kC alacritty
	@make -kC bash
	@make -kC fzf
	@make -kC git
	@make -kC i3
	@make -kC less
	@make -kC mpv
	@make -kC nnn
	@make -kC readline
	@make -kC rg
	@make -kC tmux
	@grep -q 'for file in `echo $(bash_setup_dir)/*`; do source $$file; done' ~/.bashrc || echo 'for file in `echo $(bash_setup_dir)/*`; do source $$file; done' >> ~/.bashrc
