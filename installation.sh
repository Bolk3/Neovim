#!/bin/bash

set -e

if [ -d ~/.config/nvim ]; then
	mv ~/.config/nvim ~/.config/nvim.bak.$(date +%s)
fi
git clone https://github.com/Bolk3/Neovim.git nvim

while true; do
	read -p "Are you a 42 student? Y/N: " FT_QUEST < /dev/tty
	case ${FT_QUEST,,} in
		yes | y)	FT_STUD=1; break;;
		no | n)		FT_STUD=0; break;;
		*)		echo "not a valid anser";;
	esac
done

if [ $FT_STUD -eq 1 ]; then
	read -p "username: " FT_USER < /dev/tty
	read -p "mail: " FT_MAIL < /dev/tty
	{
		echo "FT_USER=${FT_USER}"
		echo "FT_MAIL=${FT_MAIL}"
	} >> ~/.config/nvim/.env
fi
