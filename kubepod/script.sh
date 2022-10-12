#! /bin/bash

apt update -y && apt install -y vim git 

cp ./.vimrc $HOME/.vimrc
cp ./.bashrc $HOME/.bashrc
cp ./.bash_aliases $HOME/.bash_aliases

git clone https://github.com/tomasiser/vim-code-dark.git
mkdir -p ~/.vim/colors
mv ./vim-code-dark/colors/codedark.vim ~/.vim/colors/
