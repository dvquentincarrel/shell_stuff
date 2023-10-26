conf_dir=$(conf_base)/ripgrep

install:
	@mkdir -p $(conf_dir)
	@ln -s -$(clobber) $$PWD/ripgrep.rc $(conf_dir)/ripgrep.rc
	@ln -s -$(clobber) $$PWD/ripgrep.bash $(bash_setup_dir)/011_ripgrep.bash
