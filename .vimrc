let mapleader=","
set hidden              " Swtich between buffers without having to save current one
set nocompatible	" Use Vim settings, rather than Vi settings
set confirm		" Display a confirmation dialog when closing an unsaved file
set clipboard=unnamed	" use the system clipboard
set path+=**		" recursive search
inoremap jj <ESC>	" Remap the ESC key to jj
set conceallevel=0
map <C-c> :BD<cr>       " Ctrl + c to delete current buffer
set shell=zsh
set encoding=utf-8
syntax on

" BUFFER MANAGEMENT
" While hooping through buffers, skip the Terminal buffer
" https://vi.stackexchange.com/questions/16708/switching-buffers-in-vi-while-skipping-any-terminal-in-vi-8-1#16709
augroup termIgnore
	autocmd!
	autocmd TerminalOpen * set nobuflisted
augroup END

" To open a new empty buffer
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>p :bprevious<CR>

" Close the current buffer and move to the previous one
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" OMNICOMPLETION
" Turn on Omni Completion
filetype on
filetype plugin on
set omnifunc=syntaxcomplete#Completions

" OTHER
" Centralise the directories for the swap and backup files so they don't
" scatter around
set directory=$HOME/.vim/swp/
set backupdir=$HOME/.vim/backup/

" Basic curly braces completion
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}
  
" Mastering Vim Quickly #45
" Move visual selection
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

" SEARCHING
set incsearch																" find the next match as we type the search
set hlsearch																" highlight the searches by default
set ignorecase															" ignore case when searching
set smartcase																" unless a capital is types, the casing isn't ignored
nnoremap <leader><space> :nohlsearch<CR>    " Stop search highlighting map to ,<space>

" TABS 'n SPACES
set tabstop=2				" number of visual spaces per TAB
set shiftwidth=2			" number of space characters inserted for indentation
set softtabstop=2			" number of spaces in a tab while editing
set noexpandtab				" tabs are tabs, not spaces
set autoindent
set listchars=tab:>-,eol:¬,trail:~	" show invisibles

" SPELLING
" Mastering Vim Quickly #99
" `ctrl-I` to auto-correct misspelled words
"inoremap u[s1z=`]au

hi clear SpellBad
hi SpellBad cterm=underline,bold
autocmd FileType latex,tex,md,markdown setlocal spell spelllang=en_gb

" TRACKPAD BEHAVIOUR
" Basically disable everything because:
" - we're in Vim,
" - even if they just stand there, it's annoying upon
" an accidental interaction.
noremap <ScrollWheelUp>      <nop>
noremap <S-ScrollWheelUp>    <nop>
noremap <C-ScrollWheelUp>    <nop>
noremap <ScrollWheelDown>    <nop>
noremap <S-ScrollWheelDown>  <nop>
noremap <C-ScrollWheelDown>  <nop>
noremap <ScrollWheelLeft>    <nop>
noremap <S-ScrollWheelLeft>  <nop>
noremap <C-ScrollWheelLeft>  <nop>
noremap <ScrollWheelRight>   <nop>
noremap <S-ScrollWheelRight> <nop>
noremap <C-ScrollWheelRight> <nop>

" USER INTERFACE CONFIGURATION
set relativenumber			" show relative line numbers
set number				" also show the static line number for the current line while there
set wildmenu				" visual autocomplete for the command menu
set showmatch				" highlight matching [{()}]
set noshowmode				" do not display the current mode as there is vim-airline
set pumheight=20			" Limit popup menu height
set lazyredraw
set splitright
set backspace=2
set ruler				" always show the cursor position
set noerrorbells			" disable beep on errors

" Disable screen flashing
set visualbell
set t_vb=

set mouse=				" disable any and all mouse interactions

" Highlight the current line with style
hi CursorLine cterm=BOLD ctermbg=DarkBlue ctermfg=white guibg=darkred guifg=white

" Disabling the arrow keys in every mode
" Make use of Vim instead! :]
noremap  <Up> ""
noremap! <Up> <Esc>
noremap  <Down> ""
noremap! <Down> <Esc>
noremap  <Left> ""
noremap! <Left> <Esc>
noremap  <Right> ""
noremap! <Right> <Esc>

" provide `hjkl` movements in Insert mode via the <Alt> modifier key
inoremap <A-h> <C-o>h
inoremap <A-j> <C-o>j
inoremap <A-k> <C-o>k
inoremap <A-l> <C-o>l

" Cursor Shape
" https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI.="\e[2 q" "SI = INSERT mode
let &t_SR.="\e[2 q" "SR = REPLACE mode
let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)

" STATUS LINE
" Enable the status line to always be visible
set laststatus=2

" Define the status line with various components
set statusline=
set statusline+=%#StatusLine#          " Status line highlight group
set statusline+=[%n]                   " Buffer number
set statusline+=%f                     " File name with full path
set statusline+=%h%m%r                 " Help file flag, modified flag, and readonly flag
set statusline+=[%{&ff}]               " File format (unix, dos, etc.)
set statusline+=[%{&fenc?&fenc:&enc}]  " File encoding (e.g., utf-8)
set statusline+=%{GitBranch()}         " Git branch
set statusline+=%=%-14.(%l,%c%V%)      " Line number, column number, and virtual column
set statusline+=%P                     " Percentage through the file

function! GitBranch()
	let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null")
	return v:shell_error ? '' : trim(l:branchname)
endfunction
set statusline+=%{GitBranch()}       " Use manual git command if fugitive is not available
highlight StatusLine guifg=#ffffff guibg=#005f87
highlight StatusLineNC guifg=#ffffff guibg=#303030
