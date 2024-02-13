export bin_dir=$${HOME}/.local/bin
export conf_base=$${HOME}/.config
export bash_setup_dir=$${HOME}/.config/bash/setup
export clobber?=i

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
	dependencies := alacritty bat fzf i3 mpv nnn less rg column perl python 
	echo "Dependencies check:"
	$(foreach var,$(dependencies),which $(var) >/dev/null && echo "	$(var) OK" || echo "	- $(var) not found" )
	#which alacritty >/dev/null && echo || echo "	- alacritty not found" 
	#which bat batcat >/dev/null || echo "	 - bat not found"
	#which fzf >/dev/null || echo "	 - fzf not found"
	#which i3 >/dev/null || echo "	 - i3 not found"
	#which mpv >/dev/null || echo "	 - mpv not found"
	#which nnn >/dev/null || echo "	 - nnn not found"
	#which less >/dev/null || echo "	 - less not found"
	#which rg >/dev/null || echo "	 - ripgrep not found"
	#which column >/dev/null || echo "	 - column not found"
	#which perl >/dev/null || echo "	 - perl not found"
	#which python >/dev/null || echo "	 - python not found"


