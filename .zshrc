# @woodFordR .zshrc

# oh-my-zsh; https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#------------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
# Compilation flags
# export ARCHFLAGS="-arch x86_64"
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
ZSH_THEME="random"
ZSH_THEME_RANDOM_CANDIDATES=( "kolo" "awesomepanda" "theunraveler" "sorin" )
# ZSH_THEME_RANDOM_CANDIDATES=( "philips" "kolo" "garyblessington" "takashiyoshida" "awesomepanda" "theunraveler" )
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
# zstyle ':omz:update' frequency 13
# zstyle ':omz:update' frequency 13
# DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"
# ZSH_CUSTOM=/path/to/new-custom-folder
#------------------------------------------------------------------------------

# plugins standard at $ZSH/plugins/ custom at $ZSH_CUSTOM/plugins/
#------------------------------------------------------------------------------
plugins=(
  git
  bundler
  emotty
  macos
  poetry
  podman
  rails
  rake
  rbenv
  ruby
)
#------------------------------------------------------------------------------

# cpython package manager
#------------------------------------------------------------------------------
eval "$(uv generate-shell-completion zsh)"
# export POETRY_VIRTUALENVS_PREFER_ACTIVE_PYTHON=true
# export PYTHONPATH="${PYTHONPATH}:/Users/adam/woodfords-dev/python_stuff/bourbon"
#------------------------------------------------------------------------------

# aliases
#------------------------------------------------------------------------------
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias python="/opt/homebrew/bin/python3.13"
# alias python3="/opt/homebrew/bin/python3.13"
# alias python="/Users/adam/.local/share/uv/python/cpython-3.13.5-macos-aarch64-none/bin/python3.13"
# alias python3="/Users/adam/.local/share/uv/python/cpython-3.13.5-macos-aarch64-none/bin/python3.13"
# alias pulumi="/Users/adam/.pulumi/bin/pulumi"
# alias claude="/Users/adam/.claude/local/claude"
# alias cat=ccat
alias tree-sitter=$HOME/.local/bin/tree-sitter
alias docker="podman"
alias python="/usr/bin/python3"
alias zshconfig="nvim ~/.zshrc"
#------------------------------------------------------------------------------

# exports, tmux tokyo night deps
#------------------------------------------------------------------------------
# export PATH="/opt/homebrew/opt/bc/bin:$PATH"
# export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
# export PATH="/opt/homebrew/opt/gawk/libexec/gnubin:$PATH"
# export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"
# export DYLD_FALLBACK_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_FALLBACK_LIBRARY_PATH"
# export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
# export VISUAL="nano --wait"
# export EDITOR="nano --wait"
# export PATH=$PATH:$HOME/.pulumi/bin
# export PATH=$PATH:$HOME/.claude/local/
export AWS_PROFILE="woodfords_den_root"
export PATH="$HOME/.local/bin:/usr/local/bin:$HOME/bin:$PATH"
export VISUAL="nvim"
export EDITOR="nvim"
export VENV_HOME="$HOME/.virtualenvs"
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
#------------------------------------------------------------------------------

# set locale
#------------------------------------------------------------------------------
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
#------------------------------------------------------------------------------

# nvim
#------------------------------------------------------------------------------
export NVM_COLORS='cmgRY'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#------------------------------------------------------------------------------

# bash, zsh completion; clipboard; powerline, terraform
#------------------------------------------------------------------------------
fpath+=~/.zfunc
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
set clipboard+=xclip
. "$HOME/.local/share/pipx/venvs/powerline-status/lib/python3.12/site-packages/powerline/bindings/zsh/powerline.zsh"
#------------------------------------------------------------------------------

# rbenv
#------------------------------------------------------------------------------
# eval "$(rbenv init - zsh)"
eval "$(~/.rbenv/bin/rbenv init - zsh)"
FPATH=~/.rbenv/completions:"$FPATH"
#------------------------------------------------------------------------------

# virtual envs
#------------------------------------------------------------------------------
# mkvenv ""   # creates ~/.virtualenvs/
# venv ""     # activates
# deactivate  # deactivates
# rmvenv ""   # removes venv

[[ -d $VENV_HOME ]] || mkdir $VENV_HOME
lsvenv() {
  ls -1 $VENV_HOME
}
venv() {
  if [ $# -eq 0 ]
    then
      echo "Please provide venv name"
    else
      source "$VENV_HOME/$1/bin/activate"
  fi
}
mkvenv() {
  if [ $# -eq 0 ]
    then
      echo "Please provide venv name"
    else
      python3 -m venv $VENV_HOME/$1
  fi
}
rmvenv() {
  if [ $# -eq 0 ]
    then
      echo "Please provide venv name"
    else
      rm -r $VENV_HOME/$1
  fi
}
#------------------------------------------------------------------------------

