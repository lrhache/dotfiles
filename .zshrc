eval "$(starship init zsh)"
fpath+=~/.zfunc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

bindkey -v

export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:/usr/local/bin"

export STARSHIP_CONFIG=~/dotfiles/starship-config.toml

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#  VIRTUALENVWRAPPER_PYTHON="/usr/bin/python3"
#  export WORKON_HOME=~/.envs
#  source /usr/local/bin/virtualenvwrapper.sh

alias reload="exec $SHELL"

alias ll="ls -al"

function mko() {
  mkdir $@
  cd ${*: -1}
}

function export_all() {
  set -a; source $1; set +a;
}

function json() {
  awk "NR>=$1 && NR<=$2" $3 | jq
}

alias rowcount="wc -l < $@"

alias f=fzf-file-widget
alias h=fzf-history-widget

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

git_branch_name() {
  branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/*\(.*\)/\1/' | xargs)
  echo $branch
}

ggpo() {
  branch=$(git_branch_name)
  git push -u origin $branch
}

alias ggs="git status"
alias ggc="git checkout"
alias ggb="git checkout -b"
alias gga="git add"
alias ggad="git add ."
alias ggm="git commit -m $@"
alias ggbd="git branch -D $@"
alias ggbs="git branch"

export NVIM_PYTHON_LOG_FILE=/tmp/log
export NVIM_PYTHON_LOG_LEVEL=DEBUG

[[ -s ~/.envvars ]] && source ~/.envvars

