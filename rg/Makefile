conf_dir=$(conf_base)/ripgrep

install:
	@mkdir -p $(conf_dir)
	@echo export RIPGREP_CONFIG_PATH=$(conf_dir)/ripgrep.rc > ripgrep.sh
	@ln -s -$(clobber) $$PWD/ripgrep.rc $(conf_dir)/ripgrep.rc
	@ln -s -$(clobber) $$PWD/ripgrep.sh $(bash_setup_dir)/011_ripgrep.sh
