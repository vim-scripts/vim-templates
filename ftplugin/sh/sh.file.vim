let b:VIM_function_prefix = "SH"

" function! SHTemplate() {{{
function! SHTemplate()
	call ReadTemplate("bash")
endfunction
" }}}

" function! SHWritePost() {{{
function! SHWritePost()
	if(exists("b:VIM_new_file"))
		exe "silent! !chmod u+x %"
	endif
endfunction
" }}}
