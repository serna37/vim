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

" status line
set ruler
set laststatus=2
let ff_table = {'dos' : 'CRLF', 'unix' : 'LF', 'mac' : 'CR' }
fu! SetStatusLine()
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
  retu '%' . c . '*[' . mode_name . ']%* %<%F%m%r%h%w%=%p%% %l/%L %02v [%{&fenc!=""?&fenc:&enc}][%{ff_table[&ff]}]'
endf
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
set shortmess-=S
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
nmap <Leader>gg :cal GrepCurrentExtention()<CR>
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

nnoremap <silent>* *N:cal HiSet()<CR>:cal Hitpop()<CR>
nnoremap <silent># *N:cal HiSet()<CR>:cal Hitpop()<CR>
nmap <silent><Leader>q :noh<CR>:cal clearmatches()<CR>:cal HiC()<CR>

" mark --------------------------------------------------
nmap <Leader>m :marks abcdefghijklmnopqrstuvwxyz<CR>:normal! `
nmap mm :cal Marking()<CR>
nmap mj :cal MarkHank("up")<CR>
nmap mk :cal MarkHank("down")<CR>

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
nmap <silent><C-u> :cal Scroll(scroll_up_key , 25)<CR>
nmap <silent><C-d> :cal Scroll(scroll_down_key , 25)<CR>
nmap <silent><C-b> :cal Scroll(scroll_up_key , 10)<CR>
nmap <silent><C-f> :cal Scroll(scroll_down_key , 10)<CR>

nmap <Leader>x :cal CloseBuf()<CR>
nmap <Leader>t :cal TerminalPop()<CR>

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
nmap <Leader><Leader>w :cal RunCat()<CR>
nmap <Leader><Leader>cc :cal ChangeColor()<CR>:colorscheme<CR>
nmap <Leader><Leader>ce :cal execute('top terminal ++shell eval ' . getline('.'))<CR>

" ========================================
" Function
" ========================================

" TODO refactor
" zihou timer ---------------------------------------
let s:ini_hour = localtime() / 3600
fu! Timer()
  let l:now_hour = localtime() / 3600
  if now_hour != s:ini_hour
    let s:ini_hour = now_hour
    cal ChangeColor()
    cal Zihou()
    cal timer_start(1000, { -> RunCat() })
  endif
endf

" less color, no plugin
" change color --------------------------------
"let s:colorscheme_arr_default = [
"    \ 'desert',
"    \ 'elflord',
"    \ 'evening',
"    \ 'habamax',
"    \ 'koehler',
"    \ 'slate',
"    \ 'torte'
"    \]
let s:colorscheme_arr_default = ['torte']
let s:colorscheme_arr = [
    \ 'hybrid_material',
    \ 'molokai',
    \ 'jellybeans',
    \ 'afterglow',
    \ 'alduin',
    \ 'apprentice'
    \ ]
fu! ChangeColor()
  if glob('~/.vim/pack/plugins/start') != ''
    execute('colorscheme ' . s:colorscheme_arr[localtime() % len(s:colorscheme_arr)])
  else
    execute('colorscheme ' . s:colorscheme_arr_default[localtime() % len(s:colorscheme_arr_default)])
    cal SetStatusLine()
  endif
endf
cal ChangeColor()

" grep ----------------------------------------
fu! GrepCurrentExtention()
  echo 'grep processing in [' . expand('%:e') .'] ...'
  execute('vimgrep /' . expand('<cword>') . '/gj **/*.' . expand('%:e'))
endf

command! -nargs=1 GrepExtFrom cal GrepExtFrom(<f-args>)
fu! GrepExtFrom(ext)
  echo 'grep processing in [' . a:ext .'] ...'
  execute('vimgrep /' . expand('<cword>') . '/gj **/*.' . a:ext)
endf

" highlight -----------------------------------
" on word, bright
aug auto_hl_cword
  au!
  au BufEnter,CmdwinEnter * cal HiCwordStart()
aug END
fu! HiCwordStart()
  aug QuickhlCword
    au!
    au! CursorMoved <buffer> cal HiCwordR()
    au! ColorScheme * cal HiCword()
  aug END
  cal HiCword()
endf
fu! HiCword()
  exe "hi link QuickhlCword Search"
endf
fu! HiCwordR()
  silent! 2match none
  exe "2mat QuickhlCword /\\\<". expand('<cword>') . "\\\>/"
endf

aug QuickhlManual
  au!
  au! ColorScheme * cal HlIni()
aug END
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
fu! HlIni()
  for v in g:search_hl
    exe "hi UserSearchHi" . index(g:search_hl, v) . " " . v
  endfor
endf
cal HlIni()

fu! HiSet() abort
  let cw = expand('<cword>')
  let already = ''
  for x in getmatches()
    if x["pattern"] == cw
      let already = x["id"]
    endif
  endfor
  if already != ''
    cal matchdelete(already)
    retu
  endif
  cal matchadd("UserSearchHi" . g:now_hi, cw)
  let g:now_hi = g:now_hi + 1
  if g:now_hi >= len(g:search_hl)
    let g:now_hi = 0
  endif
endf

" hitspop
let g:hitpopid = ''
fu! Hitpop()
  cal HiC()
  let g:hitpopid = popup_create(expand('<cword>'),
      \ #{ border: [], pos: "topleft", line: 1, col: &columns - 15 })
endf
fu! HiC()
  cal popup_clear(g:hitpopid)
endf




" mark ----------------------------------------
fu! Marking() abort
  let l:now_marks = []
  let l:words = 'abcdefghijklmnopqrstuvwxyz'
  let l:warr = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
        \ 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
  for row in split(execute('marks'), '\n')
    let l:r = filter(split(row, ' '), {i, v -> v != ''})
    if stridx(words, r[0]) != -1 && r[1] == line('.')
      execute('delmarks ' . r[0])
      cal MarkShow()
      echo 'delete mark'
      retu
    endif
    let l:now_marks = add(now_marks, r[0])
  endfor
  " start from b, not a. why??
  let l:can_use = filter(warr, {i, v -> stridx(join(now_marks, ''), v) == -1})
  if len(can_use) != 0
    execute('mark ' . can_use[0])
    cal MarkShow()
    echo 'marked'
  else
    echo 'over limit markable char'
  endif
endf

" like vim-signature
fu! MarkShow() abort
  cal sign_undefine()
  let l:words = 'abcdefghijklmnopqrstuvwxyz'
  let get_marks = ''
  try
    let get_marks = execute('marks ' . words)
  catch
    retu
  endtry
  let l:marks = split(get_marks, '\n')
  if len(marks) == 0
    retu
  endif
  cal remove(marks, 0)
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
endf
aug sig_aus
  au!
  au BufEnter,CmdwinEnter * cal MarkShow()
aug END

" TODO refactor
fu! MarkHank(vector) abort
  let l:words = 'abcdefghijklmnopqrstuvwxyz'
  let l:marks = split(execute('marks ' . words), '\n')
  cal remove(marks, 0)
  let mark_dict = {}
  let rownums = []
  for row in marks
    let l:r = filter(split(row, ' '), {i, v -> v != ''})
    let mark_dict[r[1]] = r[0]
    let rownums = add(rownums, r[1])
  endfor
  if a:vector == 'up'
    cal sort(rownums, {x, y -> x - y})
  endif
  if a:vector == 'down'
    cal sort(rownums, {x, y -> y - x})
  endif
  for rownum in rownums
    if a:vector == 'up' && rownum > line('.')
      exe "normal! `" . mark_dict[rownum]
      echo index(rownums, rownum) + 1 . "/" . len(rownums)
      retu
    endif
    if a:vector == 'down' && rownum < line('.')
      exe "normal! `" . mark_dict[rownum]
      echo len(rownums) - index(rownums, rownum) . "/" . len(rownums)
      retu
    endif
  endfor
  echo "last mark"
endf

" scroll ----------------------------------------
" like 'comfortable-motion.vim'
" like 'vim-auto-cursorline'
fu! Scroll(vector, delta)
  cal CursorToggle()
  let tmp = timer_start(a:delta, { -> NormalExe(a:vector) }, {'repeat': -1})
  cal timer_start(600, { -> timer_stop(tmp) })
  cal timer_start(600, { -> CursorToggle() })
endf
fu! NormalExe(aa)
  execute "normal! " . a:aa
endf
fu! CursorToggle()
  set cursorcolumn!
  set cursorline!
endf

" test sandwich
fu! TestSand()
  let cw = "'" . expand('<cword>') . "'"
  exe "normal! dw"
  exe "star" cw "stopi"
endf


" support F



" buffer --------------------------------------
fu! CloseBuf()
  let l:now_b = bufnr('%')
  bn
  execute('bd ' . now_b)
endf

" terminal ------------------------------------
fu! TerminalPop()
  cal popup_create(
        \ term_start([&shell], #{ hidden: 1, term_finish: 'close'}),
        \ #{ border: [], minwidth: &columns/2, minheight: &lines/2 })
endf

" favorite  -----------------------------------
command! -nargs=* Necronomicon cal Necronomicon(<f-args>)
fu! Necronomicon(...) abort
  if a:0 == 0
    e ~/.uranometria/necronomicon.md
    loadview
    retu
  elseif a:0 == 1 && a:1 == 'YogSothoth'
    execute('!sh ~/.uranometria/forge/backup.sh')
    retu
  elseif a:0 == 2 && a:1 == 'Azathoth' && a:2 == 'kill'
    bo terminal ++shell ++close sh ~/.uranometria/forge/kill.sh
    smile
    retu
  elseif a:0 == 1 && a:1 == 'Azathoth'
    bo terminal ++shell ++close sh ~/.uranometria/forge/omnibus.sh
    smile
    retu
  endif
endf

fu! Zihou()
  cal popup_create([
        \ strftime('%Y/%m/%d %H:%M (%A)', localtime()),
        \ '',
        \ 'colorscheme: ' . execute('colorscheme')
        \],
        \ #{border: [], zindex: 999, time: 3500})
endf

fu! RunCat()
  let l:delay = 250
  cal timer_start(delay * 0, { -> popup_create(s:running_cat[0], #{border: [], time: delay}) })
  cal timer_start(delay * 1, { -> popup_create(s:running_cat[1], #{border: [], time: delay}) })
  cal timer_start(delay * 2, { -> popup_create(s:running_cat[2], #{border: [], time: delay}) })
  cal timer_start(delay * 3, { -> popup_create(s:running_cat[3], #{border: [], time: delay}) })
  cal timer_start(delay * 4, { -> popup_create(s:running_cat[4], #{border: [], time: delay}) })
  cal timer_start(delay * 5, { -> popup_create(s:running_cat[0], #{border: [], time: delay}) })
  cal timer_start(delay * 6, { -> popup_create(s:running_cat[1], #{border: [], time: delay}) })
  cal timer_start(delay * 7, { -> popup_create(s:running_cat[2], #{border: [], time: delay}) })
  cal timer_start(delay * 8, { -> popup_create(s:running_cat[3], #{border: [], time: delay}) })
  cal timer_start(delay * 9, { -> popup_create(s:running_cat[4], #{border: [], time: delay}) })
endf
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

