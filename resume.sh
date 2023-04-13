#!/usr/bin/bash

# backup
mv ~/.bashrc ~/.bashrc.bak
mv ~/.config/kitty ~/.config/kitty.bak
mv ~/.config/starship.toml ~/.config/starship.toml.bak

cp ./bash/.bashrc ~/.bashrc
cp -r ./config/kitty ~/.config/kitty
cp -r ./config/starship.toml ~/.config/starship.toml
