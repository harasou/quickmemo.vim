" quickmemo.vim
" Maintainer: SOGO Haraguchi <harasou5@gmail.com>
" Version: 0.1.0
" See doc/quickmemo.txt for instructions and usage.

if exists("g:autoloaded_quickmemo") || &cp
  finish
endif
let g:autoloaded_quickmemo = 1

let s:cpo_save = &cpo
set cpo&vim


" ------------------------------------------------------
" setting
" ------------------------------------------------------
if !exists('g:quickmemo_name')
  let g:quickmemo_name = '%m-%d-%H%M'
endif
if !exists('g:quickmemo_suffix')
  let g:quickmemo_suffix = 'txt'
endif

if !exists('g:quickmemo_save_path')
  let g:quickmemo_save_path = '~/memo/%Y/%m/'
elseif g:quickmemo_save_path[-1] != '/'
  let g:quickmemo_save_path = g:quickmemo_save_path.'/'
endif
if !exists('g:quickmemo_list_path')
  let g:quickmemo_list_path = matchstr(g:quickmemo_save_path,'^\([^%]\+/\)*')
endif
if !exists('g:quickmemo_grep_path')
  let g:quickmemo_grep_path = matchstr(g:quickmemo_save_path,'^\([^%]\+/\)*')
endif
if !exists('g:quickmemo_list_unite_source')
  let g:quickmemo_list_unite_source = 'file_rec'
endif
if !exists('g:quickmemo_list_unite_option')
  let g:quickmemo_list_unite_option = ''
endif
if !exists('g:quickmemo_grep_unite_option')
  let g:quickmemo_grep_unite_option = ''
endif


" ------------------------------------------------------
" function
" ------------------------------------------------------
function! quickmemo#save(...)
  if a:0 == 0
    let filename = g:quickmemo_name.'.'.g:quickmemo_suffix
  else
    let text = a:1
    let index = match(text,'\.\w\+$')
    if index == 0
      let filename = g:quickmemo_name . text
    elseif index >= 1
      let filename = text
    else
      let filename = text.'.'.g:quickmemo_suffix
    endif
  endif

  let path = expand(strftime(g:quickmemo_save_path),':p')
  if !isdirectory(path)
    " mkdir bug? 
    call mkdir(path[0:-2],"p") 
  endif
  exe "saveas " path . strftime(filename)
endfunction

function! quickmemo#list()
  exe "Unite" g:quickmemo_list_unite_source.':'.expand(strftime(g:quickmemo_list_path)) g:quickmemo_list_unite_option
endfunction

function! quickmemo#grep()
  exe "Unite grep:".expand(strftime(g:quickmemo_grep_path)) g:quickmemo_grep_unite_option
endfunction


let &cpo = s:cpo_save
" vim:set ft=vim ts=2 sw=2 sts=2:
