# Paths
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin"
export PATH="$PATH:$HOME/.dotnet/tools" # dotnet
export PATH="/opt/homebrew/sbin:$PATH" # Homebrew
export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec" # dotnet
export PATH="$PATH:$HOME/go/bin" # Go Binaries
export PATH="$PATH:$HOME/bin" # Local Binaries
export PATH="$PATH:$HOME/.composer/vendor/bin" # PHP Composer
export PATH="/usr/local/opt/libpq/bin:$PATH" # postgresql
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

export EDITOR="nvim"

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"


# Source any local env variables
[ -f "$HOME/.local.env" ] && source "$HOME/.local.env"

# Prompt
PS1="%n@%m %~ %# "

# Aliases
alias -g v="nvim"
alias -g g="git"
alias -g gc="git commit"
alias -g gs="git status"
alias -g gwta="git worktree add"
alias -g ga="git add"
alias projects="cd ~/git"
alias dotfiles="cd ~/dotfiles"
alias ll="ls -al"
alias -g lg="lazygit"

alias sa='source ~/.zshrc;echo "ZSH aliases sourced."'

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/wyatthaston/.docker/completions $fpath)
autoload -Uz compinit
(( ${+_comps[docker]} )) || compinit
# End of Docker CLI completions

function mkcd() 
{
    # Create a directory and enter it
    mkdir -p "$1" && cd "$1"
}

function up() 
{
    # Go up n directories
    local d=""
    limit=$1
    for ((i=1 ; i <= limit ; i++))
    do
        d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
        d=..
    fi
    cd $d
}

function cll()
{
    clear && ls -al
}

function cls() 
{
    clear && ls
}


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '~/.opam/opam-init/init.zsh' ]] || source '~/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null; true
# END opam configuration

##########################################################

fastfetch
