let b:VIM_function_prefix = "C"
"
" function! HTemplate() {{{
function! HTemplate()
    let sname = toupper(substitute(expand("%"), "[-+./]", "_", "g"))
    exe "normal i#ifndef __".sname."__\<CR>#de__".sname."__\<CR>\<CR>#endif // __".sname."__"
endfunction
" }}}

" function! CTemplate() {{{
function! CTemplate()
	let f_ext = GetFileExt(expand("%"))
	if((f_ext == "h") || (f_ext == "hpp") || (f_ext == "hh"))
		call HTemplate()
	else
		call ReadTemplate("c-prog")
	endif
endfunction
" }}}

" function! CInit() {{{
function! CInit()
	set cindent
	set nowrap
endfunction
" }}}
