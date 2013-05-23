function! TabLine()
  let s = '' " complete tabline goes here
  " loop through each tab page
  for t in range(tabpagenr('$'))
    " select the highlighting for the buffer names
    if t + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    " empty space
    let s .= ' '
    " set the tab page number (for mouse clicks)
    let s .= '%' . (t + 1) . 'T'
    " set page number string
    let s .= t + 1 . ': '
    " set file name
    let file = ''
    let buflist = tabpagebuflist(t +1)
    " find the number of modified files in a tab
    let m = 0
    for b in buflist
      " check and ++ tab's &modified count
      if getbufvar(b, "&modified")
        let m += 1
      endif
    endfor
    let winnr = tabpagewinnr(t + 1)
    let bufnr = buflist[winnr - 1]
    if getbufvar(bufnr, '&buftype') == 'help'
      let file .= '[H]' . fnamemodify(bufname(bufnr), ':t')
    elseif getbufvar(bufnr, '&buftype') == 'quickfix'
      let file .= '[Q]'
    else
      let file .= fnamemodify(bufname(bufnr), ':t')
    endif
    if getbufvar(bufnr, '&modified')
      let file .= '*'
    endif
    if m > 0
      let file .= '[' . m . '+]'
    endif
    if file == ''
      let s .= '[No Name]'
    else
      let s .= file
    endif
    let s .= ' '
    endfor
  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'
  return s
endfunction
