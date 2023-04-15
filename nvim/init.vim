set nocompatible                      " Welcome to the future
filetype off

call plug#begin()
" LuaLine
Plug 'nvim-lualine/lualine.nvim'

" Syntax highlighting and indentation
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kchmck/vim-coffee-script'

" Linter and Formatter
Plug 'dense-analysis/ale'

" Color scheme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" File tree
Plug 'preservim/nerdtree'

" All about parentheses, braquets, quotes, tags.
Plug 'tpope/vim-surround'

" Git
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
call plug#end()

filetype plugin indent on             " Allow plugins to determine indentation
syntax enable
set omnifunc=syntaxcomplete#Complete  " Language autocomplete
set t_Co=256                          " Number of colors
colorscheme catppuccin-mocha

let mapleader = " "                   " Leader - ( Spacebar )
let g:netrw_banner = 0                " Disable_banner in filebrowser
let g:html_indent_tags = 'li\|p'      " Treat <li> and <p> tags like block tags
let g:NERDTreeQuitOnOpen=1

let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'typescript': ['eslint'],
\ 'ruby': ['rubocop'],
\ 'coffee': ['coffeelint']
\ }

let g:ale_fixers = {
\ 'javascript': ['prettier'],
\ 'typescript': ['prettier'],
\ 'css': ['prettier'],
\ 'ruby': ['prettier']
\ }

let g:ale_fix_on_save = 1

set autoindent                        " Copy indent from current line on <CR>
set autoread                          " Reload files changed outside vim
set autowrite                         " Automatically :write before running commands
set background=dark                   " Set dark background
set backspace=eol,start,indent        " Delete like normal applications
set encoding=utf-8                    " Set character encoding used inside Vim
set expandtab                         " Expand tabs to spaces
set gdefault                          " Never have to type /g at the end of search / replace again
set hidden                            " Keep buffer open when opening a new one
set history=100                       " Keep history fo commands
set hlsearch                          " Highlight all search matches
set ignorecase                        " Case insensitive searching (unless specified)
set incsearch                         " Show matches when searching
set laststatus=2                      " Show statusbar all the time
set list                              " Show list characters
set listchars=tab:»·,trail:·,nbsp:·
set matchpairs+=<:>                   " HTML Editing
set nobackup                          " Dont keep backup files
set nocursorline                      " Dont hightlight the scree line of the cursor
set noerrorbells                      " Dont beep on error
set noswapfile                        " Dont create swap files for the buffer
set novisualbell                      " Stop beeping
set nowrap                            " Dont wrap lines
set nowritebackup                     " Dont create backups before writing to file
set number
set numberwidth=4                     " Minimal number of columns to use for the line number
set rnu                               " Print relative line numbers in front of line
set scrolloff=8                       " Keep 8 lines above and below the cursor
set shiftwidth=2                      " Number of spaces to use for (auto) indent
set showmatch                         " Show matching bracket
set sidescroll=1                      " Minimal number of columns to scroll horizontally
set sidescrolloff=15                  " Keep 15 columns to the left and to the right of the cursor
set smartcase                         " Override ignorecase if search pattern contains upper case
set softtabstop=2                     " Number of spaces that a <Tab> counts for
set splitbelow                        " Open new horizontal panes at bottom
set splitright                        " Open new vertical panes at right
set tabstop=2                         " The number of spaces that a <Tab> counts for
set wildmenu                          " Enable command-line completion
set wildmode=list:longest,full

" Trigger autoread when changing buffers or coming back to vim in terminal
autocmd FocusGained,BufEnter * :silent! !

" remove trailing spaces on ruby, javascript, typescript and coffeescript
autocmd BufWritePre *.js %s/\s\+$//e
autocmd BufWritePre *.jsx %s/\s\+$//e
autocmd BufWritePre *.rb %s/\s\+$//e
autocmd BufWritePre *.coffee %s/\s\+$//e
autocmd BufWritePre *.ts %s/\s\+$//e
autocmd BufWritePre *.tsx %s/\s\+$//e

" Make searching better
nnoremap <silent> <leader>, :noh<cr> " Stop highlight after searching

" Open NerdTree
nnoremap <leader>d :NERDTreeToggle<cr>

" window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" Show next search result in the center of screen
nnoremap n nzz
nnoremap N Nzz

" buffer movement
noremap <tab> :bn<CR>
noremap <S-tab> :bp<CR>

" Deactivate recording
map q <nop>

" Alias for saving when not editing as sudo
cmap w!! %!sudo tee > /dev/null %

lua << END
require('lualine').setup{
  options = {
    icons_enabled = false,
    component_separators = { left = '⮞', right = '⮜'},
    section_separators = { left = '▶', right = '◀'},
    theme = 'horizon'
  }
}

require('gitsigns').setup()
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "vim", "vimdoc", "lua", "javascript", "typescript", "ruby", "dockerfile",
    "comment", "css", "diff", "elixir", "rust", "graphql", "html", "json",
    "json5", "scss", "sql", "vala"
  },

  sync_install = true,
  auto_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
END
