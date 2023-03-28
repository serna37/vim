" vim:set foldmethod=marker:
" ========================================
" Setting
" ========================================
" {{{
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
set foldmethod=marker
set foldlevel=0
set foldlevelstart=0
set foldcolumn=1
" view
syntax on
set re=0
set background=dark
set scrolloff=5
set title
set showcmd
set number
set cursorline
set cursorcolumn
set showmatch
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set ambiwidth=double
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END" status line
set ruler
set laststatus=2
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
" }}}

" ========================================
" KeyMap
" ========================================
" {{{
let g:mapleader = "\<Space>"
" search ---------------------------------------
nnoremap <silent>* *N<Plug>(quickhl-manual-this)
nnoremap <silent># *N<Plug>(quickhl-manual-this)
nnoremap <silent><Leader>q <Plug>(quickhl-manual-reset):noh<CR>
" move ---------------------------------------
nnoremap j gj
nnoremap k gk
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <Left> 4<C-w><
nnoremap <Right> 4<C-w>>
nnoremap <Up> 4<C-w>-
nnoremap <Down> 4<C-w>+
nnoremap <silent><C-u> :cal Scroll(0, 25)<CR>
nnoremap <silent><C-d> :cal Scroll(1, 25)<CR>
nnoremap <silent><C-b> :cal Scroll(0, 10)<CR>
nnoremap <silent><C-f> :cal Scroll(1, 10)<CR>
nnoremap <silent><Leader>t :bo terminal ++rows=10<CR>
nnoremap <silent><Leader>tp :call popup_create(term_start([&shell], #{ hidden: 1, term_finish: 'close'}), #{ border: [], minwidth: &columns/2, minheight: &lines/2 })<CR>
" language ----------------------------------------
nnoremap <Leader>d <Plug>(coc-definition)
nnoremap <Leader>r <plug>(coc-references)
nnoremap <Leader>v :cal IDEActions()<CR>
fu! IDEActions()
  echo 'rename: ReNaming'
  echo 'format: Format'
  echo 'run: Run'
  let cmd = inputdialog(">>")
  if cmd == ''
    retu
  endif
  echo '<<'
  if cmd == 'rename'
    cal CocActionAsync('rename')
    echo 'ok'
  elseif cmd == 'format'
    cal CocActionAsync('format')
    echo 'ok'
  elseif cmd == 'run'
    exe "QuickRun -hook/time/enable 1"
  endif
endf
nnoremap <Leader>? :cal CocAction('doHover')<CR>
nnoremap <Leader>, <plug>(coc-diagnostic-next)
nnoremap <Leader>. <plug>(coc-diagnostic-prev)
nnoremap <Leader>sh :cal execute('top terminal ++rows=10 ++shell eval ' . getline('.'))<CR>
" edit ---------------------------------------
nnoremap d "_d
vnoremap d "_d
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>l
inoremap <C-k> <C-o>k
inoremap <C-j> <C-o>j
vnoremap <C-j> "zx"zp`[V`]
vnoremap <C-k> "zx<Up>"zP`[V`]
" completion ---------------------------------------
inoremap <expr> <CR> pumvisible() ? '<C-y>' : '<CR>'
inoremap <expr> <Tab> '<C-n>'
inoremap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'
if glob('~/.vim/pack/plugins/start/coc.nvim') != '' " for coc
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
  inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
  inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
  let g:coc_snippet_next = '<Tab>'
  let g:coc_snippet_prev = '<S-Tab>'
endif
if glob('~/.vim/pack/plugins/start/vim-vsnip') != '' " for vsnip
  inoremap <silent><expr> <C-s> vsnip#available(1) ? "<Plug>(vsnip-expand-or-jump)" : "\<C-s>"
  inoremap <silent><expr> <C-w> vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "\<C-w>"
endif
" filer ---------------------------------------
if glob('~/.vim/pack/plugins/start/nerdtree') != ''
  let g:NERDTreeShowBookmarks = 1
  let g:NERDTreeShowHidden = 1
  nnoremap <silent><Leader>e :NERDTreeToggle<CR>
  nnoremap <silent><Leader><Leader>e :NERDTreeFind<CR>zz
endif
" func - fzf ---------------------------------------batコマンドでsyntax hilight
nnoremap <silent><leader>f :cal FzfStart()<CR>
if glob('~/.vim/pack/plugins/start/fzf.vim') != ''
  set rtp+=~/.vim/pack/plugins/start/fzf
  nnoremap <silent><leader>f :Files<CR>
  nnoremap <silent><leader>h :History<CR>
  nnoremap <silent><leader>b :Buffers<CR>
  " if git repo, ref .gitignore
  let gitroot = system('git rev-parse --show-superproject-working-tree --show-toplevel')
  if v:shell_error
    nnoremap <silent><leader>f :Files<CR>
  else
    nnoremap <silent><leader>f :GFiles<CR>
  endif
endif
" airline ---------------------------------------
if glob('~/.vim/pack/plugins/start/vim-airline') != ''
  let g:airline_theme = 'deus'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
  let g:airline_highlighting_cache = 1
  function! CloseBuf()
    let l:now_b = bufnr('%')
    bn
    execute('bd ' . now_b)
  endfunction
  nnoremap <silent><C-p> :bn<CR>
  nnoremap <silent><C-q> :bp<CR>
  nnoremap <silent><Leader>x :call CloseBuf()<CR>
endif

" func - grep ---------------------------------------
nnoremap <silent><Leader>g :cal GrepChoseMode()<CR>
" func - god speed ---------------------------------------
nnoremap <silent><Tab> :cal MarkHank("down", g:mark_words_auto)<CR>
nnoremap <silent><S-Tab> :cal MarkHank("up", g:mark_words_auto)<CR>
nnoremap <silent><Leader>w <plug>(QuickScopeToggle):cal MarkFieldOut()<CR>
" func - mark ---------------------------------------
nnoremap <silent><Leader>m :cal MarkMenu()<CR>
nnoremap <silent>mm :cal Marking()<CR>
nnoremap <silent>mj :cal MarkHank("down", g:mark_words_manual)<CR>
nnoremap <silent>mk :cal MarkHank("up", g:mark_words_manual)<CR>
nnoremap <silent>mw :cal HiSet()<CR>
" favorite ---------------------------------------
nmap <Leader>z :Goyo<CR>:set number<CR>
nmap <Leader>l :Limelight!!<CR>
nnoremap <Leader>n :Necronomicon 
nnoremap <Leader><Leader><Leader> :15sp ~/forge/cheat_sheet.md<CR>
" }}}

" ========================================
" Function
" ========================================
  " grep ----------------------------------------{{{
fu! GrepChoseMode() abort
  echo 'mode 0: This File'
  echo 'mode 1: FULL AUTO [current ext, current word, current git root(no git -> current directory)]'
  echo 'mode 2: MANUAL EXT [Manual ext, current word, current git root(no git -> current directory)]'
  echo 'mode 3: ALL MANUAL [Manual ext, Manual word, Manual directory]'
  let mode = inputdialog("Enter [mode]>>")
  if mode == ''
    retu
  endif
  echo '<<'
  cal GrepExtFrom(mode)
endf
fu! GrepExtFrom(mode) abort
  if a:mode == 0 " this file
    echo 'grep from this file.'
    let word = inputdialog("Enter [word]>>")
    echo '<<'
    echo 'grep [' . word . '] processing in [' . expand('%') . '] ...'
    cal execute('vimgrep /' . word . '/gj %') | cw
    echo 'grep end'
    retu
  elseif a:mode == 1 " current ext, current word, current git root(no git -> current directory)
    let ext = expand('%:e')
    let word = expand('<cword>')
    let target = CurrentGitRoot()
  elseif a:mode == 2 " manual ext, current word, current git root(no git -> current directory)
    echo 'grep ['.expand('<cword>').'] from repo/*. choose [ext]'
    let ext = inputdialog("Enter [ext]>>")
    let word = expand('<cword>')
    let target = CurrentGitRoot()
  elseif a:mode == 3 " manual ext, manual word, manual directory
    echo 'grep. choose [ext] [word] [target]'
    let pwd = system('pwd')
    let ext = inputdialog("Enter [ext]>>")
    echo '<<'
    let word = inputdialog("Enter [word]>>")
    echo '<<'
    let target = inputdialog("Enter [target (like ./*) pwd:".pwd."]>>")
    let target = target == '' ? './*' : target
    echo '<<'
  endif
  echo 'grep [' . word . '] processing in [' . target . '] [' . ext . '] ...'
  cgetexpr system('grep -n -r --include="*.' . ext . '" "' . word . '" ' . target) | cw
  echo 'grep end'
endf

fu! CurrentGitRoot() " current git root(no git -> current directory)
  let pwd = system('pwd')
  exe 'lcd %:h'
  let gitroot = system('git rev-parse --show-superproject-working-tree --show-toplevel')
  exe 'lcd ' . pwd
  retu !v:shell_error ? gitroot[0:strlen(gitroot)-2] . '/*' : './*'
endf " }}}

" mark ----------------------------------------{{{
let g:mark_words = 'abcdefghijklmnopqrstuvwxyz'
let g:mark_words_manual = 'abcdefghijklm'
let g:mark_words_auto = 'nopqrstuvwxyz'
fu! s:get_mark(tar) abort
  try
    retu execute('marks ' . a:tar)
  catch
    retu ''
  endtry
endf

fu! MarkMenu() abort " show mark list and jump {{{
  let get_marks = s:get_mark(g:mark_words_manual)
  if get_marks == ''
    echo 'no marks'
    retu
  endif
  let markdicarr = []
  for v in split(get_marks , '\n')[1:]
    cal add(markdicarr, {'linenum': str2nr(filter(split(v, ' '), { i,v -> v != '' })[1]), 'val': v})
  endfor
  cal sort(markdicarr, { x, y -> x['linenum'] - y['linenum'] })
  let marks_this = map(markdicarr, { i,v -> v['val'] })
  cal popup_menu(marks_this, #{ title: 'choose marks', border: [], zindex: 100, minwidth: &columns/2, maxwidth: &columns/2, minheight: 2, maxheight: &lines/2, filter: function('MarkChoose', [{'idx': 0, 'files': marks_this}]) })
endf

fu! MarkChoose(ctx, winid, key) abort
  if a:key is# 'j' && a:ctx.idx < len(a:ctx.files)-1
    let a:ctx.idx = a:ctx.idx+1
  elseif a:key is# 'k' && a:ctx.idx > 0
    let a:ctx.idx = a:ctx.idx-1
  elseif a:key is# "\<CR>"
    execute('normal!`' . a:ctx.files[a:ctx.idx][1])
  endif
  retu popup_filter_menu(a:winid, a:key)
endf " }}}

fu! Marking() abort " mark auto word, toggle {{{
  let get_marks = s:get_mark(g:mark_words_manual)
  if get_marks == ''
    execute('mark a')
    cal MarkShow()
    echo 'marked'
    retu
  endif
  let l:now_marks = []
  let l:warr = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm']
  for row in split(get_marks , '\n')[1:]
    let l:r = filter(split(row, ' '), {i, v -> v != ''})
    if stridx(g:mark_words, r[0]) != -1 && r[1] == line('.')
      cal MarkSignDel()
      execute('delmarks ' . r[0])
      cal MarkShow()
      echo 'delete mark '.r[0]
      retu
    endif
    let l:now_marks = add(now_marks, r[0])
  endfor
  let l:can_use = filter(warr, {i, v -> stridx(join(now_marks, ''), v) == -1})
  if len(can_use) != 0
    cal MarkSignDel()
    execute('mark ' . can_use[0])
    cal MarkShow()
    echo 'marked '.can_use[0]
  else
    echo 'over limit markable char'
  endif
endf" }}}

fu! MarkSignDel() " delete sign on mark {{{
  let get_marks = s:get_mark(g:mark_words)
  if get_marks == ''
    retu
  endif
  let mark_dict = {}
  for row in split(get_marks, '\n')[1:]
    let l:r = filter(split(row, ' '), {i, v -> v != ''})
    let mark_dict[r[0]] = r[1]
  endfor
  for mchar in keys(mark_dict)
    let id = stridx(g:mark_words, mchar) + 1
    exe "sign unplace " . id . " file=" . expand("%:p")
    exe "sign undefine " . mchar
  endfor
endf " }}}

fu! MarkShow() abort " show marks on row {{{
  let get_marks = s:get_mark(g:mark_words)
  if get_marks == ''
    retu
  endif
  let mark_dict = {}
  for row in split(get_marks, '\n')[1:]
    let l:r = filter(split(row, ' '), {i, v -> v != ''})
    let mark_dict[r[0]] = r[1]
  endfor
  for mchar in keys(mark_dict)
    let id = stridx(g:mark_words, mchar) + 1
    let txt = stridx(g:mark_words_auto, mchar) != -1 ? "=" : mchar
    let txthl = stridx(g:mark_words_auto, mchar) != -1 ? "CursorLineNr" : "ErrorMsg"
    exe "sign define " . mchar . " text=" . txt . " texthl=" . txthl
    exe "sign place " . id . " line=" . mark_dict[mchar] . " name=" . mchar . " file=" . expand("%:p")
  endfor
endf
aug sig_aus
  au!
  au BufEnter,CmdwinEnter * cal MarkShow()
aug END " }}}

fu! MarkHank(vector, mchar) abort " move to next/prev mark {{{
  let get_marks = s:get_mark(a:mchar)
  if get_marks == ''
    if a:mchar == g:mark_words_auto " expand marks
      cal MarkField()
      retu
    endif
    echo 'no marks'
    retu
  endif
  let mark_dict = {} " [linenum: mark char]
  let rownums = []
  for row in split(get_marks, '\n')[1:]
    let l:r = filter(split(row, ' '), {i, v -> v != ''})
    let mark_dict[r[1]] = r[0]
    let rownums = add(rownums, r[1])
  endfor
  cal sort(rownums, a:vector == 'up' ? {x, y -> y-x} : {x, y -> x - y})
  if a:mchar == g:mark_words_auto " if auto mark & out of range, create marks
    if line('.') <= rownums[a:vector == 'up' ? -1 : 0] || rownums[a:vector == 'up' ? 0 : -1] <= line('.')
      let do = a:vector == 'up' ? "5k" : "5j"
      execute("normal! " . do)
      cal MarkField()
      retu
    endif
  endif
  for rownum in rownums
    if a:vector == 'down' && rownum > line('.')
      exe "normal! `" . mark_dict[rownum]
      echo index(rownums, rownum) + 1 . "/" . len(rownums)
      retu
    elseif a:vector == 'up' && rownum < line('.')
      exe "normal! `" . mark_dict[rownum]
      echo len(rownums) - index(rownums, rownum) . "/" . len(rownums)
      retu
    endif
  endfor
  echo "last mark"
endf " }}}

fu! MarkField() abort " create short marks {{{
  cal MarkSignDel()
  execute('delmarks '.g:mark_words_auto)
  let warr = ['n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y']
  let now_line = line('.')
  let col = col('.')
  let last = line('$')
  mark z
  for v in range(1, 6)
    if now_line + v*5 <= last
      cal cursor(now_line + v*5, 1)
      execute('mark '.warr[2*(v-1)])
    endif
    if now_line + v*-5 > 0
      cal cursor(now_line + v*-5, 1)
      execute('mark '.warr[2*(v-1)-1])
    endif
  endfor
  cal cursor(now_line, col)
  cal MarkShow()
  echo 'mode [marker] expand'
endf
fu! MarkFieldOut()
  cal MarkSignDel()
  execute('delmarks '.g:mark_words_auto)
  cal MarkShow()
  echo '[marker] mode out'
endf " }}}
" }}}

" scroll ----------------------------------------{{{
fu! Scroll(vector, delta)
  cal ScrollToggle(0)
  let vec = a:vector == 0 ? "\<C-y>" : "\<C-e>"
  let tmp = timer_start(a:delta, { -> feedkeys(vec) }, {'repeat': -1})
  cal timer_start(600, { -> timer_stop(tmp) })
  cal timer_start(600, { -> ScrollToggle(1) })
endf
fu! ScrollToggle(flg)
  set cursorcolumn!
  set cursorline!
endf " }}}

" zihou timer ---------------------------------------{{{
let s:ini_hour = localtime() / 3600
fu! Timer()
  let l:now_hour = localtime() / 3600
  if now_hour != s:ini_hour
    let s:ini_hour = now_hour
    cal ChangeColor()
    cal popup_create([strftime('%Y/%m/%d %H:%M (%A)', localtime()), '', 'colorscheme: ' . execute('colorscheme')[1:]], #{border: [], zindex: 51, time: 3500})
    cal timer_start(1000, { -> RunCat() })
    cal timer_start(5000, { -> RunCatStop() })
  endif
endf
call timer_start(18000, { -> Timer() }, {'repeat': -1}) " }}}

" color --------------------------------{{{
let s:colorscheme_arr_default = ['torte']
let s:colorscheme_arr = ['onedark', 'hybrid_material', 'molokai']
fu! ChangeColor()
  if glob('~/.vim/colors') != ''
    execute('colorscheme ' . s:colorscheme_arr[localtime() % len(s:colorscheme_arr)])
  else
    execute('colorscheme ' . s:colorscheme_arr_default[localtime() % len(s:colorscheme_arr_default)])
  endif
endf
cal ChangeColor()

fu! ColorInstall()
  let cmd = "mkdir -p ~/.vim/colors && cd ~/.vim/colors && curl https://raw.githubusercontent.com/serna37/vim-color/master/hybrid_material.vim > hybrid_material.vim && curl https://raw.githubusercontent.com/serna37/vim-color/master/molokai.vim > molokai.vim && curl https://raw.githubusercontent.com/serna37/vim-color/master/onedark.vim > onedark.vim"
  execute("bo terminal ++shell echo 'start' && ".cmd." && echo 'end'")
endf " }}}

" running cat ----------------------------------------{{{
let g:cat_frame = 0
fu! s:RunCatM() abort
  cal setbufline(winbufnr(g:runcat), 1, s:running_cat[g:cat_frame])
  let g:cat_frame = g:cat_frame == 4 ? 0 : g:cat_frame + 1
  if g:cat_stop == 1
    cal popup_close(g:runcat)
    retu
  endif
  cal timer_start(200, { -> s:RunCatM() })
endf
fu! RunCatStop()
  let g:cat_stop = 1
endf
fu! RunCat()
  let g:cat_stop = 0
  let g:runcat = popup_create(s:running_cat[0], #{line: 1, border: [], zindex: 1})
  cal s:RunCatM()
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
\] " }}}

" plugins --------------------------------------------{{{
let s:repos = [
    \ 'powerline/fonts',
    \ 'ryanoasis/nerd-fonts',
    \ 'ryanoasis/vim-devicons',
    \ 'vim-airline/vim-airline',
    \ 'vim-airline/vim-airline-themes',
    \ 'sheerun/vim-polyglot',
    \ 'preservim/nerdtree',
    \ 'Xuyuanp/nerdtree-git-plugin',
    \ 'junegunn/fzf',
    \ 'junegunn/fzf.vim',
    \ 'neoclide/coc.nvim',
    \ 'thinca/vim-quickrun',
    \ 'puremourning/vimspector',
    \ 'unblevable/quick-scope',
    \ 'obcat/vim-hitspop',
    \ 't9md/vim-quickhl',
    \ 'junegunn/goyo.vim',
    \ 'junegunn/limelight.vim',
\ ]
command! PlugInstall cal PlugInstall()
command! PlugUnInstall cal PlugUnInstall()
fu! PlugInstall(...)
  let cmd = "repos=('".join(s:repos,"' '")."') && mkdir -p ~/.vim/pack/plugins/start && cd ~/.vim/pack/plugins/start && for v in ${repos[@]};do git clone --depth 1 https://github.com/${v} ;done" . " && fzf/install --no-key-bindings --completion --no-bash --no-zsh --no-fish" . " && sh fonts/install.sh" . " && sh nerd-fonts/install.sh && rm -rf nerd-fonts"
  execute("bo terminal ++shell " . cmd)
endf
let g:vsnip_snippet_dir = "~/forge"
fu! PlugUnInstall(...)
  execute("bo terminal ++shell echo 'start' && rm -rf ~/.vim ~/.config && echo 'end'")
endf " }}}

" favorite  -----------------------------------{{{
command! -nargs=* Necronomicon cal Necronomicon(<f-args>)
fu! Necronomicon(...) abort
  if a:0 == 0
    e ~/work/necronomicon.md
  elseif a:0 == 1 && a:1 == 'Azathoth'
    cal Initiation()
  elseif a:0 == 1 && a:1 == 'YogSothoth'
    let backup_cmd = "cd ~/backup; LIMIT=12; PREFIX=bk; FOLDER_NAME=${PREFIX}".strftime("%Y-%m-%d")."; if [ ! -e ./${FOLDER_NAME} ]; then mkdir ${FOLDER_NAME}; fi; cp -rf ~/work ${FOLDER_NAME}; cp -rf ~/forge ${FOLDER_NAME}; CNT=`ls -l | grep ^d | wc -l`; if [ ${CNT} -gt ${LIMIT} ]; then ls -d */ | sort | head -n $((CNT-LIMIT)) | xargs rm -rf; fi"
    execute("bo terminal ++shell echo 'start' && ".backup_cmd." && echo 'end'")
  elseif a:1 == 'n'
    echo "c  : change colorscheme"
    echo "ss : static snippet"
    echo "r  : run cat"
    echo "rs : stop cat"
    let mode = inputdialog("choose mode>>")
    if mode == "c"
      cal feedkeys("\<CR>")
      cal feedkeys(":cal ChangeColor()\<CR>")
      cal feedkeys(":colorscheme\<CR>")
    elseif mode == "ss"
      cal feedkeys(":15sp ~/forge/static_snippets.sh\<CR>")
      cal feedkeys("\<CR>")
    elseif mode == "r"
      cal feedkeys("\<CR>")
      cal feedkeys(":cal RunCat()\<CR>")
    elseif mode == "rs"
      cal feedkeys("\<CR>")
      cal feedkeys(":cal RunCatStop()\<CR>")
      cal popup_clear()
    endif
  endif
endf
" }}}

" init ----------------------------------{{{
fu! Initiation()
cal system("mkdir -p ~/forge ~/work ~/backup && touch ~/work/necronomicon.md")
cal system("if [ -e ~/forge/cheat_sheet.md ]; then rm ~/forge/cheat_sheet.md; fi && touch ~/forge/cheat_sheet.md")
cal system("if [ ! -e ~/forge/static_snippets.sh ]; then touch ~/forge/static_snippets.sh; fi")
let cheat_sheet = [
\ "# Install",
\ "- call ColorInstall() : install colorscheme",
\ "- command PlugInstall : install plugin (need nodejs, yarn)",
\ "-   >> call coc#util#install()",
\ "-   >> CocInstall coc-snippets coc-tsserver coc-json coc-go coc-clangd",
\ "-   >> CocConfig",
\ "-   >> also see https://github.com/neoclide/coc.nvim/wiki/Language-servers",
\ "-   >> also snippet setting ref https://qiita.com/kfuku1634_dev/items/25f5efd503c773a58056",
\ "-   >> :CocCommand snippets.editSnippets",
\ "- command PlugUnInstall : uninstall plugin",
\ "",
\ "# IDE",
\ "(plugin coc)",
\ "- Space d : go to definition",
\ "- Space r : find references",
\ "- Space v : other IDE functions",
\ "- Space ? : hover document",
\ "- Space , : prev diagnostic",
\ "- Space . : next diagnostic",
\ "- Tab : completion, coc-snippet next",
\ "- Shift Tab : coc-snippet prev",
\ "",
\ "# Motion Window",
\ "- ↑↓←→ : resize window",
\ "- Ctrl + hjkl : move window forcus",
\ "- Ctrl + udfb : comfortable scroll",
\ "- (visual choose) Ctrl jk : move line text",
\ "- (insert mode) Ctrl hljk : move cursor",
\ "- Space t : terminal",
\ "- Space tp : terminal popup",
\ "",
\ "# Search",
\ "- Space q : clear search highlight",
\ "- * : search word (original vim but dont move cursor)",
\ "- # : search word (original vim but dont move cursor)",
\ "- Space f : file search",
\ "- Space g : grep",
\ "",
\ "# Mark",
\ "- Space m : mark list",
\ "- mm : marking",
\ "- mj : next mark",
\ "- mk : prev mark",
\ "- mw : mark word (highlight)",
\ "",
\ "# GodSpeed",
\ "- Tab / Shift+Tab :",
\ "  1. expand anker each 6 rows, jump to anker",
\ "  2. expand f-scope highlight",
\ "- Space w : clear anker, f-scope highlight, mark highlight",
\ "",
\ "# Favorit",
\ "- Space sh : run current line as shell",
\ "- Space n : Necronomicon",
\ "-   :Necronomicon > open necronomicon",
\ "-   :Necronomicon Azathoth > initiation",
\ "-   :Necronomicon YogSothoth > backup",
\ "-   :Necronomicon n > other funcs",
\ "- Space Space Space : this",
\ ]
for v in cheat_sheet
  cal system('echo "'.v.'" >> ~/forge/cheat_sheet.md')
endfor
let static_snippets_ini = [
\ "# git",
\ "git add . && git commit -m 'upd' && git push",
\ "",
\ ]
for v in static_snippets_ini
  cal system('echo "'.v.'" >> ~/forge/static_snippets.sh')
endfor
echo 'initiation end'
echo 'help to Space*3'
endf " }}}

