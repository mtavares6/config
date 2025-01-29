## Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Source .bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Initialize Google Cloud SDK
if [ -f '/Users/MiguelTavares/google-cloud-sdk/path.zsh.inc' ]; then
    . '/Users/MiguelTavares/google-cloud-sdk/path.zsh.inc'
fi
if [ -f '/Users/MiguelTavares/google-cloud-sdk/completion.zsh.inc' ]; then
    . '/Users/MiguelTavares/google-cloud-sdk/completion.zsh.inc'
fi
export PATH=$PATH:/Users/MiguelTavares/google-cloud-sdk/bin

# Add Maven to PATH
export PATH=$PATH:/Users/MiguelTavares/apache-maven-3.8.6/bin

# Add PostgreSQL and Robot Framework to PATH
export PATH=$PATH:psql
export PATH=$PATH:/opt/homebrew/Cellar/robot-framework/7.1.1/bin

# Add Cargo and Volta to PATH
export PATH=$PATH:/Users/MiguelTavares/.cargo/bin
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Initialize Conda
__conda_setup="$('/Users/MiguelTavares/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/MiguelTavares/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/MiguelTavares/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/MiguelTavares/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# Load SSH autocompletion
[ -f /etc/bash_completion.d/ssh ] && . /etc/bash_completion.d/ssh

# Initialize JBang
alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"

# Add bash completion
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
[[ -r "/etc/profile.d/bash_completion.sh" ]] && . "/etc/profile.d/bash_completion.sh"

