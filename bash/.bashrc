# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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

source "$HOME/.cargo/env" # for cargo
source /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh   # for virtualenvwrapper

eval "$(zoxide init bash)"      # zoxide
eval "$(starship init bash)"    # starship

export BAT_THEME=zenburn        # bat theme
export WORKON_HOME="/home/ymwm/.local/share/venv" # for virtualenvwrapper
export GOPATH=$HOME/.go # go path
export PATH=$PATH:$GOPATH/bin # go path
export EDITOR=vim
export HSTR_CONFIG="hicolor;regexp-matching"
export HSTR_PROMPT='-> '

hstr_matches() {
	history -a; history -n; hstr -- $@
}

bind '"\C-r":"\C-a hstr_matches \C-j"'
bind '"\e[Z":menu-complete-backward'    # SHIFT-TAB for backward completion
bind 'set colored-completion-prefix on' # colored completion prefix
bind 'set colored-stats on'             # colored stats
bind 'set completion-ignore-case on'    # ignore case when completing
bind 'set show-all-if-ambiguous on'     # show all matches on ambiguous completion
bind 'TAB:menu-complete'                # TAB for completion

alias ip='ip -color'

alias ls='exa --grid --color auto --icons --sort=type'
alias ll='exa --long --color auto --icons --sort=type'
alias la='exa --grid --all --color auto --icons --sort=type'
alias l='ls -F'
alias tree='exa -T --icons --sort=type'

alias cd='z'
alias ..='cd ..'

alias aptup='sudo aptitude update\
	&& sudo aptitude upgrade\
	&& sudo aptitude autoclean'

alias rm='trash-put'
alias te='trash-empty'
alias rr='trash-restore'

alias vim='nvim'
alias v='vim'
alias vi='vim --clean'

alias please='sudo'

disable-AT-kayboard() {
xinput list\
	| grep AT\
	| egrep -o "id=[0-9]*"\
	| egrep -o "[0-9]*"\
	| xargs xinput disable;
}

enable-AT-kayboard() {
xinput list\
	| grep AT\
	| egrep -o "id=[0-9]*"\
	| egrep -o "[0-9]*"\
	| xargs xinput enable;
}

cmake-build() {
if [[ ! -d build ]]; then
	cmake -S. -Bbuild -GNinja -DCMAKE_BUILD_TYPE=Debug
	cmake --build build
fi
ninja -C build
}

cmake-release() {
	if [[ -d build ]]; then
		rm -rf build
	fi
	cmake -S. -Bbuild -GNinja -DCMAKE_BUILD_TYPE=Release
	ninja -C build
}

neofetch -L | lolcat
