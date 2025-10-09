source ~/.config/zsh/.zshrc

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/lars.magelssen/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/lars.magelssen/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/lars.magelssen/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/lars.magelssen/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
