bin_dir=$$HOME/.local/bin

build:
	@mkdir -p $(bin_dir)
	@echo '#!/bin/bash' > composite_sh_setup.sh
	@chmod +x composite_sh_setup.sh
	@make -kC alacritty
	@make -kC bash
	@make -kC fzf
	@make -kC git
	@make -kC i3
	@make -kC less
	@make -kC mpv
	@make -kC nnn
	@make -kC readline
	@make -kC tmux
	@ln -s -i $$PWD/composite_sh_setup.sh $(bin_dir)/composite_sh_setup
	@grep -q 'source composite_sh_setup' ~/.bashrc || echo 'source composite_sh_setup' >> ~/.bashrc
