#                      /$$                          
#                     | $$
#  /$$$$$$$$  /$$$$$$$| $$$$$$$   /$$$$$$   /$$$$$$$
# |____ /$$/ /$$_____/| $$__  $$ /$$__  $$ /$$_____/
#    /$$$$/ |  $$$$$$ | $$  \ $$| $$  \__/| $$      
#   /$$__/   \____  $$| $$  | $$| $$      | $$      
#  /$$$$$$$$ /$$$$$$$/| $$  | $$| $$      |  $$$$$$$
# |________/|_______/ |__/  |__/|__/       \_______/
#                                                   
# author: Lars Magelssen
# last update: 2023-03-23

export ZDOTDIR=$HOME/.config/zsh

# Enable colors
autoload -U colors && colors

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }
# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '( %b)'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
#PROMPT='%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%1~%{$fg[red]%}]%{$reset_color%}%b${vcs_info_msg_0_}$ '
#PROMPT='%B%{$fg[red]%}[%F{214}%n%F{003}@%F{214}%m %{$fg[green]%}%1~%{$fg[red]%}]%{$reset_color%}%b%F{015}${vcs_info_msg_0_}$ '
PROMPT='%{$fg[green]%}%B%1~ ${vcs_info_msg_0_}%{$reset_color%} '

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
export HISTCONTROL=ignoredups

# Options (man zshoptions)
setopt appendhistory
setopt HIST_IGNORE_ALL_DUPS
unsetopt BEEP
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# Auto/tab complete:
autoload -U compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

#bindkey '^J' beginning-of-line
#bindkey '^K' end-of-line 
bindkey -s '^H' 'cd;clear^M'

# Set default browser
export BROWSER=brave-browser

# Set default editor
export EDITOR=nvim

# Open man pages in vim
#export MANPAGER='nvim +Man!'

# Check OS
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    MSYS_NT*)   machine=Git;;
    *)          machine="UNKNOWN:${unameOut}"
esac

if [[ $machine == "Mac" ]]; then
  # MacOs spesific config
  echo Loading Mac zsh config

  PATH="/opt/homebrew/bin/:$PATH"						# Homebrew

  # Add man pages for all the homebrew installed apps
  export MANPATH="/opt/homebrew/share/man:$MANPATH"

  [ -f ~/.config/zsh/.zsh_mac_aliases ] && source ~/.config/zsh/.zsh_mac_aliases
  [ -f ~/.config/zsh/.fzf.zsh ] && source ~/.config/zsh/.fzf.zsh

  LC_CTYPE=en_US.UTF-8
  LC_ALL=en_US.UTF-8
elif [[ $machine == "Linux" ]]; then
  # Linux spesific config
# echo LINUX

  # Change caps to esc
  setxkbmap -option caps:escape # Use on X
  #gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape']" # Use on wayland if gnome dm

  [ -f ~/.config/fzf/key-bindings.zsh ] && source ~/.config/fzf/key-bindings.zsh
  # [ -f ~/.config/fzf/completion.zsh ] && source ~/.config/fzf/completion.zsh
  command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)" || { echo >&2 "Zoxide is not installed."}

  #neofetch --disable GPU
else
  echo "Couldn't detect OS. No OS specific zsh config code has been run."
fi

# Including PATHs
PATH=$PATH:/usr/local/go/bin
#PATH="$PATH:$(go env GOPATH)/bin"					# Golang
PATH="$PATH:$HOME/bin"								# Homemade scripts
PATH="$PATH:$HOME/dotfiles/bin"						# Dotfiles script
PATH="$PATH:$HOME/.local/bin"						# Local bins
PATH="$PATH:$HOME/.cargo/bin"						# Rust
PATH="$PATH:/opt/elixir-1.18.3/bin"                 # Elixir
export PATH

# Source files 
#[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
#[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
#[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f ~/.config/zsh/.fzf.zsh ] && source ~/.config/zsh/.fzf.zsh
[ -f ~/.config/zsh/.zsh_git ] && source ~/.config/zsh/.zsh_git
[ -f ~/.config/zsh/codeartifact-token ] && source ~/.config/zsh/codeartifact-token
[ -f ~/.config/zsh/.zsh_aliases ] && source ~/.config/zsh/.zsh_aliases
[ -f ~/.config/zsh/.work ] && source ~/.config/zsh/.work

# Set JAVA_HOME so maven understands which java version is active
export JAVA_HOME=$HOME/Library/Java/JavaVirtualMachines/corretto-11.0.17/

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


[ -f "/home/larma/.ghcup/env" ] && . "/home/larma/.ghcup/env" # ghcup-env
