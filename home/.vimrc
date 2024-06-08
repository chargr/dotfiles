set encoding=utf-8

syntax on
set number
set expandtab
set tabstop=4
set shiftwidth=4
set nowrap

set noincsearch

set runtimepath+=~/.vim/bundle/YouCompleteMe/
let g:ycm_autoclose_preview_window_after_completion=1

autocmd FileType yaml setlocal ts=2 sts=2 sw=2
autocmd BufRead,BufNewFile *.sls setlocal ft=yaml
