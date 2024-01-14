conf_dir=$(conf_base)/readline

install:
	-@mkdir -p $(conf_dir)
	-@mkdir -p $(bin_dir)
	-@ln -Ts -$(clobber) $$PWD/inputrc $(conf_dir)/inputrc
	-@ln -Ts -$(clobber) $$PWD/readline_keybinds.sh $(bin_dir)/readline_keybinds
	-@ln -Ts -$(clobber) $$PWD/ls_colors.sh $(bash_setup_dir)/010_ls_colors.sh
