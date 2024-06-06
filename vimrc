" ******************************************************************************
" Script Name: vimrc
" Description: The configuration file for the Vim text editor.
" Author: makamat
" Date: 2024-03-27
" Version: 1.0
" ******************************************************************************

" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
" let skip_defaults_vim=1

" ------------------------------------------------------------------------------
" Variables
" ------------------------------------------------------------------------------

" general
" ==============================================================================

let mapleader = ','
let localleader = '\\'

" ------------------------------------------------------------------------------
" Options
" ------------------------------------------------------------------------------

filetype plugin indent on
syntax enable

set encoding=utf-8
set expandtab
set mouse=a
set shiftwidth=4
set tabstop=4
set textwidth=80
set wildmenu
set wrap

" ------------------------------------------------------------------------------
" Autocommands
" ------------------------------------------------------------------------------

" all
" ==============================================================================

" jump to the location of the last edit
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | 
    \ execute "normal! g'\"" | endif

" c, c++
" ==============================================================================

augroup c_cpp
    autocmd!
    autocmd FileType c,cpp setlocal shiftwidth=8 tabstop=8
augroup END

" mutt
" ==============================================================================

" setting text width for mutt emails
autocmd BufRead /tmp/*mutt-* set tw=80

augroup mail
    autocmd!

    " filetype detection for mutt emails
    autocmd BufRead,BufNewFile *mutt-* setfiletype mail
augroup END

" ------------------------------------------------------------------------------
" Mappings
" ------------------------------------------------------------------------------

" insert mode 
" ==============================================================================

" delete the current line
inoremap <c-d> <esc>ddi

" make an indent
inoremap <c-l> <tab>

" disable escape
inoremap <esc> <nop>

" exit input mode
inoremap jk <esc>

" surround the preceding word with quotation marks.
inoremap q" <esc>bi"<esc>ea"

" normal mode 
" ==============================================================================

" swap the current line with the line below
nnoremap <c-s-j> ddp

" swap the current line with the line above
nnoremap <c-s-k> ddkP

" delete the current line
nnoremap - dd

" delete the current buffer 
nnoremap <c-d> :bdelete<cr>

" convert to uppercase 
nnoremap <c-u> <esc>bveU

" surround the word under the cursor with double quotes  
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" surround the word under the cursor with single quotes  
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" refresh vim
nnoremap <leader>rv :source $MYVIMRC<cr>

" select a word
nnoremap <space> viw

" move cursor to the beginning of a line
nnoremap H ^

" move cursor to the end of a line
nnoremap L $

" go buffer next
nnoremap gbn :bnext<cr>

" go buffer prev
nnoremap gbp :bprevious<cr>

" edit tmux
nnoremap <leader>et :call OpenFile(".tmux.conf")<cr>

" edit vimrc
nnoremap <leader>ev :call OpenFile(".vimrc")<cr>

" edit zshrc
nnoremap <leader>ez :call OpenFile(".zshrc")<cr>

" edit i3
nnoremap <leader>ei3 :call OpenFile(".config/i3/config")<cr>

" edit mimeapps
nnoremap <leader>emi :call OpenFile(".config/mimeapps.list")<cr>

" open file manager
if executable('vifm')
    nnoremap <leader>fm :!vifm %:p:h<cr><cr>
endif

" ------------------------------------------------------------------------------
" Abbreviations
" ------------------------------------------------------------------------------

iabbrev strign string
iabbrev Strign String

" ------------------------------------------------------------------------------
" Functions 
" ------------------------------------------------------------------------------

" open file
function! OpenFile(f)
    execute 'vsplit' expand('$HOME').'/' . a:f
endfunction
