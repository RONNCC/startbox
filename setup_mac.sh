xcode-select --install
# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update && brew upgrade

# Update Bash Version on Macs
brew install bash

# Git autocompletion
cp /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash /usr/local/etc/bash_completion.d

# Mac stuff: gnu version of grep; 
brew install grep

## Install fzf fuzzy command line searching + auto complete
brew install fzf
$(brew --prefix)/opt/fzf/install

## Install mac bluetooth cli
brew install blueutil

# General Brew Package Installs
brew install wget watch automake iproute2mac bash-completion docker-clean git perl terminal-notifier xclip tmux reattach-to-user-namespace

# Install bashmarks
git clone git://github.com/huyng/bashmarks.git && cd bashmarks && make install && cd .. && rm -rf bashmarks

# SIMD ripgrep
brew tap burntsushi/ripgrep https://github.com/BurntSushi/ripgrep.git
brew install burntsushi/ripgrep/ripgrep-bin

# Install diff-so-fancy
brew install diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global color.ui true
git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"
git config --global color.diff.meta       "yellow"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"

### optional ###
# install hexyl: https://github.com/sharkdp/hexyl

# Install .bashrc + .vimrc
curl -o ~/.bashrc https://raw.githubusercontent.com/RONNCC/startbox/master/.bashrc
curl -o ~/.vimrc https://raw.githubusercontent.com/RONNCC/startbox/master/.vimrc

# Install Vundle Plugins
vim +PluginInstall +qall

# Install git fix-last
curl -o ~/.git-fixlast.sh https://raw.githubusercontent.com/RONNCC/startbox/master/git-fixlast.sh

