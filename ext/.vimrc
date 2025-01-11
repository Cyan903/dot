" Config {{{
let mapleader = " "
let maplocalleader = ","

let g:netrw_banner = 0
let g:has_nerd_font = 1

syntax on

set number relativenumber nowrap cursorline " Line number
set ignorecase smartcase hlsearch incsearch " Searching
set nowrap " Wrapping

set list listchars=tab:»\ ,trail:·,nbsp:␣
set termguicolors

if executable("rg") == 1
    set grepprg=rg\ --vimgrep
endif
" }}}

" Abbreviations & remaps {{{
cabbrev W w
cabbrev WQ wq

tnoremap <esc><esc> <C-\><C-n>
nnoremap <esc> <cmd>nohlsearch<cr>
" }}}

" Auto commands {{{
augroup vim_cfg
    autocmd!
    autocmd FileType vim nnoremap <buffer> <leader>vs <cmd>w<CR> <cmd>source $MYVIMRC<CR>
    autocmd FileType vim nnoremap <buffer> <leader>vv <cmd>w<CR> <cmd>source<CR>
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" User commands {{{
function! ToggleWrap()
    set wrap!

    if &wrap
        nnoremap j gj
        nnoremap k gk
    else
        nunmap j
        nunmap k
    endif
endfunction

command WordWrapToggle call ToggleWrap()
" }}}

" Plugins {{{
call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()
" }}}

" Theme {{{
colorscheme dracula

hi Normal guibg=NONE ctermbg=NONE
hi StatusLine ctermbg=NONE ctermfg=NONE guibg=NONE
" }}}

" vim: ts=4:sw=4:et
