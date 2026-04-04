" ==============================
" Key Mappings
" ==============================

" Key combination to toggle NERDTree
nnoremap <C-b> :NERDTreeToggle<CR>

" Key combination to copy to system clipboard
nnoremap <C-y> "+y
vnoremap <C-y> "+y

" Key combination to disable search highlighting
nnoremap <Esc> :nohlsearch<CR>

" Disable arrow keys for navigation in INSERT mode
noremap <Up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>

" Scroll + center cursor
nnoremap <C-D> <C-D>zz
nnoremap <C-U> <C-U>zz

" ==============================
" Main Settings
" ==============================

" Encoding
set encoding=utf-8        " Set encoding to UTF-8
set fileencodings=utf-8   " Support UTF-8 encoding for files
set nocompatible          " Disable vi compatibility
filetype plugin indent on " Enable plugin support

" ==============================
" Display Settings
" ==============================

set number                                     " Enable absolute line numbering for current line
set numberwidth=1                              " Line number width
highlight LineNr       ctermfg=NONE guifg=NONE " Disable color for line numbers
highlight CursorLineNr ctermfg=NONE guifg=NONE " Disable color for current line number
syntax on                                      " Enable syntax highlighting
set scrolloff=5                                " Keep padding from screen edge when scrolling
set background=dark                            " Dark theme

" ==============================
" Tabulation Settings
" ==============================

set expandtab     " Replace tabs with spaces
set tabstop=4     " Number of spaces for tab
set shiftwidth=4  " Number of spaces for auto-indent
set softtabstop=4 " Number of spaces for soft tab
set smarttab      " Smart tab behavior
set smartindent   " Smart indent for code

" ==============================
" Language Settings
" ==============================

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
" Support for Russian layout in commands

" ==============================
" Security
" ==============================

set modelines=0 " Disable CVE-2007-2438 vulnerability

" ==============================
" Performance
" ==============================

set backspace=indent,eol,start " More possibilities for deleting text
set nowrap                     " Disable line wrapping
set ruler                      " Show current cursor position
set mouse=a                    " Enable mouse support

" ==============================
" Autocommands
" ==============================

" Do not create backups for crontab and chpass
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
au BufWrite /private/etc/pw.*      set nowritebackup nobackup

" ==============================
" Search
" ==============================

set hlsearch  " Enable search highlighting
set incsearch " Incremental search (as you type)
set ic        " Ignore case in search
set smartcase " Ignore case unless uppercase letters are used