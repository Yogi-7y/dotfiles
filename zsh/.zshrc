# Vi support
bindkey -v

KEYTIMEOUT=1 # Reduce mode switching delay
VI_MODE_SET_CURSOR=true # Ensure cursor shape changes immediately after mode switch

# Vi mode cursor shape
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'  # Steady block cursor
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'  # Steady beam cursor
  fi
}
zle -N zle-keymap-select

# Use steady beam shape cursor on startup.
echo -ne '\e[6 q'

# Use steady beam shape cursor for each new prompt.
preexec() { echo -ne '\e[6 q' ;}

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

export ANDROID_HOME=$HOME/Library/Android/sdk/
export PATH=$PATH:$ANDROID_HOME/emulator

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Alias
alias ls="eza --icons=always"
alias cd="z"

# Utility
httpnvim() {
  if [ "$#" -lt 1 ]; then
    echo "Usage: httpnvim <httpie-options>"
    return 1
  fi

  # Use httpie to get JSON output and format it with jq
  http "$@" | jq . | nvim -R -c "set filetype=json" -
}


# Created by `pipx` on 2024-08-25 12:29:57
export PATH="$PATH:/Users/yogi/.local/bin"
#compdef claudesync
_claudesync() {
  eval $(env COMMANDLINE="${words[1,$CURRENT]}" _CLAUDESYNC_COMPLETE=complete-zsh  claudesync)
}
if [[ "$(basename -- ${(%):-%x})" != "_claudesync" ]]; then
  compdef _claudesync claudesync
fi
