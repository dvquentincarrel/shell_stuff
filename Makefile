export bin_dir=$${HOME}/.local/bin
export conf_base=$${HOME}/.config
export bash_setup_dir=$${HOME}/.config/bash/setup
export clobber?=i

build:
	@mkdir -p $(bin_dir)
	@mkdir -p $(conf_base)
	@mkdir -p $(bash_setup_dir)
	@${MAKE} -kC alacritty
	@${MAKE} -kC bash
	@${MAKE} -kC bat
	@${MAKE} -kC fzf
	@${MAKE} -kC git
	@${MAKE} -kC i3
	@${MAKE} -kC less
	@${MAKE} -kC mpv
	@${MAKE} -kC nnn
	@${MAKE} -kC readline
	@${MAKE} -kC rg
	@${MAKE} -kC tmux
	@grep -Fq 'for file in `echo $(bash_setup_dir)/*`; do source $$file; done' ~/.bashrc || echo 'for file in `echo $(bash_setup_dir)/*`; do source $$file; done' >> ~/.bashrc
