set -xe 
# xcode-select --install
# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update && brew upgrade
brew analytics off # turn off analytics

# Update Bash Version on Macs
brew install bash

# Raycast > Mac's Spotlight and like Alfred
brew install --cask raycast

# install spotify for music
brew install --cask spotify

# Better unix tool alternatives (from https://github.com/ibraheemdev/modern-unix) 
### Bat = cat /w syntax highlighting and line numbers
### exa = ls  /w colors + git aware
### delta = diff /w syntax-aware diffs + colors
### duf = du + colors, organization, human readable
### broot = tree /w better organization 
### fd = high performance find /w easier syntax
### ripgrep = high performance + parallel grep
### mcfly = better ctrl-r bash history
### tldr = actually readable man pages
### choose = easier to use cut (sometimes) ... like regex splitting
### bottom = top with more info and graphs. (could also use gtop or glances)
### hyperfine = `time` but better /w parameters for benchmarking commands
### gping = ping /w a graph
### httpie = friendly + more terse curl alternative (curlie is like httpie+curl if that's preferred)
### dog = much nicer than dig command and more detailed
### z = a smart cd that auto-remembers where you went in the past and get you there fast
### gping = like ping with graphs
### font-hack-nerd-font = more glyphs for fonts. 
### gh = for the github cli
brew install bat exa git-delta duf broot fd ripgrep tldr bottom hyperfine gping httpie dog zoxide gping brew choose-rust mcfly font-hack-nerd-font gh

## Install powerline fonts also https://github.com/powerline since some zsh themes use those
(d=$(mktemp -d) && cd "$d" && git clone https://github.com/powerline/fonts.git --depth=1 && cd fonts && ./install.sh && rm -rf "$d")

## Another guide for powerpack zsh installation
# https://github.com/magicdude4eva/iterm-oh-my-zsh-powerlevel10k?tab=readme-ov-file

# Install Rust (and Cargo)
brew install rustup
### this downloads + installs a bunch 
rustup-init --profile default -y 
. "$HOME/.cargo/env" # now reload the cargo path

# Install a ripgrep output-compatible string replace (because sed is a headache sometimes)
#    https://blog.robenkleene.com/2023/12/26/introducing-rep-ren/
cargo install ren-find rep-grep

# pdf grep
brew install pdfgrep

# better bash/general autocomplete
brew install fig

# AST-Grep for some tree-sitting code rewriting
brew install ast-grep

# Easily transfer an encrypted file to another computer via relay 
brew install croc

# Install wireshark for analyzing packets
brew install --cask wireshark # the cli + gui
brew install --cask wireshark-chmodbpf # and additional capture interfaces

# Install iterm2
brew install --cask iterm2

# Install jq and fx for json editing (fx is like interactive jq), gron makes json grep-able
brew install jq fx gron

# Install dasel for JQ/YQ for  JSON, YAML, TOML, XML and CSV with zero runtime dependencies
brew install dasel

# Install VLC
brew install --cask vlc

# Git autocompletion
cp /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash /usr/local/etc/bash_completion.d

# Mac stuff: gnu version of grep and coreutils (e.g. gnuhead); this is because mac's have slightly different versions /w different options shipped.
brew install grep coreutils findutils wget telnet

# also then install moreutils which has vidir and execsnoop (https://jpospisil.com/2023/12/19/the-hidden-gems-of-moreutils)
# but we also want gnu parallel and these break each other (https://superuser.com/questions/545889/how-can-i-install-gnu-parallel-alongside-moreutils)
brew unlink moreutils
brew install parallel
brew link --overwrite moreutils
brew unlink parallel
brew link --overwrite parallel


# Install pipx for installing python "apps"
brew install pipx
pipx ensurepath


# Install "toolong" terminal log viewer (https://github.com/Textualize/toolong)
pipx install toolong



# Mosh > SSH for intermittent connectivity ( *cough* bart)
brew install mosh

# Install rclone
sudo -v ; curl https://rclone.org/install.sh | sudo bash # the brew formula doesn't install the FUSE drivers needed

# Install dos2unix used you have windows line endings accidentally (\r\n) instead of unix (\n)
brew install dos2unix

## Install fzf fuzzy command line searching + auto complete
brew install fzf
$(brew --prefix)/opt/fzf/install

# google sheets editing and also using pandas connector
pip install gspread gspread-pandas

## Install X11 Server to allow X11 Forwarding
brew install --cask xquartz

## Install mac bluetooth cli
brew install blueutil

## Install sshfs to allow mounting remote directories
# this may fail depending on privileges, so you may need to install manually from https://github.com/osxfuse/sshfs/releases
brew install --cask osxfuse && brew install sshfs 

# General Brew Package Installs
brew install wget watch automake iproute2mac bash-completion docker-clean git perl terminal-notifier xclip tmux reattach-to-user-namespace 

# TOP for cpu and for gpu respectively
brew install htop nvtop

# Install git LFS
# Pipenv is yarn for python (optional)
# node = for npm/etc
# esbuild = fast builder for the js ecosystem
brew install git-lfs pipenv esbuild

# install handbrake for video converting (mov->mp4)
# https://handbrake.fr/

# Install bashmarks
pushd .; cd /tmp; git clone https://github.com/huyng/bashmarks.git && cd bashmarks && make install && cd .. && rm -rf bashmarks; popd; 

# Install diff sitter - an AST based diff tool
brew tap afnanenayet/tap
brew install diffsitter

# Weird protobuf you need to decode? Use this
# also website of it: https://mattprecious.github.io/protogram/
brew install mattprecious/repo/protogram

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

# hexyl is a really nice hex data viewer
# there's also ImHex though
brew install hexyl

# Install .bashrc + .vimrc
curl -o ~/.bashrc https://raw.githubusercontent.com/RONNCC/startbox/master/.bashrc
curl -o ~/.vimrc https://raw.githubusercontent.com/RONNCC/startbox/master/.vimrc
curl -o ~/.tmux.conf https://raw.githubusercontent.com/RONNCC/startbox/master/.tmux.conf

# Download git commit message template
curl -o ~/.git-commit-message-template https://raw.githubusercontent.com/RONNCC/startbox/master/.vimrc https://raw.githubusercontent.com/RONNCC/startbox/master/.git-commit-message-template

# Install Vundle and Plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Install git fix-last
curl -o ~/.git-fixlast.sh https://raw.githubusercontent.com/RONNCC/startbox/master/git-fixlast.sh

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# SpyQL is used for data slicing with a SQL/Python mishmash dialect
pip install spyql orjson

###
# Install npm and my onetab syncer because chrome leveldb writes corrupt data, hangs, and then I lose data
###
# install npm / volta
brew install volta
node -v || volta install node
npm install -g @ronncc/onetab-syncer
# Now run it automatically via crontab
crontab -l | { cat; echo $'00 15 * * 1,3,5 osascript -e \'quit app "Chrome"\'; /Users/rghose/.volta/bin/onetab-syncer sync && ( "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"  --restore-last-session > /dev/null &);' ; } | crontab -
