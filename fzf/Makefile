.SILENT .IGNORE build:
	ln -Ts -$(clobber) $$PWD/env_vars.sh $(bash_setup_dir)/006_env_vars.sh
	ln -Ts -$(clobber) $$PWD/functions.sh $(bash_setup_dir)/007_functions.sh
	ln -Ts -$(clobber) $$PWD/fzf_preview.bash $(bin_dir)/fzf_preview.bash
	wget --no-clobber -O $(bash_setup_dir)/999_fzf_keybinds https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.bash
