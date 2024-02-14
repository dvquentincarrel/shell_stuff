conf_dir=$(conf_base)/mpv
scripts_dir=$(conf_dir)/scripts

.SILENT .IGNORE install:
	mkdir -p $(scripts_dir)
	test -f autoload.lua || wget https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/autoload.lua
	ln -Ts -$(clobber) $$PWD/mpv.conf $(conf_dir)/mpv.conf
	ln -Ts -$(clobber) $$PWD/mpv_input.conf $(conf_dir)/input.conf
	ln -Ts -$(clobber) $$PWD/autoload.lua $(scripts_dir)/autoload.lua
	ln -Ts -$(clobber) $$PWD/eq_len.lua $(scripts_dir)/eq_len.lua
