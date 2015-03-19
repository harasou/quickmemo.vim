" quickmemo.vim
" Maintainer: SOGO Haraguchi <harasou5@gmail.com>
" Version: 0.1.0
" See doc/quickmemo.txt for instructions and usage.

if (exists("g:loaded_quickmemo") && g:loaded_quickmemo) || &cp
  finish
endif
let g:loaded_quickmemo = 1

let s:cpo_save = &cpo
set cpo&vim

command! -nargs=? Memo     :call quickmemo#save(<f-args>)
command! -nargs=0 Memogrep :call quickmemo#grep()
command! -nargs=0 Memolist :call quickmemo#list()


let &cpo = s:cpo_save
" vim:set ft=vim ts=2 sw=2 sts=2:
