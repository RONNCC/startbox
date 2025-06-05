# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

unameOut="$(uname -s)"	
case "${unameOut}" in	
    Linux*)     machine=Linux;;	
    Darwin*)    machine=Mac;;	
    CYGWIN*)    machine=Cygwin;;	
    MINGW*)     machine=MinGw;;	
    *)          machine="UNKNOWN:${unameOut}"	
esac	
echo "Running on ${machine}"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
export CLICOLOR=1

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'
alias less='less -r' # enable less with color support

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
    # if not found in /usr/local/etc, try the brew --prefix location
    [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
        . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
}
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# Make ls use colors
# define colors
C_DEFAULT="\[\033[m\]"
C_WHITE="\[\033[1m\]"
C_BLACK="\[\033[30m\]"
C_RED="\[\033[31m\]"
C_GREEN="\[\033[32m\]"
C_YELLOW="\[\033[33m\]"
C_BLUE="\[\033[34m\]"
C_PURPLE="\[\033[35m\]"
C_CYAN="\[\033[36m\]"
C_LIGHTGRAY="\[\033[37m\]"
C_DARKGRAY="\[\033[1;30m\]"
C_LIGHTRED="\[\033[1;31m\]"
C_LIGHTGREEN="\[\033[1;32m\]"
C_LIGHTYELLOW="\[\033[1;33m\]"
C_LIGHTBLUE="\[\033[1;34m\]"
C_LIGHTPURPLE="\[\033[1;35m\]"
C_LIGHTCYAN="\[\033[1;36m\]"
C_BG_BLACK="\[\033[40m\]"
C_BG_RED="\[\033[41m\]"
C_BG_GREEN="\[\033[42m\]"
C_BG_YELLOW="\[\033[43m\]"
C_BG_BLUE="\[\033[44m\]"
C_BG_PURPLE="\[\033[45m\]"
C_BG_CYAN="\[\033[46m\]"
C_BG_LIGHTGRAY="\[\033[47m\]"
# set your prompt
export PS1="$C_LIGHTGREEN\u$C_DARKGRAY@$C_BLUE\h:\w$C_DARKGRAY\$$C_DEFAULT "



alias network='slurm -i venet0'
 # ntop uses 3000
export TERM=screen-256color
shopt -s globstar
export LC_COLLATE=C
source ~/.local/bin/bashmarks.sh
makec()
{
  pathpat="(/[^/]*)+:[0-9]+"
  ccred=$(echo -e "\033[0;31m")
  ccyellow=$(echo -e "\033[0;33m")
  ccend=$(echo -e "\033[0m")
  /usr/bin/make "$@" 2>&1 | sed -E -e "/[Ee]rror[: ]/ s%$pathpat%$ccred&$ccend%g" -e "/[Ww]arning[: ]/ s%$pathpat%$ccyellow&$ccend%g"
  return ${PIPESTATUS[0]}
}
export CSCOPE_DB=/home/sghose/co/router/cscope.out
alias ssh='ssh -A'
export GOPATH=$HOME/privScripts
export PATH=$PATH:$GOPATH/bin:/Users/rghose/Library/Python/3.7/bin:/Users/rghose/Library/Python/3.8/bin
export ANSIBLE_COW_SELECTION=none

if hash ag 2>/dev/null; then
  tag() { command tag "$@"; source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null; }
  alias tag=tag
fi
alias note="nc termbin.com 9999"

transfer() {
if [ $# -eq 0 ]; then
    echo "Usage: transfer FILE [DURATION]\n"
    echo "Example: transfer path/to/my/file\n"
    exit 1
fi
echo $(curl "https://bashupload.com/$1" --data-binary @$1)
}

#rename remote branch with __old prepended and delete local branch
gitarchive()
{
    if [ -z "$1" ]
          then
              echo "No argument supplied"
              return
    fi
    echo "ARCHIVING $1"
    archived_name="__old_"$1
    git push gitrepo $1":"$archived_name
    git push gitrepo ":"$1
    git branch -d $1
}

fixssh() {
        eval $(tmux show-env    \
            |sed -n 's/^\(SSH_[^=]*\)=\(.*\)/export \1="\2"/p')
}

man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}

#export GOROOT=/usr/local/Cellar/go/1.9/bin
export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec
export GIT_HOME=/usr/local/
export PATH=${GIT_HOME}/bin:$PATH:$GOPATH/bin:$GOROOT/bin:/usr/local/linkedin/bin/
export GPG_TTY=$(tty)

alias kb="kubectl"
alias kbc="kubectl --kubeconfig"

alias pruneOldBranches='git fetch --prune --all'
alias dockerimgsrepofmt='docker images --format "{{.Repository}}:{{.Tag}}"'

if [ ${machine} = "Mac" ]; then	alias macnotifsound='terminal-notifier -sound default -message'
    alias notifsound='terminal-notifier -sound default -message'
    alias notif='terminal-notifier -message'	
elif [ ${machine} = "Linux" ]; then	
    alias notif='notify-send'	
fi

alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'

# make python use mac certifi certifs on requests. also this makes LI stuff break...
#CERT_PATH=$(python -m certifi)
#export SSL_CERT_FILE=${CERT_PATH}
#export REQUESTS_CA_BUNDLE=${CERT_PATH}

alias aspellHtml='aspell check -H --run-together --run-together-limit=4 --ignore-case -d en_US'
alias rga='rg --no-ignore --hidden --follow'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export NODE_OPTIONS="--max-old-space-size=8192" # there so node doesnt run out of memory

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export EDITOR='subl -w'

alias movToMp4='ls *.mov |  xargs -L1 -I{}  basename {} .mov  | xargs -P2 -L1 -I{} ffmpeg -i {}.mov -vcodec h264 -acodec mp2  -crf 20 {}.mp4'
smallerGif()
{
    if [ -z "$1" ]
          then
              echo "No argument supplied"
              return
    fi
    basename $1 .gif | xargs -I{} convert {}.gif -fuzz 2% +dither -layers Optimize +map   {}_smaller.gif
}
alias restartWifi='sudo ifconfig en0 down; sleep 5; sudo ifconfig en0 up; sleep 5; sudo ifconfig en0 down; sleep 5; sudo ifconfig en0 up;'
restartBluetooth(){
    sudo kill `ps -ax | grep "coreaudiod" | grep "sbin" |awk '{print $1}'`;
    sudo blueutil -p 0; sleep 5; sudo blueutil -p 1; sleep 5; sudo blueutil -p 0; sleep 5; sudo blueutil -p 1
}
smallerPdf()
{
    if [ -z "$1" ]
          then
              echo "No argument supplied"
              return
    fi
    basename -s .pdf "$1" | xargs -I{} gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4  -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="{}_small.pdf" {}.pdf
}

export -f MP-runWCTests
export -f MP-gitReviewCreate
# strip ansi codes before pasting
alias pasteit='sed "s/\x1b\[[0-9;]*m//g" | pasteit'

# fix pep8 errors
alias fixpep8='autopep8 --in-place --aggressive '

# get largest files/directories
alias ducks='du -hs * | sort -rh | head -10'
alias mullvad_filter="uv run https://gist.githubusercontent.com/RONNCC/740d1039986e5b9fe7397fb31a59a101/raw/bd7815829753db6767f4c2a482744a67f06c6b03/mulvad-filter.py"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
