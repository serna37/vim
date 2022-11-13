" TODO hitspop

" ========================================
" Setting
" ========================================

" base editor
scriptencoding utf-8
"set ff=unix
"set fileencoding=utf8
set ttyfast
set noswapfile
set nobackup
set hidden
set autoread
set autoindent
set smartindent
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab
set virtualedit=onemore
set clipboard+=unnamed
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,],~

" fold
set foldmethod=indent
set foldlevel=4
set foldcolumn=3

" view
syntax on
set title
set showcmd
set number
au ModeChanged [vV\x16]*:* let &l:rnu = mode() =~# '^[vV\x16]'
au ModeChanged *:[vV\x16]* let &l:rnu = mode() =~# '^[vV\x16]'
set cursorline
set cursorcolumn
set showmatch
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set ambiwidth=double
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=grey
endfunction
if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme * call ZenkakuSpace()
    autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
  augroup END
  call ZenkakuSpace()
endif

" status line
set ruler
set laststatus=2
let ff_table = {'dos' : 'CRLF', 'unix' : 'LF', 'mac' : 'CR' }
function! SetStatusLine()
  hi User1 cterm=bold ctermbg=5 ctermfg=0
  hi User2 cterm=bold ctermbg=2 ctermfg=0
  hi User3 cterm=bold ctermbg=5 ctermfg=0
  hi User4 cterm=bold ctermbg=7 ctermfg=0
  hi User5 cterm=bold ctermbg=1 ctermfg=0
  if mode() =~ 'i'
    let c = 1
    let mode_name = 'INSERT'
  elseif mode() =~ 'n'
    let c = 2
    let mode_name = 'NORMAL'
  elseif mode() =~ 'R'
    let c = 3
    let mode_name = 'REPLACE'
  elseif mode() =~ 'c'
    let c = 4
    let mode_name = 'COMMAND'
  else
    let c = 5
    let mode_name = 'VISUAL'
  endif
  return '%' . c . '*[' . mode_name . ']%* %<%F%m%r%h%w%=%p%% %l/%L %02v [%{&fenc!=""?&fenc:&enc}][%{ff_table[&ff]}]'
endfunction
set statusline=%!SetStatusLine()

" explorer
set splitright
filetype plugin on
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 70

" search
set incsearch
set hlsearch
set ignorecase
set smartcase
au QuickFixCmdPost *grep* cwindow

" completion
set wildmenu
set wildmode=full
set complete=.,w,b,u,U,k,kspell,s,i,d,t
set completeopt=menuone,noinsert,preview,popup

" ========================================
" KeyMap
" ========================================

" base ---------------------------------------
let g:mapleader = "\<Space>"

" exploere  ---------------------------------------
nmap <Leader>e :30Ve<CR>

" file search ---------------------------------------
nmap <Leader>f :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
if has('win32unix')
  nmap <Leader>f :CtrlP<CR>
  nmap <Leader>b :CtrlPBuffer<CR>
  nmap <Leader>h :CtrlPMRUFiles<CR>
endif

" grep ---------------------------------------
nmap <Leader>gg :call GrepCurrentExtention()<CR>
nmap <Leader>ge :GrepExtFrom 

" lsp
nmap <Leader>j :LspHover<CR>
nmap <Leader>p :LspPeekDefinition<CR>
nmap <Leader>o :LspDefinition<CR>
nmap <Leader>r :LspReferences<CR>

" jump ---------------------------------------
nmap s <Plug>(easymotion-bd-w)w
nmap <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>s <Plug>(easymotion-sn)

nnoremap * *N:call HiSet()<CR>
nnoremap # *N:call HiSet()<CR>
nmap <Leader>q :noh<CR>:call clearmatches()<CR>

" mark --------------------------------------------------
nmap <Leader>m :marks abcdefghijklmnopqrstuvwxyz<CR>:normal! `
nmap mm :call Marking()<CR>
nmap mj :call MarkHank("up")<CR>
nmap mk :call MarkHank("down")<CR>

" window ---------------------------------------
nnoremap j gj
nnoremap k gk

" like 'simeji/winresizer'
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j

nnoremap <S-h> 2<C-w><
nnoremap <S-l> 2<C-w>>
nnoremap <S-k> 2<C-w>-
nnoremap <S-j> 2<C-w>+

" like 'comfortable-motion.vim'
" like 'vim-auto-cursorline'
let g:scroll_up_key = "\<C-y>"
let g:scroll_down_key = "\<C-e>"
nmap <silent><C-u> :call Scroll(scroll_up_key , 25)<CR>
nmap <silent><C-d> :call Scroll(scroll_down_key , 25)<CR>
nmap <silent><C-b> :call Scroll(scroll_up_key , 10)<CR>
nmap <silent><C-f> :call Scroll(scroll_down_key , 10)<CR>

nmap <Leader>x :call CloseBuf()<CR>
nmap <Leader>t :call TerminalPop()<CR>

" snip
nmap <Leader>0 :VsnipOpen<CR>

" edit ---------------------------------------
"nmap za <Plug>(sandwich-add)
"nmap zd <Plug>(sandwich-delete)
"nmap zr <Plug>(sandwich-replace)

" asyncomplete
imap <expr> <Tab> pumvisible() ? '<C-n>' : vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-n>'
inoremap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'
inoremap <expr> <CR> pumvisible() ? '<C-y>' : '<CR>'

" favorite ---------------------------------------
nmap <Leader><Leader>n :Necronomicon 
nmap <Leader><Leader>w :call RunCat()<CR>
nmap <Leader><Leader>cc :call ChangeColor()<CR>:colorscheme<CR>
nmap <Leader><Leader>ce :call execute('top terminal ++shell eval ' . getline('.'))<CR>

" ========================================
" Function
" ========================================

" TODO refactor
" zihou timer ---------------------------------------
let s:ini_hour = localtime() / 3600
function! Timer()
  let l:now_hour = localtime() / 3600
  if now_hour != s:ini_hour
    let s:ini_hour = now_hour
    call ChangeColor()
    call Zihou()
    call timer_start(1000, { -> RunCat() })
  endif
endfunction

" less color, no plugin
" change color --------------------------------
let s:colorscheme_arr_default = [
    \ 'desert',
    \ 'elflord',
    \ 'evening',
    \ 'habamax',
    \ 'koehler',
    \ 'slate',
    \ 'torte'
    \]
let s:colorscheme_arr = [
    \ 'hybrid_material',
    \ 'molokai',
    \ 'jellybeans',
    \ 'afterglow',
    \ 'alduin',
    \ 'apprentice'
    \ ]
function! ChangeColor()
  if glob('~/.vim/pack/plugins/start') != ''
    execute('colorscheme ' . s:colorscheme_arr[localtime() % len(s:colorscheme_arr)])
  else
    execute('colorscheme ' . s:colorscheme_arr_default[localtime() % len(s:colorscheme_arr_default)])
    call SetStatusLine()
  endif
endfunction
call ChangeColor()

" grep ----------------------------------------
function! GrepCurrentExtention()
  echo 'grep processing in [' . expand('%:e') .'] ...'
  execute('vimgrep /' . expand('<cword>') . '/gj **/*.' . expand('%:e'))
endfunction

command! -nargs=1 GrepExtFrom call GrepExtFrom(<f-args>)
function! GrepExtFrom(ext)
  echo 'grep processing in [' . a:ext .'] ...'
  execute('vimgrep /' . expand('<cword>') . '/gj **/*.' . a:ext)
endfunction

" highlight -----------------------------------
augroup QuickhlManual
  autocmd!
  autocmd! ColorScheme * call HlIni()
augroup END
let g:search_hl= [
    \ "cterm=bold ctermfg=16 ctermbg=153 gui=bold guifg=#ffffff guibg=#0a7383",
    \ "cterm=bold ctermfg=7  ctermbg=1   gui=bold guibg=#a07040 guifg=#ffffff",
    \ "cterm=bold ctermfg=7  ctermbg=2   gui=bold guibg=#4070a0 guifg=#ffffff",
    \ "cterm=bold ctermfg=7  ctermbg=3   gui=bold guibg=#40a070 guifg=#ffffff",
    \ "cterm=bold ctermfg=7  ctermbg=4   gui=bold guibg=#70a040 guifg=#ffffff",
    \ "cterm=bold ctermfg=7  ctermbg=5   gui=bold guibg=#0070e0 guifg=#ffffff",
    \ "cterm=bold ctermfg=7  ctermbg=6   gui=bold guibg=#007020 guifg=#ffffff",
    \ "cterm=bold ctermfg=7  ctermbg=21  gui=bold guibg=#d4a00d guifg=#ffffff",
    \ "cterm=bold ctermfg=7  ctermbg=22  gui=bold guibg=#06287e guifg=#ffffff",
    \ "cterm=bold ctermfg=7  ctermbg=45  gui=bold guibg=#5b3674 guifg=#ffffff",
    \ "cterm=bold ctermfg=7  ctermbg=16  gui=bold guibg=#4c8f2f guifg=#ffffff",
    \ "cterm=bold ctermfg=7  ctermbg=50  gui=bold guibg=#1060a0 guifg=#ffffff",
    \ "cterm=bold ctermfg=7  ctermbg=56  gui=bold guibg=#a0b0c0 guifg=black",
    \ ]
let g:now_hi = 0
function! HlIni()
  for v in g:search_hl
    exe "hi UserSearchHi" . index(g:search_hl, v) . " " . v
  endfor
endfunction

function! HiSet() abort
  let cw = expand('<cword>')
  let already = ''
  for x in getmatches()
    if x["pattern"] == cw
      let already = x["id"]
    endif
  endfor
  if already != ''
    call matchdelete(already)
    return
  endif
  call matchadd("UserSearchHi" . g:now_hi, cw)
  let g:now_hi = g:now_hi + 1
  if g:now_hi >= len(g:search_hl)
    let g:now_hi = 0
  endif
endfunction

" mark ----------------------------------------
function! Marking() abort
  let l:now_marks = []
  let l:words = 'abcdefghijklmnopqrstuvwxyz'
  let l:warr = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
        \ 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
  for row in split(execute('marks'), '\n')
    let l:r = filter(split(row, ' '), {i, v -> v != ''})
    if stridx(words, r[0]) != -1 && r[1] == line('.')
      execute('delmarks ' . r[0])
      call MarkShow()
      echo 'delete mark'
      return
    endif
    let l:now_marks = add(now_marks, r[0])
  endfor
  " start from b, not a. why??
  let l:can_use = filter(warr, {i, v -> stridx(join(now_marks, ''), v) == -1})
  if len(can_use) != 0
    execute('mark ' . can_use[0])
    call MarkShow()
    echo 'marked'
  else
    echo 'over limit markable char'
  endif
endfunction

" like vim-signature
function! MarkShow() abort
  call sign_undefine()
  let l:words = 'abcdefghijklmnopqrstuvwxyz'
  let get_marks = ''
  try
    let get_marks = execute('marks ' . words)
  catch
    return
  endtry
  let l:marks = split(get_marks, '\n')
  if len(marks) == 0
    return
  endif
  call remove(marks, 0)
  let mark_dict = {}
  let rownums = []
  for row in marks
    let l:r = filter(split(row, ' '), {i, v -> v != ''})
    let mark_dict[r[1]] = r[0]
    let rownums = add(rownums, r[1])
  endfor
  for row in rownums
    exe "sign define " . row . " text=" . mark_dict[row] . " texthl=ErrorMsg"
    exe "sign place " . row . " line=" . row . " name=" . row . " file=" . expand("%:p")
  endfor
endfunction
if has('autocmd')
  augroup sig_autocmds
    autocmd!
    autocmd BufEnter,CmdwinEnter * call MarkShow()
    "BufEnter,CmdwinEnter * call MarkShow()
  augroup END
endif

function! MarkHank(vector) abort
  let l:words = 'abcdefghijklmnopqrstuvwxyz'
  let l:marks = split(execute('marks ' . words), '\n')
  call remove(marks, 0)
  let rownums = []
  for row in marks
    let l:r = filter(split(row, ' '), {i, v -> v != ''})
    let rownums = add(rownums, r[1])
  endfor
  if a:vector == 'up'
    call sort(rownums, {x, y -> x - y})
  endif
  if a:vector == 'down'
    call sort(rownums, {x, y -> y - x})
  endif
  for rownum in rownums
    if a:vector == 'up' && rownum > line('.')
      execute "normal! " . rownum . 'G'
      echo index(rownums, rownum) + 1 . "/" . len(rownums)
      return
    endif
    if a:vector == 'down' && rownum < line('.')
      execute "normal! " . rownum . 'G'
      echo len(rownums) - index(rownums, rownum) . "/" . len(rownums)
      return
    endif
  endfor
  echo "last mark"
endfunction

" scroll ----------------------------------------
" like 'comfortable-motion.vim'
" like 'vim-auto-cursorline'
function! Scroll(vector, delta)
  call CursorToggle()
  let tmp = timer_start(a:delta, { -> NormalExe(a:vector) }, {'repeat': -1})
  call timer_start(600, { -> timer_stop(tmp) })
  call timer_start(600, { -> CursorToggle() })
endfunction
function! NormalExe(aa)
  execute "normal! " . a:aa
endfunction
function! CursorToggle()
  set cursorcolumn!
  set cursorline!
endfunction

" test sandwich
function! TestSand()
  let cw = "'" . expand('<cword>') . "'"
  exe "normal! dw"
  exe "star" cw "stopi"
endfunction

" buffer --------------------------------------
function! CloseBuf()
  let l:now_b = bufnr('%')
  bn
  execute('bd ' . now_b)
endfunction

" terminal ------------------------------------
function! TerminalPop()
  call popup_create(
        \ term_start([&shell], #{ hidden: 1, term_finish: 'close'}),
        \ #{ border: [], minwidth: &columns/2, minheight: &lines/2 })
endfunction

" favorite  -----------------------------------
command! -nargs=* Necronomicon call Necronomicon(<f-args>)
function! Necronomicon(...) abort
  if a:0 == 0
    e ~/.uranometria/necronomicon.md
    loadview
    return
  elseif a:0 == 1 && a:1 == 'YogSothoth'
    execute('!sh ~/.uranometria/forge/backup.sh')
    return
  elseif a:0 == 2 && a:1 == 'Azathoth' && a:2 == 'kill'
    bo terminal ++shell ++close sh ~/.uranometria/forge/kill.sh
    smile
    return
  elseif a:0 == 1 && a:1 == 'Azathoth'
    bo terminal ++shell ++close sh ~/.uranometria/forge/omnibus.sh
    smile
    return
  endif
endfunction

function! Zihou()
  call popup_create([
        \ strftime('%Y/%m/%d %H:%M (%A)', localtime()),
        \ '',
        \ 'colorscheme: ' . execute('colorscheme')
        \],
        \ #{border: [], zindex: 999, time: 3500})
endfunction

function! RunCat()
  let l:delay = 250
  call timer_start(delay * 0, { -> popup_create(s:running_cat[0], #{border: [], time: delay}) })
  call timer_start(delay * 1, { -> popup_create(s:running_cat[1], #{border: [], time: delay}) })
  call timer_start(delay * 2, { -> popup_create(s:running_cat[2], #{border: [], time: delay}) })
  call timer_start(delay * 3, { -> popup_create(s:running_cat[3], #{border: [], time: delay}) })
  call timer_start(delay * 4, { -> popup_create(s:running_cat[4], #{border: [], time: delay}) })
  call timer_start(delay * 5, { -> popup_create(s:running_cat[0], #{border: [], time: delay}) })
  call timer_start(delay * 6, { -> popup_create(s:running_cat[1], #{border: [], time: delay}) })
  call timer_start(delay * 7, { -> popup_create(s:running_cat[2], #{border: [], time: delay}) })
  call timer_start(delay * 8, { -> popup_create(s:running_cat[3], #{border: [], time: delay}) })
  call timer_start(delay * 9, { -> popup_create(s:running_cat[4], #{border: [], time: delay}) })
endfunction
let s:running_cat = [
    \[
    \ '                                                            ',
    \ '                               =?7I=~             ~~        ',
    \ '                            =NMMMMMMMMMD+      :+OMO:       ',
    \ '                          ~NMMMMMMMMMMMMMMMNNMMMMMMMM=      ',
    \ '                        :DMMMMMMMMMMMMMMMMMMMMMMMMMMMN=     ',
    \ '                      IMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM8:     ',
    \ '                  :$MMMMMMMMMMMMMMMMMMMMMMMMMMMM?           ',
    \ '             :~ZMMMMMNI :DMMMMMMMMMMMMMMMMMNN$:             ',
    \ '       :+8NMMMMMMMO~     =NMMMMMMM?  +MMD~                  ',
    \ '     8MMMMMMM8+:           :?OMMMM+ =NMM~                   ',
    \ '                             :DMMZ  7MM+                    ',
    \ '                              ?NMMMMMMD:                    ',
    \ '                                 :?777~                     ',
    \],
    \[
    \ '                                                            ',
    \ '                                                     :O~    ',
    \ '                                          +I777ZDNMMMMMI    ',
    \ '                        :+Z8DDDNNNNDD88NMMMMMMMMMMMMMMMM$   ',
    \ '                     +DMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM=  ',
    \ '                  :$MMMMMMMMMMMMMMMMMMMMMMMMMMMMMN888DMM8:  ',
    \ '                :OMMMMMMMMMMMMMMMMMMMMMMMMMMMMMD            ',
    \ '              ?NMMMMMMMMMMMMMMMMMMMMMMMMD?~=DMMMI           ',
    \ '    7MMMMMMMMMMMMZ+NMMMMMMMMMNNNNN87?~: +NDDMMN~            ',
    \ '     ~?$OZZI=:   7MMMMMMMMMN=            =DM8:              ',
    \ '                  8MMN888$:                                 ',
    \ '                  :DMMD$                                    ',
    \ '                    =7$=                                    ',
    \],
    \[
    \ '                                                            ',
    \ '                                                            ',
    \ '                         ~~++?????IIIIIIII7$77I?+I$$77OD:   ',
    \ '              ~7ODNNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM7   ',
    \ '         ~ZNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM?  ',
    \ '      :$MMMMZ=?MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM$  ',
    \ '    =NMM8~  :OMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM8: :~77   ',
    \ '  =NMM+  :DMMMMMMMMMMMMMN+     :=OMMMMMMMMMMD$8MMMMMD?      ',
    \ ' OMN=  ?NMMMMMMMMMMNZ+::             ::~::      IMMMMMMM$   ',
    \ ' ::  ZMMMMMMN?:                                =MMO:  =$~   ',
    \ '    ~8Z~DMN=                                                ',
    \ '                                                            ',
    \ '                                                            ',
    \],
    \[
    \ '                                                            ',
    \ '                      :IZOZI:                               ',
    \ '                   INMMMMMMMMMD+                     ?:     ',
    \ '                =DMMMMMMMMMMMMMMMM8$II7$OO87:  :=ODDMM+     ',
    \ '             :OMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM8    ',
    \ '           =NMMD+ 8MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMI   ',
    \ '        :8MMMZ7DDDMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM7   ',
    \ '      +NMMM7 ~MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM7           ',
    \ '   :7MMMM7   +MMNMMMMM$: :?8NNMMMMMMMMMMNNMMMMMN:           ',
    \ '  =DMMN?    :8MM~  :                      :8MMMMMMMMN8?:    ',
    \ '   =~      8MMM7                             ?8MMMD+?ZNM?   ',
    \ '            +~                                  :$NMMN7     ',
    \ '                                                   :IDD=    ',
    \],
    \[
    \ '                                                            ',
    \ '                            ~~:                             ',
    \ '                        =ONMMMMMMD$~                        ',
    \ '                     +8MMMMMMMMMMMMMNZ:           :         ',
    \ '                  ~8MMMMMMMMMMMMMMMMMMMMDD8DDDNDDM8         ',
    \ '               =OMMMM$DMMMMMMMMMMMMMMMMMMMMMMMMMMMM+        ',
    \ '           :OMMMMNI:  NMMMMMMM$ZNMMMMMMMMMMMMMMMMMM8:       ',
    \ '        ~DMMMNI:    :NMMMMMMMZ   =NMMMMMMMMMMMMMMMMM=       ',
    \ '      =NMMN+         OMMMMMD~      :ZNMMMMMMMMO  :+:        ',
    \ '      :?=:            +MM?            7MM8 +NMMMI:          ',
    \ '                       :NM8=           ZM$    :ZNMMMD       ',
    \ '                         ?$=           :DMO:       II       ',
    \ '                                        :I+                 ',
    \]
\]

