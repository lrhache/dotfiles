bindkey -v

export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/Cellar/python@3.9/3.9.2_2/Frameworks/Python.framework/Versions/3.9/bin:$PATH"
export PATH="/usr/local/opt/python@3.9/libexec/bin:$PATH"
export PATH="/usr/local/opt/luajit-openresty/bin:$PATH"

# iexport CPPFLAGS="-I/usr/local/opt/openjdk/include"

export LDFLAGS="-L/usr/local/opt/luajit-openresty/lib"
export CPPFLAGS="-I/usr/local/opt/luajit-openresty/include"
export PKG_CONFIG_PATH="/usr/local/opt/luajit-openresty/lib/pkgconfig"



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

[[ -s /Users/lrhache/.autojump/etc/profile.d/autojump.sh ]] && source /Users/lrhache/.autojump/etc/profile.d/autojump.sh

#  VIRTUALENVWRAPPER_PYTHON="/usr/bin/python3"
#  export WORKON_HOME=~/.envs
#  source /usr/local/bin/virtualenvwrapper.sh

alias reload="exec $SHELL"

alias ll="ls -al"
# alias vi=/Applications/MacVim.app/Contents/bin/vim
alias vi=/usr/local/bin/nvim
alias python=`which python3`
alias flake8=`pyenv which flake8`

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
eval "$(pyenv virtualenv-init -)"

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
alias pycreate="pyenv virtualenv $@"
alias pyuse="pyenv activate $@"
alias pydeactivate="pyenv deactivate"
alias pydefaults="vi $(pyenv root)/default-packages"
alias pylist="pyenv virtualenvs"
alias pylocal="pyenv local $@"
alias pyinstall="pyenv install $@"
alias pyremove="pyenv virtualenv-delete $@"

function newenv() {
    if [[ -z "$2" ]]; then
      version='3.9.2'
      name=$1
    else
      version=$1
      name=$2
    fi

    pycreate $version $name
    pyuse $name
    pylocal $name

    jsinit
}

function jsinit() {
  echo '{"esversion": 6}' > ./.jshintrc

  ternproject=$(cat <<-END
{
  "plugins": {
    "node": {},
    "es_modules": {}
  },
  "libs": [
    "ecma5",
    "ecma6"
  ],
  "ecmaVersion": 6
}
END
)
  echo $ternproject > ./.tern-project
}


alias gsetproject="gcloud config set project $@"
alias gsetzone="gcloud config set compute/zone $@"
alias ghelp="cat ~/.gcp-help"

source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

