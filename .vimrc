set shell=zsh
set encoding=UTF-8
set mouse=a

let mapleader=" "

" Note: skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

set rtp+=/usr/local/opt/fzf
Plug 'junegunn/fzf.vim'

Plug 'morhetz/gruvbox'

Plug 'romainl/vim-cool'

Plug 'tpope/vim-fugitive'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-repeat'
Plug 'sjl/gundo.vim'
Plug 'fs111/pydoc.vim'
Plug 'wincent/Command-T'
Plug 'Valloric/YouCompleteMe'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}


Plug 'altercation/vim-colors-solarized'
Plug 'Lokaltog/powerline'
Plug 'scrooloose/nerdtree'

Plug 'python-mode/python-mode'
Plug 'jmcantrell/vim-virtualenv'
Plug 'hynek/vim-python-pep8-indent'
Plug 'scrooloose/syntastic'
Plug 'Integralist/vim-mypy'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'

Plug 'bling/vim-airline'
Plug 'sheerun/vim-polyglot'

Plug 'tomtom/tcomment_vim'

Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdcommenter'
Plug 'maksimr/vim-jsbeautify'
Plug 'walm/jshint.vim'

Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/anwolib'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'

call plug#end()


filetype off
filetype plugin indent on

let g:deoplete#enable_at_startup = 1

syntax enable
set background=dark
colorscheme gruvbox

" NerdTree
let g:NERDTreeWinPos = "right"
let NERDTreeQuitOnOpen=1

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


nmap <C-w> :up<CR>
imap <C-w> <ESC>:up<CR>

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

let g:ycm_server_log_level = 'debug'
let g:ycm_server_keep_logfiles = 1

let g:pyflakes_prefer_python_version = 3
let g:pymode_python = 'python3'

let g:pymode_lint_ignore = "E501,W"
let g:pymode_options_max_line_length = 120  " Avoid getting useless pep8 errors for long strings
let g:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length}
let g:pymode_options_colorcolumn = 1

let g:syntastic_python_flake8_args='--ignore=F821,E501,E902'
" let g:syntastic_python_pylint_post_args = "--max-line-length=120"
let g:syntastic_python_checkers = ['flake8', 'pylint']
let g:syntastic_javascript_checkers = ['jshint']

let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 1
let g:mkdp_command_for_global = 1
let g:mkdp_echo_preview_url = 1
let g:mkdp_filetypes = ['markdown', 'md']

" shortcut for mypy
nnoremap <silent> <leader>mp :!mypy % --ignore-missing-imports<CR>

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

" hide buffer instead of having to save
set hidden

"set autoindent  " copy indent from current line when starting a new line
set expandtab " enter spaces when tab is pressed
set tabstop=2
set softtabstop=2
set shiftwidth=2

autocmd FileType python setlocal textwidth=88       " break lines when line length increases
autocmd FileType python setlocal tabstop=4           " use 4 spaces to represent tab
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal shiftwidth=4        " number of spaces to use for auto indent

autocmd FileType go setlocal tabstop=4           " use 4 spaces to represent tab
autocmd FileType go setlocal softtabstop=4
autocmd FileType go setlocal shiftwidth=4        " number of spaces to use for auto indent

" Fold at indent but not on open
set foldmethod=indent
set foldlevelstart=99

" Auto-comment new lines
set formatoptions+=r
nnoremap <silent> <leader>c :TComment<CR>

" make backspaces more powerfull
set backspace=indent,eol,start

set ruler         " show line and column number
syntax on   			" syntax highlighting
set showcmd 			" show (partial) command in status line
set cc=88
set number
set relativenumber
set scrolloff=8

set ignorecase
set smartcase
set incsearch
set nohlsearch

autocmd FileType php setlocal omnifunc=phpcomplete_extended#CompletePHP
autocmd Filetype json  inoremap <F5> :update<Bar>execute '!python -m json.tool'<CR>
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype jade setlocal ts=2 sts=2 sw=2

" window split
set splitbelow splitright

nnoremap <leader>sv :vsp<CR>
nnoremap <leader>sh :sp<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <silent> <leader><Left> :vertical resize +3<CR>
nnoremap <silent> <leader><Right> :vertical resize -3<CR>
nnoremap <silent> <leader><Up> :resize +3<CR>
nnoremap <silent> <leader><Down> :resize -3<CR>

" vim terminal
nnoremap <silent> <leader>t :vnew term://zsh<CR>

" refresh vim config
nnoremap <silent> <leader>so :so $MYVIMRC<CR>

" quit
nnoremap <silent> <leader>q :q<CR>

" remove trailing whitespace on save
autocmd BufWritePre * KeepView %s/\s\+$//e

" remove empty lines at end of files
autocmd FileType python autocmd BufWritePre <buffer> KeepView %s/\($\n\s*\)\+\%$//e

" replace 3+ empty lines with 2 lines from python files
autocmd FileType python autocmd BufWritePre <buffer> KeepView %s/\n\{3,}/\r\r\r/e

" spelling settings
autocmd FileType markdown setlocal spell spelllang=en_us
nnoremap <leader>s :setlocal spell! spelllang=en_us<CR>
