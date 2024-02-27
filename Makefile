export bin_dir = $${HOME}/.local/bin
export conf_base = $${HOME}/.config
export bash_setup_dir = $${HOME}/.config/bash/setup
export clobber ?= i
dependencies := alacritty bat fzf i3 mpv nnn less rg column perl python
targets = alacritty bash bat fzf git i3 less mpv nnn readline rg tmux

.IGNORE build:
	mkdir -p $(bin_dir)
	mkdir -p $(conf_base)
	mkdir -p $(bash_setup_dir)
	make check
	$(foreach target,$(targets), ${MAKE} -kC $(target); )
	grep -Fq 'for file in `echo $(bash_setup_dir)/*`; do source $$file; done' ~/.bashrc || echo 'for file in `echo $(bash_setup_dir)/*`; do source $$file; done' >> ~/.bashrc

.PHONY: $(targets)
$(targets):
	${MAKE} -kC $@

.SILENT check:
	echo "Dependencies check:"
	$(foreach var,$(dependencies),which $(var) >/dev/null && echo "	- $(var) \033[32mOK\033[m" || echo "	- $(var) \033[31mnot found\033[m";)
