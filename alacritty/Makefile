conf_dir=$(conf_base)/alacritty

.SILENT .IGNORE install:
	mkdir -p $(conf_dir)
	ln -Ts -$(clobber) $$PWD/alacritty.yml $(conf_dir)/alacritty.yml
