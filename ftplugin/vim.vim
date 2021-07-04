"=======================================================
" vim.vim -
" 
" Created by Haoyuan Li on 2021/07/04
" Last Modified: 2021/07/04 19:06:06
"=======================================================

"-------------------------------------------------------
" add file head
"-------------------------------------------------------
function! s:AddFileHead()
	call setline(1, '"=======================================================')
	call setline(2, '" ' . expand("%t") . ' -')
	call setline(3, '" ')
	call setline(4, '" Created by Haoyuan Li on ' . strftime("%Y/%m/%d"))
	call setline(5, '" Last Modified: ' . strftime("%Y/%m/%d %T"))
	call setline(6, '"=======================================================')
	execute "normal! j"
	execute "startinsert!"
endfunction

if line('$') == 1
        call s:AddFileHead()
endif

"-------------------------------------------------------
" comment title
"-------------------------------------------------------
" comment title
nnoremap <buffer> <M-C> :call AddCommentTitle('n')<CR>
inoremap <buffer> <M-C> <ESC>:call AddCommentTitle('i')<CR>

" comment subtitle
nnoremap <buffer> <M-c> :call AddCommentSubtitle('n')<CR>
inoremap <buffer> <M-c> <ESC>:call AddCommentSubtitle('i')<CR>

function! AddCommentTitle(mode)
        let l:cur_indent = indent('.')
        let l:str = ""
        while l:cur_indent > 0
                let l:str = l:str . " "
                let l:cur_indent -= 1
        endwhile
	let l:title = [l:str . "\"=======================================================",
		\ l:str . "\"",
		\ l:str . "\"======================================================="]
	if a:mode == 'n'       " normal mode
		call append(line('.'), l:title)
		execute "normal! 2j"
		execute "startinsert!"
	elseif a:mode == 'i'   " insert mode
		call setline(line('.'), l:title[0])
		call append(line('.'), l:title[1:-1])
		execute "normal! j"
		execute "startinsert!"
	endif
endfunction

function! AddCommentSubtitle(mode)
        let l:cur_indent = indent('.')
        let l:str = ""
        while l:cur_indent > 0
                let l:str = l:str . " "
                let l:cur_indent -= 1
        endwhile
	let l:title = [l:str . "\"-------------------------------------------------------",
		\ l:str . "\"",
		\ l:str . "\"-------------------------------------------------------"]
	if a:mode == 'n'       " normal mode
		call append(line('.'), l:title)
		execute "normal! 2j"
		execute "startinsert!"
	elseif a:mode == 'i'   " insert mode
		call setline(line('.'), l:title[0])
		call append(line('.'), l:title[1:-1])
		execute "normal! j"
		execute "startinsert!"
	endif
endfunction


"-------------------------------------------------------
" auto modify the Last Modified Time
"-------------------------------------------------------
function! s:ModifyTime()
	let l:cur_pos = getcurpos()
    call cursor(1, 1)
    let l:b = searchpos('"=', 'cn')
    let l:e = searchpos('"=', 'n')
    let l:t = search('Last Modified:')
    if l:b[0] < l:t && l:t < l:e[0] && l:b[1] == 1 && l:e[1] == 1
        execute l:b[0] . "," . l:t . "g/Last Modified:/s/Last Modified:.*/"
                    \ . "Last Modified: " . strftime("%Y\\/%m\\/%d %T")
    endif
	call cursor(l:cur_pos[1], l:cur_pos[2])
endfunction
autocmd BufWritePre,FileWritePre *.vim call s:ModifyTime()


let b:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", "`":"`", '```':'```',
        \ '"""':'"""', "'''":"'''"}