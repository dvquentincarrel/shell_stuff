export PATH=~/.local/bin:$PATH
export MACHINE="unknown" # Default value
# Makes an id out of subset of public ssh key
if [ -f ~/.ssh/id_rsa.pub ]; then
	id=$(cut ~/.ssh/id_rsa.pub -c 50-53)
	if [ "$id" = "jADy" ]; then
		export MACHINE="local"
		export COMPOSITOR="picom"
        export WALLPAPERS="/mnt/storage/pictures/Wallpaper/"
        export QBL_ASYNC=false
		xrandr --output HDMI-0 --primary --left-of DP-1
	elif [ "$id" = "bKTX" ]; then
		export MACHINE="opi"
		export COMPOSITOR="compton"
        export PATH=/home/quentin/opi_repo:$PATH
		xrandr --output eDP-1 --primary
		xrandr --output HDMI-1 --left-of eDP-1
		xrandr --auto
		#xinput set-prop "Raydium Corporation Raydium Touch System" "Device Enabled" 0
	fi
fi

export FOTM_TERM="alacritty"
export WINIT_X11_SCALE_FACTOR=1

xset r rate 250 50 # delay, rate
setxkbmap fr
#comfy
#redshift
