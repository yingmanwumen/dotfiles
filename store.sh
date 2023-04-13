#!/usr/bin/bash

mkdir -p ./bash
mkdir -p ./config

cp ~/.bashrc ./bash
cp -r ~/.config/kitty ./config
cp -r ~/.config/starship.toml ./config
