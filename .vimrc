" Read functions 
so ~/.vim/global.vim
" Setup variables used by autocommands
let g:VIM_read_templates = 1
let g:VIM_write_post = 1
let g:VIM_write_pre = 1
let g:VIM_plugin_init = 1
let g:VIM_read_post = 1
let g:VIM_read_pre = 1

" Setup paths where templates are stored
let g:VIM_templates_path_default = $VIM . "/template/"
let g:VIM_templates_path = $HOME . "/.vim/template/"

" Definitions of automatic actions {{{
if has("autocmd")
	augroup all
		au!
		autocmd BufNewFile * call GenerateTemplate()
		autocmd BufWritePre * call SaveFilePre()
		autocmd BufWritePost * call SaveFilePost()
		autocmd BufReadPre * call LoadFilePre()
		autocmd BufReadPost * call LoadFilePost()
	augroup END
endif
" }}}
