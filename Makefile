export bin_dir = $${HOME}/.local/bin
export conf_base = $${HOME}/.config
export bash_setup_dir = $${HOME}/.config/bash/setup
export clobber ?= i
dependencies := alacritty bat fzf i3 mpv nnn less rg column perl python 

.SILENT .IGNORE build:
	mkdir -p $(bin_dir)
	mkdir -p $(conf_base)
	mkdir -p $(bash_setup_dir)
	make check
	${MAKE} -kC alacritty
	${MAKE} -kC bash
	${MAKE} -kC bat
	${MAKE} -kC fzf
	${MAKE} -kC git
	${MAKE} -kC i3
	${MAKE} -kC less
	${MAKE} -kC mpv
	${MAKE} -kC nnn
	${MAKE} -kC readline
	${MAKE} -kC rg
	${MAKE} -kC tmux
	grep -Fq 'for file in `echo $(bash_setup_dir)/*`; do source $$file; done' ~/.bashrc || echo 'for file in `echo $(bash_setup_dir)/*`; do source $$file; done' >> ~/.bashrc

check:
	echo "Dependencies check:"
	$(foreach var,$(dependencies),which $(var) >/dev/null && echo "	- $(var) \033[32mOK\033[m" || echo "	- $(var) \033[31mnot found\033[m";)
