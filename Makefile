export bin_dir = $(HOME)/.local/bin
export conf_base = $(HOME)/.config
export bash_setup_dir = $(HOME)/.config/bash/setup
export clobber ?= i
dependencies := alacritty bat fzf i3 mpv nnn less rg column perl python lightdm scrot
targets = alacritty bash bat fzf git i3 less mpv nnn readline rg tmux x11

.IGNORE install: check setup_dirs $(targets)
	grep -Fq 'for file in `echo $(bash_setup_dir)/*`; do source $$file; done' ~/.bashrc || echo 'for file in `echo $(bash_setup_dir)/*`; do source $$file; done' >> ~/.bashrc

.PHONY: $(targets)
$(targets):
	${MAKE} -kC $@

.SILENT check:
	echo "Dependencies check:"
	$(foreach var,$(dependencies),output=$$(which $(var) >/dev/null && echo -n '\e[32mOK' || echo '\e[31mnot found'); echo -e "\t- $(var) $$output\e[m"; )

.PHONY: setup_dirs
setup_dirs: $(bin_dir) $(conf_base) $(bash_setup_dir)
	mkdir -p $@
