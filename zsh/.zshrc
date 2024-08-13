eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(fzf --zsh)"

# Starship
eval "$(starship init zsh)"


source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
