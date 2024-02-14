conf_dir=$(conf_base)/ripgrep

.SILENT .IGNORE install:
	mkdir -p $(conf_dir)
	ln -Ts -$(clobber) $$PWD/ripgrep.rc $(conf_dir)/ripgrep.rc
	ln -Ts -$(clobber) $$PWD/ripgrep.bash $(bash_setup_dir)/011_ripgrep.bash
