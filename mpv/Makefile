conf_dir=$$HOME/.config/mpv
scripts_dir=$$HOME/.config/mpv/scripts

install:
	@mkdir -p $(scripts_dir)
	@test -f autoload.lua || wget https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/autoload.lua
	@ln -s -i $$PWD/mpv.conf $(conf_dir)/mpv.conf
	@ln -s -i $$PWD/mpv_input.conf $(conf_dir)/input.conf
	@ln -s -i $$PWD/autoload.lua $(scripts_dir)/autoload.lua
	@ln -s -i $$PWD/eq_len.lua $(scripts_dir)/eq_len.lua
