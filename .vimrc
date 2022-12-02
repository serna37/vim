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
" status line
set ruler
set laststatus=2
let ff_table = {'dos' : 'CRLF', 'unix' : 'LF', 'mac' : 'CR'}
fu! SetStatusLine()
  hi User1 cterm=bold ctermfg=7 ctermbg=4 gui=bold guibg=#70a040 guifg=#ffffff
  hi User2 cterm=bold ctermfg=2 ctermbg=0 gui=bold guibg=#4070a0 guifg=#ffffff
  hi User3 cterm=bold ctermbg=5 ctermfg=0
  hi User4 cterm=bold ctermfg=7 ctermbg=56 gui=bold guibg=#a0b0c0 guifg=black
  hi User5 cterm=bold ctermfg=7 ctermbg=5 gui=bold guibg=#0070e0 guifg=#ffffff
  let dict = {'i': '1* INSERT', 'n': '2* NORMAL', 'R': '3* REPLACE', 'c': '4* COMMAND', 't': '4* TERMIAL', 'v': '5* VISUAL', 'V': '5* VISUAL', "\<C-v>": '5* VISUAL'}
  let mode = match(keys(dict), mode()) != -1 ? dict[mode()] : '5* SP'
  retu '%' . mode . ' %* %<%F%m%r%h%w%=%2* %p%% %l/%L %02v [%{&fenc!=""?&fenc:&enc}][%{ff_table[&ff]}] %*'
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
" }}}

" ========================================
" KeyMap
" ========================================
" {{{
let g:mapleader = "\<Space>"
" search ---------------------------------------
nnoremap <silent>* *N
nnoremap <silent># *N
nnoremap <silent><Leader>q :noh<CR>
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
" language ----------------------------------------
nnoremap <Leader>lgd <Plug>(coc-definition)
nnoremap <Leader>lgr <plug>(coc-references)
nnoremap <silent><Leader>ldd :call CocAction('doHover')<CR>
nnoremap <Leader>lrr <plug>(coc-rename)
nnoremap <Leader>lff <Plug>(coc-format)
nnoremap <Leader>, <plug>(coc-diagnostic-next)
nnoremap <Leader>. <plug>(coc-diagnostic-prev)
" TODO 実行まだ
nnoremap <Leader>run :echo 'TODO'<CR>
nnoremap <Leader>sh :cal execute('top terminal ++rows=10 ++shell eval ' . getline('.'))<CR>
" edit ---------------------------------------
nnoremap <C-s> :w<CR>
nnoremap x "_x
nnoremap d "_d
vnoremap x "_x
vnoremap d "_d
inoremap " ""<C-o>h
inoremap ' ''<C-o>h
inoremap ( ()<C-o>h
inoremap { {}<C-o>h
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>l
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
" func - fzf ---------------------------------------
nnoremap <silent><leader>f :cal FzfStart()<CR>
" func - grep ---------------------------------------
nnoremap <silent><Leader>g :cal GrepChoseMode()<CR>
" func - god speed ---------------------------------------
nnoremap <silent><Tab> :cal MarkHank("down", g:mark_words_auto)<CR>:cal FModeActivate()<CR>
nnoremap <silent><S-Tab> :cal MarkHank("up", g:mark_words_auto)<CR>:cal FModeActivate()<CR>
nnoremap <silent><Leader>w :cal MarkFieldOut()<CR>:cal FModeDeactivate()<CR>
" func - mark ---------------------------------------
nnoremap <silent><Leader>m :cal MarkMenu()<CR>
nnoremap <silent>mm :cal Marking()<CR>
nnoremap <silent>mj :cal MarkHank("down", g:mark_words_manual)<CR>
nnoremap <silent>mk :cal MarkHank("up", g:mark_words_manual)<CR>
nnoremap <silent>mw :cal HiSet()<CR>
" favorite ---------------------------------------
nnoremap <silent><Leader>t :call popup_create(term_start([&shell], #{ hidden: 1, term_finish: 'close'}), #{ border: [], minwidth: &columns/2, minheight: &lines/2 })<CR>
nnoremap <Leader><Leader>n :Necronomicon 
nnoremap <Leader><Leader><Leader> :15sp ~/forge/cheat_sheet.md<CR>
nnoremap <Leader><Leader>w :cal RunCat()<CR>
nnoremap <Leader><Leader>s :cal RunCatStop()<CR>
nnoremap <Leader><Leader>c :cal ChangeColor()<CR>:colorscheme<CR>
" }}}

" ========================================
" Function
" ========================================
" fzf------------------------------------------{{{
let g:not_path_arr = ['"*.vim/*"', '"*.git/*"', '"*.npm/*"', '"*.yarn/*"', '"*.m2/*"', '"*.class"', '"*.vscode/*"', '"*.config/*"', '"*Applications/*"', '"*Library/*"', '"*Music/*"', '"*Pictures/*"', '"*Movies/*"', '"*AppData/*"', '"*OneDrive/*"', '"*Videos/*"']
let g:fzf_find_cmd = 'find . -type f -name "*" -not -path ' . join(g:not_path_arr, ' -not -path ')
let g:fzf_searched_dir = execute('pwd')[1:] " first char is ^@, so trim
let g:fzf_find_result_tmp = []

fu! FzfStart() " open window
  if stridx(execute('pwd')[1:], g:fzf_searched_dir) == -1 || len(g:fzf_find_result_tmp) == 0
    cal s:fzf_re_find()
  endif
  let g:fzf_mode = 'his'
  let g:fzf_searching_zone = '(*^-^) BUF & MRU'
  let g:fzf_pwd_prefix = 'pwd:[' . execute('pwd')[1:] . ']>>'
  let g:fzf_enter_keyword = []
  let g:fzf_his_result = map(split(execute('ls'), '\n'), { i,v -> split(filter(split(v, ' '), { i,v -> v != '' })[2], '"')[0] }) + map(split(execute('oldfiles'), '\n'), { i,v -> split(v, ': ')[1] })
  let g:fzf_find_result = g:fzf_his_result[0:29]
  let g:fzf_enter_win = popup_create(g:fzf_pwd_prefix, #{ title: 'Type or <BS> / past:<Space> / MRU<>FZF:<Tab> / choose:<Enter> / end:<Esc> / chache refresh:<C-f>',  border: [], zindex: 99, minwidth: &columns/2, maxwidth: &columns/2, maxheight: 1, line: &columns/4-&columns/36, filter: function('s:fzf_refresh_result') })
  cal win_execute(g:fzf_enter_win, "mapclear <buffer>")
  cal s:fzf_create_choose_win()
endf
fu! s:fzf_create_choose_win()
  let g:fzf_c_idx = 0
  let g:fzf_choose_win = popup_menu(g:fzf_find_result, #{ title: g:fzf_searching_zone, border: [], zindex: 98, minwidth: &columns/2, maxwidth: &columns/2, minheight: 2, maxheight: &lines/2, filter: function('s:fzf_choose') })
  cal win_execute(g:fzf_enter_win, "mapclear <buffer>")
endf

fu! s:fzf_re_find() " async find command
  cal RunCat()
  let g:fzf_find_result_tmp = []
  let g:fzf_searched_dir = execute('pwd')[1:]
  echo 'find files in ['.g:fzf_searched_dir.'] and chache ...'
  cal job_start(g:fzf_find_cmd, {'out_cb': function('s:fzf_find_start'), 'close_cb': function('s:fzf_find_end')})
endf
fu! s:fzf_find_start(ch, msg) abort
  let g:fzf_find_result_tmp = add(g:fzf_find_result_tmp, a:msg)
endf
fu! s:fzf_find_end(ch) abort
  echo 'find files in ['.g:fzf_searched_dir.'] and chache is complete!!'
  cal RunCatStop()
endf

fu! s:fzf_refresh_result(winid, key) abort " event to draw search result
  if a:key is# "\<Esc>"
    cal popup_close(g:fzf_enter_win)
    cal popup_close(g:fzf_choose_win)
    retu 1
  elseif a:key is# "\<CR>"
    call popup_close(g:fzf_enter_win)
    retu 1
  elseif a:key is# "\<C-f>"
    cal s:fzf_re_find()
  elseif a:key is# "\<Space>"
    for i in range(0,strlen(@")-1)
      let g:fzf_enter_keyword = add(g:fzf_enter_keyword, strpart(@",i,1))
    endfor
  elseif a:key is# "\<Tab>"
    let g:fzf_mode = g:fzf_mode == 'his' ? 'fzf' : 'his'
    let g:fzf_searching_zone = g:fzf_mode == 'his' ? '(*^-^) BUF & MRU' : '(*^-^) FZF [' . g:fzf_searched_dir . ']'
    cal popup_close(g:fzf_choose_win)
    if g:fzf_mode == 'his'
      let g:fzf_find_result = len(g:fzf_enter_keyword) != 0 ? matchfuzzy(g:fzf_his_result, join(g:fzf_enter_keyword, '')) : g:fzf_his_result
    else
      let g:fzf_find_result = len(g:fzf_enter_keyword) != 0 ? matchfuzzy(g:fzf_find_result_tmp, join(g:fzf_enter_keyword, '')) : g:fzf_find_result_tmp
    endif
    let g:fzf_find_result = g:fzf_find_result[0:29]
    cal s:fzf_create_choose_win()
    retu 1
  elseif a:key is# "\<BS>" && len(g:fzf_enter_keyword) > 0
    unlet g:fzf_enter_keyword[len(g:fzf_enter_keyword)-1]
  elseif a:key is# "\<BS>" && len(g:fzf_enter_keyword) == 0
    " noop
  elseif strtrans(a:key) == "<80><fd>`"
    " noop (for polyglot bug adhoc)
    retu
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
  retu a:key is# "x" || a:key is# "\<Space>" ? 1 : popup_filter_menu(a:winid, a:key)
endf

fu! s:fzf_choose(winid, key) abort
  if a:key is# 'j'
    let g:fzf_c_idx = g:fzf_c_idx == len(g:fzf_find_result)-1 ? len(g:fzf_find_result)-1 : g:fzf_c_idx + 1
  elseif a:key is# 'k'
    let g:fzf_c_idx = g:fzf_c_idx == 0 ? 0 : g:fzf_c_idx - 1
  elseif a:key is# "\<CR>"
    retu s:fzf_open(a:winid, 'e', g:fzf_find_result[g:fzf_c_idx])
  elseif a:key is# "\<C-v>"
    retu s:fzf_open(a:winid, 'vnew', g:fzf_find_result[g:fzf_c_idx])
  elseif a:key is# "\<C-t>"
    retu s:fzf_open(a:winid, 'tabnew', g:fzf_find_result[g:fzf_c_idx])
  endif
  retu popup_filter_menu(a:winid, a:key)
endf
fu! s:fzf_open(winid, op, f) abort
  cal popup_close(a:winid)
  exe a:op a:f
  retu 1
  endf " }}}

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

" highlight -----------------------------------{{{
" TODO cword highlight disable
" on word, bright
"aug auto_hl_cword
"  au!
"  au BufEnter,CmdwinEnter * cal HiCwordStart()
"aug END
"fu! HiCwordStart()
"  aug QuickhlCword
"    au!
"    au! CursorMoved <buffer> cal HiCwordR()
"    au! ColorScheme * execute("hi link QuickhlCword ColorColumn")
"  aug END
"  execute("hi link QuickhlCword ColorColumn")
"endf
"
"fu! HiCwordR()
"  silent! 2match none
"  exe "2mat QuickhlCword /\\\<". escape(expand('<cword>'), '\/~ .*^[''$') . "\\\>/"
"endf

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

fu! HiReset(group_name)
  let already = filter(getmatches(), {i, v -> v['group'] == a:group_name})
  if len(already) > 0
    cal matchdelete(already[0]['id'])
  endif
endf

fu! HiSet() abort " set highlight on all window in tab
  " TODO reset cword highlight
  "cal HiReset('QuickhlCword')
  let current_win = win_getid()
  let cw = expand('<cword>')
  windo cal matchadd("UserSearchHi" . g:now_hi, cw, 15)
  cal win_gotoid(current_win) " return current window
  let g:now_hi = g:now_hi >= len(g:search_hl)-1 ? 0 : g:now_hi + 1
endf " }}}

" quick-scope ---------------------------------{{{
aug qs_colors
  au!
  au ColorScheme * highlight QuickScopePrimary cterm=bold ctermfg=196 ctermbg=16 guifg=#66D9EF guibg=#000000
  au ColorScheme * highlight QuickScopeSecondary ctermfg=161 ctermbg=16 guifg=#66D9EF guibg=#000000
  au ColorScheme * highlight QuickScopeBack ctermfg=51 ctermbg=16 guifg=#66D9EF guibg=#000000
  au ColorScheme * highlight QuickScopeBackSecond ctermfg=25 ctermbg=16 guifg=#66D9EF guibg=#000000
aug END

fu! FModeActivate()
  aug f_scope
    au!
    au CursorMoved * cal HiFLine()
  aug End
  cal HiFLine()
endf

fu! FModeDeactivate()
  aug f_scope
    au!
  aug End
  let current_win = win_getid()
  windo cal clearmatches() " reset highlight on all window in tab
  cal win_gotoid(current_win) " return current window
endf

let g:fmode_flg = 1
fu! FModeToggle(flg)
  let g:fmode_flg = a:flg
endf

fu! HiFLine()
  if g:fmode_flg == 0
    retu
  endif
  cal HiReset('QuickScopePrimary')
  cal HiReset('QuickScopeSecondary')
  cal HiReset('QuickScopeBack')
  cal HiReset('QuickScopeBackSecond')

  let line = line('.')
  let col = col('.')
  let now_line = getline('.')

  let target_arr = []
  let target_arr_second = []
  let target_arr_back = []
  let target_arr_back_second = []

  let offset = 0
  while offset != -1
    let start = matchstrpos(now_line, '\<.', offset)
    let offset = matchstrpos(now_line, '.\>', offset)[2]
    let ashiato = start[1] >= col ? now_line[col:start[1]-1] : now_line[start[2]+1:col]
    if stridx(ashiato, start[0]) == -1
      cal add(start[1] >= col ? target_arr : target_arr_back, [line, start[2]]) " uniq char
    elseif start[2] > 0
      let next_char = now_line[start[2]:start[2]]
      if start[1] >= col
        cal add(stridx(ashiato, next_char) == -1 ? target_arr : target_arr_second, [line, start[2]+1]) " uniq char
      else
        cal add(stridx(ashiato, next_char) == -1 ? target_arr_back  : target_arr_back_second , [line, start[2]+1])
      endif
    endif
  endwhile

  cal matchaddpos("QuickScopePrimary", target_arr, 16)
  cal matchaddpos("QuickScopeSecondary", target_arr_second, 16)
  cal matchaddpos("QuickScopeBack", target_arr_back, 16)
  cal matchaddpos("QuickScopeBackSecond", target_arr_back_second, 16)
endf
" }}}

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
  cal FModeToggle(a:flg)
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
    cal SetStatusLine()
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
    \ 'neoclide/coc.nvim',
    \ 'sheerun/vim-polyglot',
    \ 'hrsh7th/vim-vsnip',
\ ]
" TODO want debug, runner?
command! PlugInstall cal PlugInstall()
command! PlugUnInstall cal PlugUnInstall()
fu! PlugInstall(...)
  let cmd = "repos=('".join(s:repos,"' '")."') && mkdir -p ~/.vim/pack/plugins/start && cd ~/.vim/pack/plugins/start && for v in ${repos[@]};do git clone --depth 1 https://github.com/${v} ;done"
  execute("bo terminal ++shell " . cmd)
  let g:vsnip_snippet_dir = "~/forge"
endf
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
    let backup_cmd = "cd ~/backup; LIMIT=12; PREFIX=ふしぎなおくりもの; FOLDER_NAME=${PREFIX}".strftime("%Y-%m-%d")."; if [ ! -e ./${FOLDER_NAME} ]; then mkdir ${FOLDER_NAME}; fi; cp -rf ~/work ${FOLDER_NAME}; cp -rf ~/forge ${FOLDER_NAME}; CNT=`ls -l | grep ^d | wc -l`; if [ ${CNT} -gt ${LIMIT} ]; then ls -d */ | sort | head -n $((CNT-LIMIT)) | xargs rm -rf; fi"
    execute("bo terminal ++shell echo 'start' && ".backup_cmd." && echo 'end'")
  endif
endf " }}}

" init ----------------------------------{{{
fu! Initiation()
bo terminal ++shell mkdir -p ~/forge ~/work ~/backup && touch ~/work/necronomicon.md && if [ -e ~/forge/cheat_sheet.md ]; then rm ~/forge/cheat_sheet.md; fi && touch ~/forge/cheat_sheet.md
let cheat_sheet = [
\ "# CheatSheet",
\ "",
\ "# Install",
\ "- call ColorInstall() : install colorscheme",
\ "- command PlugInstall : install plugin (need nodejs, yarn)",
\ "- >> call coc#util#install()",
\ "- >> CocInstall coc-snippets",
\ "- >> CocInstall coc-tsserver",
\ "- >> CocConfig",
\ "- >>> also see https://github.com/neoclide/coc.nvim/wiki/Language-servers#ccobjective-c",
\ "- command PlugUnInstall : uninstall plugin",
\ "",
\ "# Language",
\ "- Space lgd : go to definition",
\ "- Space lgr : find references",
\ "- Space ldd : hover document",
\ "- Space lrr : rename",
\ "- Space lff : format",
\ "- Space , : prev diagnostic",
\ "- Space . : next diagnostic",
\ "- Space run : run",
\ "- Space sh : run current line as shell",
\ "",
\ "# Snippet",
\ "- Tab : completion, coc-snippet next",
\ "- Shift Tab : coc-snippet prev",
\ "- (insert mode) Ctrl s : vsnip expand / next",
\ "- (insert mode) Ctrl w : vsnip prev",
\ "",
\ "# Motion",
\ "- ↑↓←→ : resize window",
\ "- Ctrl + hjkl : move window forcus",
\ "- Ctrl + udfb : comfortable scroll",
\ "- Space t : terminal popup",
\ "- (visual choose) Ctrl jk : move line text",
\ "- (insert mode) Ctrl hl : move cursor",
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
\ "- Space Space n : Necronomicon (see vimrc)",
\ "- Space Space w : run cat",
\ "- Space Space s : stop cat",
\ "- Space Space c : change colorscheme",
\ "- Space * 3 : this cheat_sheet",
\ ]
for v in cheat_sheet
  cal system('echo "'.v.'" >> ~/forge/cheat_sheet.md')
endfor
endf " }}}
