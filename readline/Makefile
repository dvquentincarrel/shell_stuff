conf_dir=$(conf_base)/readline

install:
	@mkdir -p $(conf_dir)
	@mkdir -p $(bin_dir)
	@ln -s -i $$PWD/inputrc $(conf_dir)/inputrc
	@ln -s -i $$PWD/readline_keybinds.sh $(bin_dir)/readline_keybinds
	@ln -s -i $$PWD/ls_colors.sh $(bash_setup_dir)/010_ls_colors.sh
