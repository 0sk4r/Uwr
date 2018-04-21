" ==================================================================================================
" General settings
" ==================================================================================================

" base
set nocompatible                      " vim, not vi
filetype off                          " try to recognise filetype and load plugins and indent files

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'dracula/vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'shirk/vim-gas'

call vundle#end()            " required
filetype plugin indent on
syntax on
colorscheme dracula


" set true colors and add vim specific fixes
set termguicolors

" interface
set background=dark                   " tell vim what the background color looks like
set colorcolumn=100                   " show a column at 100 chars
set cursorline                        " highlight current line
set noshowmode                        " don't show mode
set number                            " show line numbers
set ruler                             " show current position at bottom
set scrolloff=5                       " keep at least 5 lines above/below
set shortmess+=aAIsT                  " disable welcome screen and other messages
set showcmd                           " show any commands
set sidescroll=1                      " smoother horizontal scrolling
set sidescrolloff=5                   " keep at least 5 lines left/right
set splitbelow                        " create new splits below
set splitright                        " create new splits to the right
set wildmenu                          " enable wildmenu
set wildmode=longest:full,full        " configure wildmenu
set nohidden                          " close buffers instead of hiding them

" whitespace
set expandtab                         " use spaces
set nojoinspaces                      " use one space, not two, after punctuation
set shiftround                        " shift to next tabstop
set shiftwidth=2                      " amount of space used for indentation
set softtabstop=2                     " appearance of tabs
set tabstop=2                         " use two spaces for tabs

" folding
set nofoldenable                      " disable folds

" text appearance
set synmaxcol=200                     " stop syntax highlighting after 200 columns
set nowrap                            " disable line wrapping

" interaction
set backspace=2                       " make backspace work like most other apps
set mouse=a                           " enable mouse support
set mousehide                         " hide the mouse cursor while typing
set whichwrap=b,s,h,l,<,>,[,]         " backspace and cursor keys wrap too

" searching
set hlsearch                          " highlight search matches
set ignorecase                        " set case insensitive searching
set incsearch                         " find as you type search
set smartcase                         " case sensitive searching when not all lowercase

" background processes
set autoread                          " update file when changed outside of vim
set autoindent                        " copy indentation from the previous line for new line
set clipboard=unnamed                 " use native clipboard
set history=200                       " store last 200 commands as history
set nobackup                          " don't save backups
set noerrorbells                      " no error bells please
set noswapfile                        " no swapfiles
set nowritebackup                     " don't save a backup while editing
set ttyfast                           " indicates a fast terminal connection

" character encoding
if !&readonly && &modifiable
  set fileencoding=utf-8              " the encoding written to file
endif
set encoding=utf-8                    " the encoding displayed


" Plugins config


"Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

nnoremap <C-n> :NERDTreeToggle<CR>
" ==================================================================================================
" Keys
" ==================================================================================================

" set leader to space
let mapleader = " "

" map semicolon to colon and vice versa
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" keep selection after indent
vnoremap < <gv
vnoremap > >gv

" sort
vnoremap <leader>s :sort<CR>

" clear search
nnoremap <leader>c :let @/ = ""<CR>

" Tabs switching
nnoremap H gT
nnoremap L gT

noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
