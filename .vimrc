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
set foldmethod=marker
set foldlevel=0
set foldlevelstart=0
set foldcolumn=1

" view
syntax on
set title
set showcmd
set number
" TODO gitbash does not work
if !has('win32unix')
  au ModeChanged [vV\x16]*:* let &l:rnu = mode() =~# '^[vV\x16]'
  au ModeChanged *:[vV\x16]* let &l:rnu = mode() =~# '^[vV\x16]'
endif
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
  hi User1 cterm=bold ctermfg=7 ctermbg=4 gui=bold guibg=#70a040 guifg=#ffffff
  hi User2 cterm=bold ctermfg=2 ctermbg=0 gui=bold guibg=#4070a0 guifg=#ffffff
  hi User3 cterm=bold ctermbg=5 ctermfg=0
  hi User4 cterm=bold ctermfg=7 ctermbg=56 gui=bold guibg=#a0b0c0 guifg=black
  hi User5 cterm=bold ctermfg=7 ctermbg=5 gui=bold guibg=#0070e0 guifg=#ffffff
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
  retu '%' . c . '* ' . mode_name . ' %* %<%F%m%r%h%w%=%2* %p%% %l/%L %02v [%{&fenc!=""?&fenc:&enc}][%{ff_table[&ff]}] %*'
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

fu! s:my_key_map()
nnoremap <Tab> 10j
nnoremap <S-Tab> 10k

" file search ---------------------------------------
nnoremap <leader>f :call FzfStart()<CR>
nnoremap <Leader>c :call FzfReFind()<CR>

" grep ---------------------------------------
nnoremap <Leader>gg :GrepExtFrom<CR>
nnoremap <Leader>ge :GrepExtFrom 

" lsp
" TODO
"nnoremap <Leader>j :LspHover<CR>
"nnoremap <Leader>p :LspPeekDefinition<CR>
"nnoremap <Leader>o :LspDefinition<CR>
"nnoremap <Leader>r :LspReferences<CR>

" jump ---------------------------------------
nnoremap <silent>* *N:cal HiSet()<CR>:cal Hitpop()<CR>
nnoremap <silent># *N:cal HiSet()<CR>:cal Hitpop()<CR>
nnoremap <silent><Leader>q :noh<CR>:cal clearmatches()<CR>:cal popup_clear(g:hitpopid)<CR>
" TODO gitbash popup + scroll = heavy
if has('win32unix')
  nnoremap <silent>* *N:cal HiSet()<CR>
  nnoremap <silent># *N:cal HiSet()<CR>
  nnoremap <silent><Leader>q :noh<CR>:cal clearmatches()<CR>
endif

" mark --------------------------------------------------
"nnoremap <Leader>m :marks abcdefghijklmnopqrstuvwxyz<CR>:normal! `
nnoremap <Leader>m :call MarkMenu()<CR>
nnoremap mm :cal Marking()<CR>
nnoremap mj :cal MarkHank("up")<CR>
nnoremap mk :cal MarkHank("down")<CR>

" window ---------------------------------------
nnoremap j gj
nnoremap k gk

" TODO netrw cannot move
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

nnoremap <silent><Leader>t :call popup_create(term_start([&shell], #{ hidden: 1, term_finish: 'close'}), #{ border: [], minwidth: &columns/2, minheight: &lines/2 })<CR>
" edit ---------------------------------------
imap <expr> <Tab> '<C-n>'
inoremap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'
inoremap <expr> <CR> pumvisible() ? '<C-y>' : '<CR>'

" favorite ---------------------------------------
nnoremap <Leader><Leader>n :Necronomicon 
nnoremap <Leader><Leader>w :cal RunCat()<CR>
nnoremap <Leader><Leader>cc :cal ChangeColor()<CR>:colorscheme<CR>
nnoremap <Leader><Leader>ce :cal execute('top terminal ++shell eval ' . getline('.'))<CR>
endf
cal s:my_key_map()

" ========================================
" Function
" ========================================

" zihou timer ---------------------------------------
let s:ini_hour = localtime() / 3600
fu! Timer()
  let l:now_hour = localtime() / 3600
  if now_hour != s:ini_hour
    let s:ini_hour = now_hour
    cal ChangeColor()
    cal popup_create([strftime('%Y/%m/%d %H:%M (%A)', localtime()), '', 'colorscheme: ' . execute('colorscheme')[1:]], #{border: [], zindex: 51, time: 3500})
    cal timer_start(1000, { -> RunCat() })
  endif
endf
call timer_start(18000, { -> Timer() }, {'repeat': -1})

" change color --------------------------------
let s:colorscheme_arr_default = ['torte']
let s:colorscheme_arr = ['hybrid_material', 'molokai']
fu! ChangeColor()
  if glob('~/.vim/colors') != ''
    execute('colorscheme ' . s:colorscheme_arr[localtime() % len(s:colorscheme_arr)])
  else
    execute('colorscheme ' . s:colorscheme_arr_default[localtime() % len(s:colorscheme_arr_default)])
    cal SetStatusLine()
  endif
endf
cal ChangeColor()
if glob('~/.vim/colors') != ''
  colorscheme molokai
endif

" TODO delete
" fzf like
fu! FzfPatternExe() abort
  echo execute('pwd')
  let inarr = split(inputdialog("Enter [ext] [pattern]>>"), ' ')
  if len(inarr) !=  2
    echo 'break'
    retu
  endif
  let fzf_cmd = 'find ./* -iname "*' . inarr[1] . '*.' . inarr[0] . '"'
  echo 'searching ... [ ' . fzf_cmd . ' ]'
  let fzf_res = split(system(fzf_cmd), '\n')
  echo '_________________________'
  for v in fzf_res
    echo index(fzf_res, v) . ': ' . v
  endfor
  echo '_________________________'
  let ope = len(fzf_res) == 0 ? '' : inputdialog("choose >>")
  exe ope == '' ? 'echo "break"' : 'e' . fzf_res[ope]
endf

cd ~/git
let g:fzf_find_cmd = 'find . -type f -name "*" -not -path "*.git/*" -not -path "*.class"'
let g:fzf_searched_dir = execute('pwd')[1:] " first char is ^@, so trim
let g:fzf_find_result_tmp = split(system(g:fzf_find_cmd), '\n')

fu! FzfReFind()
  let g:fzf_searched_dir = execute('pwd')[1:]
  echo 'find files in ['.g:fzf_searched_dir.'] and chache ...'
  cal timer_start(0, { -> FzfReFindBackGround() })
endf

fu! FzfReFindBackGround()
  let g:fzf_find_result_tmp = split(system(g:fzf_find_cmd), '\n')
  echo 'find files in ['.g:fzf_searched_dir.'] and chache is complete!!'
endf

" TODO map clear
" TODO cache find result
fu! FzfStart()
  " clear map to escape
  mapclear
  let g:fzf_mode = 'his'
  let g:fzf_searching_zone = '(*^-^) BUF & MRU'
  let g:fzf_pwd_prefix = 'pwd:[' . execute('pwd')[1:] . ']>>'
  let g:fzf_enter_keyword = []
  let g:fzf_his_result = map(split(execute('ls'), '\n'), { i,v -> split(filter(split(v, ' '), { i,v -> v != '' })[2], '"')[0] }) + map(split(execute('oldfiles'), '\n'), { i,v -> split(v, ': ')[1] })
  let g:fzf_find_result = g:fzf_his_result
  let g:fzf_enter_win = popup_create(g:fzf_pwd_prefix, #{ title: 'type or backspace / past: <Space> / MRU<>FZF: <Tab> / choose: <Enter> / end: <Esc>',  border: [], zindex: 99, minwidth: &columns/2, maxwidth: &columns/2, maxheight: 1, line: &columns/4-&columns/24, filter: function('s:fzf_refresh_result') })
  cal s:fzf_create_choose_win()
endf

fu! s:fzf_create_choose_win()
  let g:fzf_c_idx = 0
  let g:fzf_choose_win = popup_menu(g:fzf_find_result, #{ title: g:fzf_searching_zone, border: [], zindex: 98, minwidth: &columns/2, maxwidth: &columns/2, minheight: 2, maxheight: &lines/2, filter: function('s:fzf_choose') })
endf

fu! s:fzf_refresh_result(winid, key) abort
  if a:key is# "\<Esc>"
    call popup_close(g:fzf_enter_win)
    call popup_close(g:fzf_choose_win)
    cal s:my_key_map()
    return 1
  elseif a:key is# "\<CR>"
    call popup_close(g:fzf_enter_win)
    cal s:my_key_map()
    return 1
  elseif a:key is# "\<Space>"
    for i in range(0,strlen(@")-1)
      let g:fzf_enter_keyword = add(g:fzf_enter_keyword, strpart(@",i,1))
    endfor
  elseif a:key is# "\<Tab>"
    let g:fzf_mode = g:fzf_mode == 'his' ? 'fzf' : 'his'
    let g:fzf_searching_zone = g:fzf_mode == 'his' ? '(*^-^) BUF & MRU' : '(*^-^) FZF [' . g:fzf_searched_dir . ']'
    cal popup_close(g:fzf_choose_win)
    cal timer_start(0, { -> s:fzf_create_choose_win() })
  elseif a:key is# "\<BS>" && len(g:fzf_enter_keyword) > 0
    unlet g:fzf_enter_keyword[len(g:fzf_enter_keyword)-1]
  elseif a:key is# "\<BS>" && len(g:fzf_enter_keyword) == 0
    " noop
  else
    let g:fzf_enter_keyword = add(g:fzf_enter_keyword, a:key)
  endif

  if g:fzf_mode == 'his'
    let g:fzf_find_result = len(g:fzf_enter_keyword) != 0 ? matchfuzzy(g:fzf_his_result, join(g:fzf_enter_keyword, '')) : g:fzf_his_result
  else
    let g:fzf_find_result = len(g:fzf_enter_keyword) != 0 ? matchfuzzy(g:fzf_find_result_tmp, join(g:fzf_enter_keyword, '')) : g:fzf_find_result_tmp
  endif

  cal setbufline(winbufnr(g:fzf_enter_win), 1, g:fzf_pwd_prefix . join(g:fzf_enter_keyword, ''))
  cal setbufline(winbufnr(g:fzf_choose_win), 1, map(range(1,30), { i,v -> '' }))
  cal setbufline(winbufnr(g:fzf_choose_win), 1, g:fzf_find_result[0:29]) " re view only first 30 files
  return a:key is# "x" || a:key is# "\<Space>" ? 1 : popup_filter_menu(a:winid, a:key)
endf

fu! s:fzf_choose(winid, key) abort
  if a:key is# 'j'
    let g:fzf_c_idx = g:fzf_c_idx == len(g:fzf_find_result)-1 ? len(g:fzf_find_result)-1 : g:fzf_c_idx + 1
  elseif a:key is# 'k'
    let g:fzf_c_idx = g:fzf_c_idx == 0 ? 0 : g:fzf_c_idx - 1
  elseif a:key is# "\<CR>"
    return s:fzf_open(a:winid, 'e', g:fzf_find_result[g:fzf_c_idx])
  elseif a:key is# "\<C-v>"
    return s:fzf_open(a:winid, 'vnew', g:fzf_find_result[g:fzf_c_idx])
  elseif a:key is# "\<C-t>"
    return s:fzf_open(a:winid, 'tabnew', g:fzf_find_result[g:fzf_c_idx])
  endif
  return popup_filter_menu(a:winid, a:key)
endf

fu! s:fzf_open(winid, op, f) abort
  cal popup_close(a:winid)
  exe a:op a:f
  return 1
endf

" TODO delete
" history
fu! HisList()
  let his_res = split(execute('oldfiles'), '\n')
  for v in his_res
    echo index(his_res, v) . ': ' . split(v, ':')[1]
    if index(his_res, v) == 10
      break
    endif
  endfor
  let ope = inputdialog("choose >>")
  exe ope == '' ? 'echo "break"' : 'e' . split(his_res[ope], ':')[1]
endf

" grep ----------------------------------------
command! -nargs=* GrepExtFrom cal GrepExtFrom(<f-args>)
fu! GrepExtFrom(...)
  let ext = a:0 == 1 ? a:1 : expand('%:e')
  let pwd = system('pwd')
  exe 'lcd %:h'
  let gitroot = system('git rev-parse --show-superproject-working-tree --show-toplevel')
  exe 'lcd ' . pwd
  let target = stridx(gitroot, 'fatal: ') == -1 ? ' ' . gitroot[0:strlen(gitroot)-2] . '/*' : ' ./*'
  echo 'grep [' . expand('<cword>') . '] processing in [' . ext .'] ...'
  cgetexpr system('grep -n -r --include="*.' . ext . '" ' . expand('<cword>') . target) | cw
  echo 'grep end'
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
    au! ColorScheme * execute("hi link QuickhlCword CursorLine")
  aug END
  execute("hi link QuickhlCword CursorLine")
endf

fu! HiCwordR()
  silent! 2match none
  exe "2mat QuickhlCword /\\\<". escape(expand('<cword>'), '\/~ .*^[''$') . "\\\>/"
endf

" on search, multi highlight
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
  let already = filter(getmatches(), {i, v -> v['pattern'] == cw})
  if len(already) > 0
    cal matchdelete(already[0]['id'])
    retu
  endif
  cal matchadd("UserSearchHi" . g:now_hi, cw)
  let g:now_hi = g:now_hi >= len(g:search_hl)-1 ? 0 : g:now_hi + 1
endf

" hitspop
let g:hitpopid = ''
fu! Hitpop()
  cal popup_clear(g:hitpopid)
  let g:hitpopid = popup_create(expand('<cword>'), #{ border: [], pos: "topleft", line: 1, col: &columns - 15 })
endf

" mark ----------------------------------------
let g:mark_words = 'abcdefghijklmnopqrstuvwxyz'
fu! MarkMenu()
  let markdicarr = []
  let get_marks = ''
  try
    let get_marks = execute('marks ' . g:mark_words)
  catch
    echo 'no marks'
    retu
  endtry
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
  return popup_filter_menu(a:winid, a:key)
endf

fu! Marking() abort
  try
    let get_marks = execute('marks ' . g:mark_words)
  catch
    execute('mark a')
    cal MarkShow()
    echo 'marked'
    retu
  endtry
  let l:now_marks = []
  let l:warr = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
  for row in split(get_marks , '\n')[1:]
    let l:r = filter(split(row, ' '), {i, v -> v != ''})
    if stridx(g:mark_words, r[0]) != -1 && r[1] == line('.')
      execute('delmarks ' . r[0])
      cal MarkShow()
      echo 'delete mark'
      retu
    endif
    let l:now_marks = add(now_marks, r[0])
  endfor
  let l:can_use = filter(warr, {i, v -> stridx(join(now_marks, ''), v) == -1})
  if len(can_use) != 0
    execute('mark ' . can_use[0])
    cal MarkShow()
    echo 'marked'
  else
    echo 'over limit markable char'
  endif
endf

fu! MarkShow() abort
  cal sign_undefine()
  try
    let get_marks = execute('marks ' . g:mark_words)
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

fu! MarkHank(vector) abort
  try
    let get_marks = execute('marks ' . g:mark_words)
  catch
    echo 'no marks'
    retu
  endtry
  let l:marks = split(get_marks, '\n')
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
fu! Scroll(vector, delta)
  cal CursorToggle()
  let vec = a:vector == 0 ? "\<C-y>" : "\<C-e>"
  let tmp = timer_start(a:delta, { -> feedkeys(vec) }, {'repeat': -1})
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

" favorite  -----------------------------------
" TODO for plugin
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
