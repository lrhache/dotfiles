set shell=zsh
set hidden
set spell
set encoding=UTF-8

filetype off                  " required

" Note: skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " be improved
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')



set rtp+=/usr/local/opt/fzf
Plug 'junegunn/fzf.vim'


Plug 'morhetz/gruvbox'
Plug 'romainl/vim-cool'

" Plug 'gmarik/Vundle.vim'
Plug 'tpope/vim-fugitive'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-repeat'
Plug 'sjl/gundo.vim'
Plug 'fs111/pydoc.vim'
" Plug 'vim-scripts/pep8'
" Plug 'kevinw/pyflakes-vim'
Plug 'wincent/Command-T'
" Plug 'plasticboy/vim-markdown'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'
Plug 'altercation/vim-colors-solarized'
Plug 'Lokaltog/powerline'
"Plug 'nanotech/jellybeans.vim'
Plug 'scrooloose/nerdtree'
Plug 'jmcantrell/vim-virtualenv'
" Plug 'python'
" Plug 'elzr/vim-json'
Plug 'hynek/vim-python-pep8-indent'
Plug 'bling/vim-airline'
" Plug 'rking/ag.vim'
Plug 'sheerun/vim-polyglot'

" Plug 'Shougo/vimproc'
" Plug 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
" Plug 'Shougo/unite.vim'

" Plug 'tpope/vim-commentary'
Plug 'tomtom/tcomment_vim'

" Plug 'moll/vim-node'
Plug 'godlygeek/tabular'
" Plug 'jelera/vim-javascript-syntax'
" Plug 'surround
Plug 'scrooloose/nerdcommenter'
Plug 'maksimr/vim-jsbeautify'
Plug 'walm/jshint.vim'

Plug 'alvan/vim-closetag'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'davidhalter/jedi-vim'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'Integralist/vim-mypy'

" Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'

call plug#end()


filetype plugin indent on    " required

let g:deoplete#enable_at_startup = 1

syntax enable
set background=dark
" colorscheme jellybeans
colorscheme gruvbox

let g:NERDTreeGitStatusWithFlags = 1

" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! CheckIfCurrentBufferIsFile()
  return strlen(expand('%')) > 0
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && CheckIfCurrentBufferIsFile() && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufRead * call SyncTree()

function! ToggleTree()
  if CheckIfCurrentBufferIsFile()
    if IsNERDTreeOpen()
      NERDTreeClose
    else
      NERDTreeFind
    endif
  else
    NERDTree
  endif
endfunction

" open NERDTree with ctrl + n
nmap <C-n> :call ToggleTree()<CR>

" Move around in panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Save shortcut
" map <C-w> :w<CR>

" Use tab to switch buffers
map <Tab> :bnext<cr>
map <S-Tab> :bprevious<cr>

" Shortcut to close buffer
map <C-c> :bd<CR>
"map <C-c> ! :bd!<CR>

" Use Control to go the method declaration
nmap gt :YcmCompleter GoTo<CR>


nmap <C-w> :w<CR>
imap <C-w> <ESC>:w<CR>

nmap <C-s> :bd<CR>
imap <C-s> <ESC>:bd<CR>

nmap <C-d> :bd!
imap <C-d> <ESC>:bd!

nmap <C-e> :enew<CR>
imap <C-e> <Esc> :enew<CR>

nmap <C-v> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <C-v> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <C-c> :.w !pbcopy<CR><CR>
vmap <C-c> :w !pbcopy<CR><CR>

let g:pyflakes_prefer_python_version = 3
let g:pymode_python = 'python3'

let g:syntastic_python_checkers = ['flake8']
let g:syntastic_javascript_checkers = ['jshint']

let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 1
let g:mkdp_command_for_global = 1
let g:mkdp_echo_preview_url = 1
let g:mkdp_filetypes = ['markdown', 'md']


" NerdTree
let g:NERDTreeWinPos = "right"
let NERDTreeQuitOnOpen=1

" Powerline
let g:Powerline_symbols = 'fancy'

" Airline
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

" ControlP config
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc
let g:ctrlp_show_hidden = 1

" Disable preview window
set completeopt-=preview

" Enable php syntax check 
" let g:php_syntax_extensions_enabled = 1

" Shortcut for json
nmap <C-j> :%!python -m json.tool<CR>

" configure expanding of tabs for various file types
au BufRead,BufNewFile *.py set expandtab
au BufRead,BufNewFile *.c set noexpandtab
au BufRead,BufNewFile *.h set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab

" --------------------------------------------------------------------------------
" configure editor with tabs and nice stuff...
" --------------------------------------------------------------------------------
set expandtab           " enter spaces when tab is pressed

set tabstop=2
set softtabstop=2
set shiftwidth=2

autocmd FileType python setlocal textwidth=88       " break lines when line length increases
autocmd FileType python setlocal tabstop=4           " use 4 spaces to represent tab
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal shiftwidth=4        " number of spaces to use for auto indent

set autoindent          " copy indent from current line when starting a new line

" make backspaces more powerfull
set backspace=indent,eol,start

set ruler                           " show line and column number
syntax on   			" syntax highlighting
set showcmd 			" show (partial) command in status line
set cc=88
set number


autocmd FileType php setlocal omnifunc=phpcomplete_extended#CompletePHP
autocmd Filetype json  inoremap <F5> :update<Bar>execute '!python -m json.tool'<CR>
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype jade setlocal ts=2 sts=2 sw=2

" support clipboard copy/paste when over ssh
" vmap "+y :!xclip -f -sel clip
" map "+p :r!xclip -o -sel clip
"
