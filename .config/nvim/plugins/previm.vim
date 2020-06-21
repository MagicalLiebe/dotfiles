let g:previm_open_cmd = 'google-chrome'
autocmd BufRead,BufNewFile *.md  set filetype=markdown
nnoremap <silent> <Leader>p :PrevimOpen<CR>
let g:vim_markdown_folding_disabled=1
let g:previm_enable_realtime = 1
