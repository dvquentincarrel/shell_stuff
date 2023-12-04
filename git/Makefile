conf_dir=$(conf_base)/git

install:
	-@mkdir -p $(conf_dir)
	-@ln -s -$(clobber) $$PWD/gitconfig $(conf_dir)/config
	-@ln -s -$(clobber) $$PWD/gitconfig-work $(conf_dir)/config-work
	-@ln -s -$(clobber) $$PWD/gitignore $(conf_dir)/ignore
