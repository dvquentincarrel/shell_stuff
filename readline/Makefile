conf_dir=$$HOME/.config/readline
bin_dir=$$HOME/.local/bin

install:
	@mkdir -p $(conf_dir)
	@mkdir -p $(bin_dir)
	@ln -s -i $$PWD/inputrc $(conf_dir)/inputrc
	@ln -s -i $$PWD/readline_keybinds.sh $(bin_dir)/readline_keybinds
	@cat ls_colors.sh >> ../composite_sh_setup.sh
