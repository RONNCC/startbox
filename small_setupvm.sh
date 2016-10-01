#!/bin/sh
#run in usr home dir // assumes apt

sudo apt-get update
sudo apt-get -y install tmux build-essential 

# install bashmarks
git clone git://github.com/huyng/bashmarks.git
cd bashmarks
make install
echo "source ~/.local/bin/bashmarks.sh" >> ~/.bashrc
cd ..
rm -rf bashmarks

##install vim/tmux package managers
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

wget https://raw.githubusercontent.com/RONNCC/startbox/master/git-completion.bash
wget https://raw.githubusercontent.com/RONNCC/startbox/master/.vimrc
wget https://raw.githubusercontent.com/RONNCC/startbox/master/.tmux.conf
wget https://raw.githubusercontent.com/RONNCC/startbox/master/.gitconfig
wget https://raw.githubusercontent.com/RONNCC/startbox/master/.bashrc
