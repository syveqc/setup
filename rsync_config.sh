#!/bin/bash

# do this one by one, as borgmatic should not be synced as keys are not in the repo
rsync -uav .config/nvim ~/.config
rsync -uav .config/i3 ~/.config
rsync -uav .config/kitty ~/.config

rsync -uv .zshrc ~
rsync -uv .p10k.zsh ~
