conf_dir=$(conf_base)/ripgrep

install:
	@mkdir -p $(conf_dir)
	@ln -s -i $$PWD/ripgrep.rc $(conf_dir)/ripgrep.rc
	@echo export RIPGREP_CONFIG_PATH=$(conf_dir)/ripgrep.rc > ripgrep.sh
	@ln -s -i $$PWD/ripgrep.sh $(bash_setup_dir)/011_ripgrep.sh


