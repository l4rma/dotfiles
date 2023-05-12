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

# Including PATHs
#PATH="$PATH:$(go env GOPATH)/bin"					# Golang
PATH="$PATH:$HOME/bin"								# homemade scripts
#PATH="$PATH:$HOME/.local/bin"						# homemade scripts
PATH="$PATH:$HOME/.cargo/bin"						# Rust
PATH="/opt/homebrew/bin/:$PATH"						# Homebrew
export PATH

# Add man pages for all the homebrew installed apps
export MANPATH="/opt/homebrew/share/man:$MANPATH"

# Set default browser
export BROWSER=firefox

# Set default editor
export EDITOR=nvim

# Open man pages in vim
export MANPAGER='nvim +Man!'

# Change caps to esc
#setxkbmap -option caps:escape

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

#neofetch --disable GPU
