" Globaly used functions for my vim scripts {{{
" function! TemplateDefaultSubstitutions() {{{
function! TemplateDefaultSubstitutions()
	exe "normal gg"
	let date = system("date")
	let date = strpart(date, 0, strlen(date) - 1)
	let user = system("whoami")
	let user = strpart(user, 0, strlen(user) - 1)
	let fname = expand("%")
	let fname = strpart(fname, 0, strlen(fname) - 1)
	exe "silent! :1,$s/#DATE/".date."/g"
	exe "silent! :1,$s/#USER/".user."/g"
	exe "silent! :1,$s/#FILE/".fname."/g"
endfunction
" }}}
" function! ReadTemplate(template) {{{
function! ReadTemplate(template)
	if(exists("g:VIM_templates_path"))
		let temp = g:VIM_templates_path . a:template
		let ok = filereadable(glob(temp))
	endif
	if((!ok) && (exists("g:VIM_templates_path_default")))
		let temp = g:VIM_templates_path_default . a:template
		let ok = filereadable(glob(temp))
	endif
	if(ok)
		exe "silent! 0r ".temp
	endif
	call TemplateDefaultSubstitutions()
endfunction
" }}}
" function! LoadGlobals() {{{
function! LoadGlobals()
	let macro_file = $VIM . "/commands/global.vim"
	if(glob(macro_file) == macro_file)
		set ei=FileType
		exe "so " . macro_file
		set ei=
	endif
	let macro_file = "~/.vim/commands/global.vim"
	if(filereadable(glob(macro_file)) == 1)
		set ei=FileType
		exe "so " . glob(macro_file)
		set ei=
	endif
endfunction
" }}}
" function! GenHeaderTemplate(fname) {{{
function! GenHeaderTemplate(fname)
	let sname = toupper(substitute(a:fname, "[-+./]", "_", "g"))
	exe "normal i#ifndef __".sname."__\<CR>#define __".sname."__\<CR>\<CR>#endif // __".sname."__"
endfunction
" }}}
" function! FileOperation(operation) {{{
function! FileOperation(operation)
	if(exists("b:VIM_function_prefix"))
		let func_name = b:VIM_function_prefix . a:operation
		if(exists("*".func_name))
			exe "call ".func_name."()"
		endif
	endif
endfunction
" }}}
" function! GenerateTemplate() {{{
function! GenerateTemplate()
    if(exists("g:VIM_read_templates") && (g:VIM_read_templates == 1))
		call FileOperation("Template")
	endif
	call Init()
	let b:VIM_new_file = 1
endfunction
" }}}
" function! SaveFilePost() {{{
function! SaveFilePost()
	if(exists("g:VIM_write_post") && (g:VIM_write_post == 1))
		call FileOperation("WritePost")
	endif
endfunction
" }}}
" function! SaveFilePre() {{{
function! SaveFilePre()
	if(exists("g:VIM_write_pre") && (g:VIM_write_pre == 1))
		call FileOperation("WritePre")
	endif
endfunction
" }}}
" function! Init() {{{
function! Init()
	if(exists("g:VIM_plugin_init") && (g:VIM_plugin_init == 1))
		syntax on
		set shiftwidth=4
		call LoadGlobals()
		call FileOperation("Init")
	endif
endfunction
" }}}
" function! LoadFilePost() {{{
function! LoadFilePost()
	if(exists("g:VIM_read_post") && (g:VIM_read_post == 1))
		call FileOperation("ReadPost")
	endif
endfunction
" }}}
" function! LoadFilePre() {{{
function! LoadFilePre()
	if(exists("g:VIM_read_pre") && (g:VIM_read_pre == 1))
		call FileOperation("ReadPre")
	endif
	call Init()
endfunction
" }}}
" function! GetFileExt(fname) {{{
function! GetFileExt(fname)
	return matchstr(a:fname, "[^.]*$")
endfunction
" }}}
" }}}
