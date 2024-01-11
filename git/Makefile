conf_dir=$(conf_base)/git

install:
	-@mkdir -p $(conf_dir)
	-@ln -s -$(clobber) $$PWD/gitconfig $(conf_dir)/config
	-@ln -s -$(clobber) $$PWD/gitconfig-work $(conf_dir)/config-work
	-@ln -s -$(clobber) $$PWD/gitignore $(conf_dir)/ignore
	-@ln -s -$(clobber) $$PWD/_git_seed $(bin_dir)/_git_seed
	-@ln -s -$(clobber) $$PWD/autocomplete.bash $(bash_setup_dir)/500_git_autocomplete.bash
