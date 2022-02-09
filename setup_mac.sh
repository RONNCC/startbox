set -xe 
# xcode-select --install
# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update && brew upgrade
brew analytics off # turn off analytics

# Update Bash Version on Macs
brew install bash

# Install iterm2
brew install --cask iterm2

# Install jq and fx for json editing
brew install jq fx

# Git autocompletion
cp /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash /usr/local/etc/bash_completion.d

# Mac stuff: gnu version of grep and coreutils (e.g. gnuhead)
brew install grep coreutils findutils wget telnet

# Mosh > SSH for intermittent connectivity ( *cough* bart)
brew install mosh

# install interactive jq
brew install jiq

# Install rclone
brew install rclone 

# Install dos2unix used you have windows line endings accidentally (\r\n) instead of unix (\n)
brew install dos2unix

## Install fzf fuzzy command line searching + auto complete
brew install fzf
$(brew --prefix)/opt/fzf/install

## Install X11 Server to allow X11 Forwarding
brew cask install xquartz

## Install mac bluetooth cli
brew install blueutil

## Install sshfs to allow mounting remote directories
# this may fail depending on privileges, so you may need to install manually from https://github.com/osxfuse/sshfs/releases
brew cask install osxfuse && brew install sshfs 

# General Brew Package Installs
brew install wget watch automake iproute2mac bash-completion docker-clean git perl terminal-notifier xclip tmux reattach-to-user-namespace htop

# Pipenv is yarn for python (optional)
brew install pipenv

# Install bashmarks
git clone git://github.com/huyng/bashmarks.git && cd bashmarks && make install && cd .. && rm -rf bashmarks

# Install diff sitter - an AST based diff tool
brew tap afnanenayet/tap
brew install diffsitter

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

# Download git commit message template
curl -o ~/.git-commit-message-template https://raw.githubusercontent.com/RONNCC/startbox/master/.vimrc https://raw.githubusercontent.com/RONNCC/startbox/master/.git-commit-message-template

# Install Vundle and Plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Install git fix-last
curl -o ~/.git-fixlast.sh https://raw.githubusercontent.com/RONNCC/startbox/master/git-fixlast.sh



###
# Install npm and my onetab syncer because chrome leveldb writes corrupt data, hangs, and then I lose data
###
# install npm / volta
brew install volta
node -v || volta install node
npm install -g @ronncc/onetab-syncer
# Now run it automatically via crontab
crontab -l | { cat; echo $'00 15 * * 1,3,5 osascript -e \'quit app "Chrome"\'; /Users/rghose/.volta/bin/onetab-syncer sync && ( "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"  --restore-last-session > /dev/null &);' ; } | crontab -
