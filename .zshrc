# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Load autocompletion
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
zinit cdreplay -q
complete -C '/usr/local/bin/aws_completer' aws

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# History configuration
HISTSIZE=5000
HISTFILE=~/.local/state/zsh/zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Completion configuration
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it include user's golang built binary
if [ -d "$HOME/go/bin" ] ; then
    PATH="$HOME/go/bin:$PATH"
fi

# check variable $XDG_CONFIG_HOME and set it if empty anyway
if [ -z "$XDG_CONFIG_HOME" ] ; then
    XDG_CONFIG_HOME="$HOME/.config"
fi

# linuxbrew shell env init
if [ -d "/home/linuxbrew" ] ; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# kubernetes completion
[ -z "$(command -v kubectl)" ] || . <(kubectl completion zsh)
[ -z "$(command -v flux)" ] || . <(flux completion zsh)
[ -z "$(command -v helm)" ] || . <(helm completion zsh)

# k6 completion
[ -z "$(command -v k6)" ] || . <(k6 completion zsh)

# personal customization
export VISUAL=nvim
export EDITOR=nvim
export GOPATH=~/go

# Aliases
alias vim=nvim
alias ls='ls --color'
alias ll='ls -l'
alias podman='podman-remote-static-linux_amd64'

# nvm configuration
[ -z "$(command -v nvm)" ] || nvm install Jod > /dev/null 2>&1
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# docker completion
FPATH="$HOME/.docker/completions:$FPATH"
autoload -Uz compinit
compinit
