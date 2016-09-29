# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# eval `dircolors $HOME/.config/dircolors/dircolors.ansi-universal`

source $HOME/.bash_config

shopt -s cdspell        # This will correct minor spelling errors in a cd command.
shopt -s histappend     # Append to history rather than overwrite
shopt -s dotglob        # Files beginning with . to be returned in the results of path-name expansion.
shopt -s nocaseglob
set -o noclobber
shopt -s checkwinsize
shopt -s histappend

export PROMPT_DIRTRIM=2

complete -o default -o nospace -F _git_branch gb
complete -o default -o nospace -F _git_checkout gco

bind "set completion-ignore-case on"
bind "set completion-map-case on"
bind "set completion-map-case on"

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000
HISTCONTROL="erasedups:ignoreboth"
HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
HISTTIMEFORMAT='%F %T '

export GIT_AUTHOR_NAME='Michal Fojtik'
export GIT_COMMITTER_NAME='Michal Fojtik'
export GIT_AUTHOR_EMAIL='mfojtik@redhat.com'
export GIT_COMMITTER_EMAIL='mfojtik@redhat.com'

export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="google-chrome-beta"

export GOPATH=$HOME/go

export PATH=$HOME/bin:$GOPATH/bin:$PATH
export PS1=" \w \[\033[00m\]\[\033[00;34m\]∎\[\033[00m\] "
