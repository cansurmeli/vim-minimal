" =========================================================
" LEAN .vimrc (no plugins)
" =========================================================

let mapleader=","

set nocompatible          " Use Vim settings, rather than Vi settings
set hidden                " Switch between buffers without having to save current one
set confirm               " Confirmation dialog when closing an unsaved file
set clipboard=unnamed     " Use the system clipboard
set path+=**              " Recursive search
set conceallevel=0
set shell=zsh
set encoding=utf-8
syntax on

" ---------------------------------------------------------
" BUFFER MANAGEMENT
" ---------------------------------------------------------

" While hopping through buffers, skip Terminal buffers
augroup termIgnore
  autocmd!
  autocmd TerminalOpen * setlocal nobuflisted
augroup END

" Open a new empty buffer
nnoremap <leader>T :enew<CR>

" Move to next/previous buffer
nnoremap <leader>l :bnext<CR>
nnoremap <leader>p :bprevious<CR>

" Close current buffer and move to previous one
nnoremap <leader>bq :bp \| bd #<CR>

" Show all open buffers and their status
nnoremap <leader>bl :ls<CR>

" Ctrl+c to delete current buffer (native; replaces :BD plugin command)
nnoremap <C-c> :bp \| bd #<CR>

" ---------------------------------------------------------
" OMNICOMPLETION
" ---------------------------------------------------------
filetype plugin on
" Use syntax completion only as a fallback if a filetype doesn't set omnifunc
autocmd FileType * if &l:omnifunc ==# '' | setlocal omnifunc=syntaxcomplete#Complete | endif
set completeopt=menuone,noselect
set shortmess+=c

" ---------------------------------------------------------
" FILES: swap/backup/undo directories (keeps project dirs clean)
" ---------------------------------------------------------
if !isdirectory(expand('~/.vim/swp'))    | call mkdir(expand('~/.vim/swp'), 'p')    | endif
if !isdirectory(expand('~/.vim/backup')) | call mkdir(expand('~/.vim/backup'), 'p') | endif
if !isdirectory(expand('~/.vim/undo'))   | call mkdir(expand('~/.vim/undo'), 'p')   | endif

set directory^=$HOME/.vim/swp//
set backupdir^=$HOME/.vim/backup//
set undofile
set undodir=$HOME/.vim/undo//

" ---------------------------------------------------------
" INSERT MODE QUALITY OF LIFE
" ---------------------------------------------------------
inoremap jj <ESC>         " Remap ESC to jj

" Basic curly braces completion
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

" Provide `hjkl` movements in Insert mode via Alt
inoremap <A-h> <C-o>h
inoremap <A-j> <C-o>j
inoremap <A-k> <C-o>k
inoremap <A-l> <C-o>l

" Completion navigation when popup menu is visible
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<BS>"

" ---------------------------------------------------------
" VISUAL MODE
" ---------------------------------------------------------
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" ---------------------------------------------------------
" SEARCHING
" ---------------------------------------------------------
set incsearch
set hlsearch
set ignorecase
set smartcase
nnoremap <leader><space> :nohlsearch<CR>

" ---------------------------------------------------------
" TABS 'n SPACES
" ---------------------------------------------------------
set tabstop=2
set shiftwidth=2
set softtabstop=2
set noexpandtab           " Tabs are tabs, not spaces
set autoindent

" ---------------------------------------------------------
" INDENT / WHITESPACE VISIBILITY (plugin-free)
" ---------------------------------------------------------

" Show invisible characters (makes indentation visible)
set list

" Clearer invisibles; tab shows a marker + one trailing space
set listchars=tab:▸\ ,eol:¬,trail:~,extends:»,precedes:«

" Highlight trailing whitespace + mixed indentation (tabs+spaces at line start)
augroup whitespace_hl
  autocmd!
  " Define highlight groups (re-applied on colorscheme changes)
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red     guibg=red
  autocmd ColorScheme * highlight MixedIndent     ctermbg=darkred guibg=darkred

  " Apply in each window/buffer
  autocmd BufWinEnter,WinEnter * syntax match ExtraWhitespace /\s\+$/
  autocmd BufWinEnter,WinEnter * syntax match MixedIndent /^\(\t\+ \+\| \+\t\+\)/
augroup END

" ---------------------------------------------------------
" LINE-LENGTH ALLOWANCE (subtle + slimmer + slightly higher)
" ---------------------------------------------------------
" Removed cursorcolumn (it highlights as you traverse a line)
set nocursorcolumn

" A slimmer, gentler band starting a bit later (e.g. 101-103)
highlight ColorColumn ctermbg=238 guibg=#2a2a2a
set colorcolumn=101,102,103

" Toggles
nnoremap <leader>cc :set colorcolumn=101,102,103<CR>
nnoremap <leader>cC :set colorcolumn=<CR>

" ---------------------------------------------------------
" SPELLING
" ---------------------------------------------------------
hi clear SpellBad
hi SpellBad cterm=underline,bold
autocmd FileType latex,tex,md,markdown setlocal spell spelllang=en_gb

" ---------------------------------------------------------
" TRACKPAD BEHAVIOUR (disable mouse wheel & mouse)
" ---------------------------------------------------------
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

set mouse=                 " Disable any and all mouse interactions

" ---------------------------------------------------------
" USER INTERFACE CONFIGURATION
" ---------------------------------------------------------
set relativenumber
set number
set wildmenu
set wildmode=longest:full,full
set showmatch
set noshowmode
set pumheight=20
set lazyredraw
set splitright
set splitbelow
set backspace=2
set ruler
set noerrorbells

" Disable screen flashing
set visualbell
set t_vb=

" Highlight the current line with style
hi CursorLine cterm=BOLD ctermbg=DarkBlue ctermfg=white guibg=darkred guifg=white
set cursorline

" Disabling the arrow keys in every mode
noremap  <Up> ""
noremap! <Up> <Esc>
noremap  <Down> ""
noremap! <Down> <Esc>
noremap  <Left> ""
noremap! <Left> <Esc>
noremap  <Right> ""
noremap! <Right> <Esc>

" Cursor Shape (terminal-dependent; harmless if unsupported)
let &t_EI.="\e[2 q"   " Normal mode: steady block
let &t_SI.="\e[6 q"   " Insert mode: steady bar
let &t_SR.="\e[4 q"   " Replace mode: steady underline

" ---------------------------------------------------------
" STATUSLINE (native, plugin-free, with caching)
" ---------------------------------------------------------

set laststatus=2

" Compact mode indicator
function! ModeLabel() abort
  return mode() ==# 'n' ? 'N' :
       \ mode() ==# 'i' ? 'I' :
       \ mode() ==# 'v' ? 'V' :
       \ mode()
endfunction

" Cached git branch (per-buffer)
function! GitBranchCached() abort
  if &buftype !=# '' | return '' | endif
  if !exists('b:git_branch') || get(b:, 'git_branch_tick', -1) != b:changedtick
    let b:git_branch_tick = b:changedtick
    let l:dir = expand('%:p:h')
    if l:dir ==# '' | let b:git_branch = '' | return '' | endif
    let l:branch = system('git -C ' . shellescape(l:dir) . ' rev-parse --abbrev-ref HEAD 2>/dev/null')
    let b:git_branch = v:shell_error ? '' : trim(l:branch)
  endif
  return b:git_branch ==# '' ? '' : '  ' . b:git_branch . ' '
endfunction

" Search counter label
function! SearchCountLabel() abort
  if !v:hlsearch | return '' | endif
  if !exists('*searchcount') | return '' | endif
  let l:sc = searchcount()
  if empty(l:sc) || get(l:sc, 'total', 0) == 0 | return '' | endif
  return '/' . @/ . ' ' . l:sc.current . '/' . l:sc.total . ' '
endfunction

" Statusline highlight groups
highlight StatusLine   guifg=#ffffff guibg=#005f87
highlight StatusLineNC guifg=#ffffff guibg=#303030
highlight SLMode       guifg=#000000 guibg=#afff00

" Build the statusline
set statusline=
set statusline+=%#SLMode#
set statusline+=\ %{ModeLabel()}
set statusline+=%#StatusLine#
set statusline+=\ [%n]\ %f%h%m%r
set statusline+=\ [%{&ff}]
set statusline+=\ [%{&fenc?&fenc:&enc}]
set statusline+=\ [%{&filetype}]
set statusline+=\ %{GitBranchCached()}
set statusline+=\ %{SearchCountLabel()}
set statusline+=%=
set statusline+=\ (%l,%c%V)\ %P

" ---------------------------------------------------------
" OPTIONAL: ignore common junk in command-line completion
" ---------------------------------------------------------
set wildignore+=*/.git/*,*/node_modules/*,*/dist/*,*/target/*,*/vendor/*

