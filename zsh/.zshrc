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


# DVM
if [[ -f ~/.dvm/scripts/dvm ]]; then
  . ~/.dvm/scripts/dvm
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(pyenv init -)"
eval $(thefuck --alias)

export ANDROID_HOME=$HOME/Library/Android/sdk/
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools/
export PATH=$PATH:$HOME/.pub-cache/bin

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

atuin-setup() {
    if ! command -v atuin &> /dev/null; then
        echo "atuin not found. Please install it first."
        return 1
    fi
    
    bindkey '^E' _atuin_search_widget

    export ATUIN_NOBIND="true"
    eval "$(atuin init zsh)"

    fzf-atuin-history-widget() {
        local selected
        setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2>/dev/null

        local atuin_opts="--cmd-only"
        local fzf_opts=(
            --height=40%
            --layout=reverse
            --tac
            "-n2..,.."
            --tiebreak=index
            "--query=${LBUFFER}"
            "+m"
            "--bind=ctrl-d:reload(atuin search $atuin_opts -c $PWD),ctrl-r:reload(atuin search $atuin_opts)"
        )

        selected=$(
            eval "atuin search ${atuin_opts}" |
                fzf "${fzf_opts[@]}"
        )
        
        if [ -n "$selected" ]; then
            LBUFFER+="${selected}"
        fi
        
        zle reset-prompt
        return $?
    }

    zle -N fzf-atuin-history-widget
    bindkey '^R' fzf-atuin-history-widget

    # Bind fzf-atuin-history-widget to Ctrl+R in both vi insert and normal modes
    bindkey -M viins '^R' fzf-atuin-history-widget  # Insert mode
    bindkey -M vicmd '^R' fzf-atuin-history-widget  # Normal mode
}

atuin-setup



