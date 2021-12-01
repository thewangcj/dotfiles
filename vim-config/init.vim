set number
set nocompatible
set noerrorbells
set showmatch
set ignorecase
set incsearch
set novisualbell
set tabstop=4
set autowrite
set ruler
set cursorline
set colorcolumn=80
set encoding=utf-8
syntax on

set background=dark
colorscheme hybrid

let mapleader=','
inoremap <leader>w <Esc>:w<cr>

inoremap jj <Esc>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <leader>v :NERDTreeFind<cr>
noremap <leader>g :NERDTreeToggle<cr>
let NERDTreeShowHidden=1
let NERDTreeIgnore = [
	\ '\.git$', '\.hg$', '\.svn$','\.stversion$','\.pyc$','\.pyo$',
	\ '\.swp$','\.DS_Store$','\.__pycache__$','\.egg-info$','\.ropeprojects$',
	\ ]

call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'w0ng/vim-hybrid'
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

Plug 'easymotion/vim-easymotion'
nmap ss <Plug>(easymotion-s2)

Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'brooth/far.vim'
Plug 'vim-airline/vim-airline'

Plug 'python-mode/python-mode', {'for': 'python', 'branch': 'develop'}
let g:pymode_python = 'python3'
let g:pymode_trim_whitespace = 1
let g:pymode_doc = 1
let g:pymode_doc_bind = 'K'
let g:pymode_rope_goto_definition_bind = "<C-[>"
let g:pymode_lint = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe', 'pylint']
let g:pymode_options_max_line_length = 120

Plug 'sbdchd/neoformat'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-commentary'

call plug#end()

