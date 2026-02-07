# Load Angular CLI autocompletion.
export ITERM2_SQUELCH_MARK=1
alias j!=jbang
alias vim=nvim
alias docker-compose='docker compose'
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/MiguelTavares/miniconda3/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/MiguelTavares/miniconda3/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/MiguelTavares/miniconda3/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/MiguelTavares/miniconda3/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
# Add JBang to environment
export PATH="$HOME/.jbang/bin:$PATH"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/MiguelTavares/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/MiguelTavares/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/MiguelTavares/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/MiguelTavares/google-cloud-sdk/completion.zsh.inc'; fi
export PATH=$PATH:/Users/MiguelTavares/google-cloud-sdk/bin/gcloud
eval "$(zoxide init bash)"
eval "$(starship init bash)"

[ -s "/Users/MiguelTavares/.jabba/jabba.sh" ] && source "/Users/MiguelTavares/.jabba/jabba.sh"

# pnpm
export PNPM_HOME="/Users/MiguelTavares/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# opencode
export PATH=/Users/MiguelTavares/.opencode/bin:$PATH
alias oc='opencode'
export EDITOR=nvim

# sessionizer
export PATH=/Users/MiguelTavares/.config/sessionizer:$PATH

# Maven Debug Auto-Sourcing
# Auto-source .mavenrc in project directories for debug configuration
export PATH="$HOME/.local/bin:$PATH"
alias debug-ports='debug-port-manager list'
alias debug-check='debug-port-manager check'
