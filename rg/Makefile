conf_dir=$$HOME/.config/ripgrep

install:
	@mkdir -p $(conf_dir)
	@ln -s -i $$PWD/ripgrep.rc $(conf_dir)/ripgrep.rc
	@echo export RIPGREP_CONFIG_PATH=$(conf_dir)/ripgrep.rc >> ../composite_sh_setup.sh
