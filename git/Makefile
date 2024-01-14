conf_dir=$(conf_base)/git

install:
	-@mkdir -p $(conf_dir)
	-@ln -Ts -$(clobber) $$PWD/gitconfig $(conf_dir)/config
	-@ln -Ts -$(clobber) $$PWD/gitconfig-work $(conf_dir)/config-work
	-@ln -Ts -$(clobber) $$PWD/gitignore $(conf_dir)/ignore
	-@ln -Ts -$(clobber) $$PWD/_git_seed $(bin_dir)/_git_seed
	-@ln -Ts -$(clobber) $$PWD/autocomplete.bash $(bash_setup_dir)/500_git_autocomplete.bash
