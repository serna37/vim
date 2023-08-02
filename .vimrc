" vim:set foldmethod=marker:

" ==============================================================================
"  CONTENTS
"
"   # CheatSheet
"     ## CheatSheet Hover ...... | hover cheat sheet at Cursor Hold 5 sec.
"
"   # Basic vim setting
"     ## FILE .................. | file encoding, charset, vim specific setting.
"     ## VISUALIZATION ......... | enhanced visual information.
"     ## WINDOW ................ | window forcus, resize, open terminal.
"     ## MOTION ................ | row move, scroll, mark, IDE action menu.
"     ## EDIT .................. | insert mode parenthese, cursor, block move.
"     ## COMPLETION ............ | indent, word completion.
"     ## SEARCH ................ | incremental search, fzf, grep, explorer.
"     ## OTHERS ................ | fast terminal, reg engin, fold.
"
"   # plugins setting
"     ## PLUGIN VARIABLES ...... | setting for plugins without conflict.
"     ## PLUGIN KEYMAP ......... | setting for plugins without conflict.
"
"   # functions
"     ## FUNCTIONS ............. | adhoc functions.
"     ## IMITATION ............. | imitate plugins as functions.
"     ## PLUGINS ............... | plugin manager functions.
"     ## TRAINING .............. | training default vim functions.
"
" ==============================================================================

let mapleader = "\<SPACE>"

" #############################################################
" ##################       CheatSheet       ###################
" #############################################################
" {{{

" cursor hold
" motion cheat sheet on popup

augroup cheat_sheet_hover
  au!
  autocmd CursorHold * silent call s:CheatSheet()
  autocmd CursorMoved * silent call s:CheatSheetClose()
  autocmd CursorMovedI * silent call s:CheatSheetClose()
augroup END

" TODO fix color
let s:my_vim_cheet_sheet = [
      \' --[window]---------------------------------------------- ',
      \' (C-n/p)(Space x)   [buffer tab][next/prev/close] ',
      \' (←↑↓→)(C-hjkl)     [window][resize/forcus] ',
      \' (Space t)(Space z) [terminal][Zen Mode] ',
      \' --[motion]---------------------------------------------- ',
      \' (Space v)      [IDE Action Menu] ',
      \' (Tab S-Tab)    [jump][5rows] ',
      \' (s)(Space s)   [easymotion incremental(Tab)] ',
      \' (Space w)      [f-scope toggle] ',
      \' (mm/mn/mp/mc)  [mark(toggle)/next/prev/clear] ',
      \' INSERT(C-hjkl) [cursor move] ',
      \' VISUAL(C-jk)   [blok up/down] ',
      \' --[search]---------------------------------------------- ',
      \' (Space fhb)    [fzf][files/histories/buffers] ',
      \' (Space ejclm)  [explorer/jumped/changed/line/marks] ',
      \' (Space g)(Space*2 s)  [grep][buffer grep incremental] ',
      \' (Space q)      [clear search highlight] ',
      \' --[command]--------------------------------------------- ',
      \' (:PlugUnInstall)          [plugins uninstall] ',
      \' (:TrainingWheelsProtocol) [training default vim]',
      \' -------------------------------------------------------- ',
      \' (Space*3)      [ON/OFF Cheat Sheet] ',
      \]

" no plugin version
if glob('~/.vim/pack/plugins/start') == ''
  let s:my_vim_cheet_sheet = [
        \' --[window]---------------------------------------------- ',
        \' (Space x)       [buffer][close] ',
        \' (←↑↓→)(C-hjkl)  [window][resize/forcus] ',
        \' (Space t)       [terminal] ',
        \' --[motion]---------------------------------------------- ',
        \' (Space v)      [IDE Action Menu] some are dosabled ',
        \' (Tab S-Tab)    [jump][5rows] ',
        \' (Space w)      [f-scope toggle] ',
        \' (mm/mn/mp/mc)  [mark(toggle)/next/prev/clear] ',
        \' INSERT(C-hjkl) [cursor move] ',
        \' VISUAL(C-jk)   [blok up/down] ',
        \' --[search]---------------------------------------------- ',
        \' (Space fhb)   [fzf-mimic][files/histories/buffers] ',
        \' (Space em)  [explorer(netrw)/marks] ',
        \' (Space g)(Space*2 s)   [grep][buffer grep] ',
        \' (Space q)   [clear search highlight] ',
        \' --[command]--------------------------------------------- ',
        \' (:TrainingWheelsProtocol) [training default vim]',
        \' (:PlugInstall)      [plugins install] ',
        \' (:PlugInstallCoc)   [coc extension install] ',
        \' -------------------------------------------------------- ',
        \' (Space*3)      [ON/OFF Cheat Sheet] ',
        \]
endif

let s:cheat_sheet_open_flg = 0
let s:cheatwinid = 0
let s:cheat_sheet_timer_id = 0
fu! s:CheatSheetPopup(timer)
  let s:cheatwinid = popup_create(s:my_vim_cheet_sheet, #{ title: ' Action Cheet Sheet ', border: [], zindex: 1, line: "cursor+1", col: "cursor" })
endf

fu! s:CheatSheet()
  if s:show_cheat_sheet_flg == 0
    call timer_stop(s:cheat_sheet_timer_id)
    return
  endif
  if s:cheat_sheet_open_flg == 0
    let s:cheat_sheet_open_flg = 1
    call timer_stop(s:cheat_sheet_timer_id)
    let s:cheat_sheet_timer_id = timer_start(10000, function("s:CheatSheetPopup"))
  endif
endf
fu! s:CheatSheetClose()
  if s:show_cheat_sheet_flg == 0
    call timer_stop(s:cheat_sheet_timer_id)
    return
  endif
  let s:cheat_sheet_open_flg = 0
  call popup_close(s:cheatwinid)
  call timer_stop(s:cheat_sheet_timer_id)
endf

nnoremap <silent><Leader><Leader><Leader> :call PopupFever()<CR>:call ToggleCheatHover()<CR>
let s:show_cheat_sheet_flg = 0
fu! CheatAlert(tid)
  execute("echo '[INFO] Space * 3 to enable cheat sheet !!'")
endf
if has('vim_starting')
  call timer_start(200, function("CheatAlert"))
endif
let s:recheatwinid = 0
fu! PopupFever()
  call RunCat()
  let s:recheatwinid = popup_create(s:my_vim_cheet_sheet, #{ title: ' Action Cheet Sheet ', border: [], line: &columns/4 })
  let s:logowinid = popup_create(g:startify_custom_header, #{ border: [] })
endf
fu! PopupFeverStop()
  call RunCatStop()
  call popup_close(s:recheatwinid )
  call popup_close(s:logowinid)
endf
fu! ToggleCheatHover()
  let msg = 'Disable Cheat Sheet Hover'
  if s:show_cheat_sheet_flg == 1
    let s:show_cheat_sheet_flg = 0
  else
    let msg = 'Enable Cheat Sheet Hover'
    let s:show_cheat_sheet_flg = 1
  endif
  let s:checkwinid = popup_notification(msg, #{ border: [], line: &columns/4-&columns/37, close: "button" })
  call timer_start(3000, { -> PopupFeverStop()})
endf

" }}}

" #############################################################
" ##################          FILE          ###################
" #############################################################
" {{{

" file
set fileformat=unix " LF
set fileencoding=utf8 " charset

" vim specific
set noswapfile " no create swap file
set nobackup " no create backup file
set noundofile " no create undo file
set hidden " enable go other buffer without save
set autoread " re read file when changed outside vim
set clipboard+=unnamed " copy yanked fot clipboard

" reopen, go row
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
augroup END

" }}}

" #############################################################
" ##################     VISUALIZATION      ###################
" #############################################################
" {{{

" enable syntax highlight, set colorscheme
syntax on
colorscheme torte

" window
set background=dark " basic color
set title " show filename on terminal title
set showcmd " show enterd command on right bottom

" visible
set list " show invisible char
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:% " custom invisible char

" row number
set number " normal mode show row number as relative from current row
" insert mode show row number as relative from current row
au ModeChanged [vV\x16]*:* let &l:rnu = mode() =~# '^[vV\x16]'
au ModeChanged *:[vV\x16]* let &l:rnu = mode() =~# '^[vV\x16]'
au WinEnter,WinLeave * let &l:rnu = mode() =~# '^[vV\x16]'

" cursor
set scrolloff=5 " page top bottom offset view row
set cursorline " show cursor line
set cursorcolumn " show cursor column
set ruler " show row/col position number at right bottom

" status
set laststatus=2 " status line at bottom
" custom status line just like
" vim-airline/vim-airline
let ff_table = {'dos' : 'CRLF', 'unix' : 'LF', 'mac' : 'CR'}
fu! SetStatusLine()
  hi User1 cterm=bold ctermfg=7 ctermbg=4
  hi User2 cterm=bold ctermfg=7 ctermbg=28
  hi User3 cterm=bold ctermbg=5 ctermfg=0
  hi User4 cterm=bold ctermfg=7 ctermbg=56
  hi User5 cterm=bold ctermfg=7 ctermbg=5
  hi User6 ctermfg=7 ctermbg=8
  let dict = {'i': '1* INSERT', 'n': '2* NORMAL', 'R': '3* REPLACE', 'c': '4* COMMAND', 't': '4* TERMIAL', 'v': '5* VISUAL', 'V': '5* VISUAL', "\<C-v>": '5* VISUAL'}
  let mode = match(keys(dict), mode()) != -1 ? dict[mode()] : '5* SP'
  retu '%' . mode . ' %*➤ %6*%<%F%m%r%h%w %0* %=%' . split(mode, ' ')[0] . ' %p%% %l/%L %02v [%{&fenc!=""?&fenc:&enc}][%{ff_table[&ff]}] %*'
endf
set stl=%!SetStatusLine()

" tabline
function! MakeTabLine()
  if tabpagenr('$') == 1
    return s:buffers_label()
  endif
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  let sep = ' '
  let tabpages = join(titles, sep).sep.'%#TabLineFill#%T'
  return tabpages
endfunction

function! s:buffers_label()
  let bufline = ''
  for v in map(split(execute("ls"), '\n'), { i,v -> split(v, ' ')})
    let x = filter(v, { i,v -> v != ''})
    if stridx(x[1], 'F') == -1 && stridx(x[1], 'R') == -1
      hi UserBuflineActive ctermfg=7 ctermbg=28
      hi UserBuflineDeactive ctermfg=7 ctermbg=8
      hi UserBuflineModified ctermfg=7 ctermbg=4
      let hi = stridx(x[1], '%') != -1 ? '%#UserBuflineActive#' : '%#UserBuflineDeactive#'
      let filename = x[2] == '+' ? '✗'.x[3] : x[2]
      if x[2] == '+' | let hi = '%#UserBuflineModified#' | endif
      let bufline = bufline.'%'.v[0].'T'.hi.filename.' ⁍|'.'%T%#TabLineFill# '
    endif
  endfor
  return bufline
endfunction

function! s:tabpage_label(n)
  hi UserTablineActive ctermfg=7 ctermbg=28
  hi UserTablineDeactive ctermfg=7 ctermbg=8
  let hi = a:n is tabpagenr() ? '%#UserTablineActive#' : '%#UserTablineDeactive#'
  let bufnrs = tabpagebuflist(a:n)
  let no = len(bufnrs) | if no is 1 | let no = '' | endif
  let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '✗' : ''
  let fname = pathshorten(bufname(bufnrs[tabpagewinnr(a:n) - 1]))
  let sep = ' ⁍|'
  return '%'.a:n.'T'.hi.no.mod.fname.sep.'%T%#TabLineFill#'
endfunction

set tabline=%!MakeTabLine()
set showtabline=2

" }}}

" #############################################################
" ##################         WINDOW        ###################
" #############################################################
" {{{

" just like
" simeji/winresizer

" window forcus move
nnoremap <C-h> <C-w>h|nnoremap <C-l> <C-w>l|nnoremap <C-k> <C-w>k|nnoremap <C-j> <C-w>j
tnoremap <C-h> <C-w>h|tnoremap <C-l> <C-w>l|tnoremap <C-k> <C-w>k|tnoremap <C-j> <C-w>j

" window resize
nnoremap <Left> 4<C-w><|nnoremap <Right> 4<C-w>>|nnoremap <Up> 4<C-w>-|nnoremap <Down> 4<C-w>+

" move buffer
nmap <silent><C-n> :call MoveBuf('prev')<CR>
nmap <silent><C-p> :call MoveBuf('next')<CR>

" close buffer
nnoremap <silent><Leader>x :call CloseBuf()<CR>

" terminal
"nnoremap <silent><Leader>t :bo terminal ++rows=10<CR>
nnoremap <silent><Leader>t :call popup_create(term_start([&shell], #{ hidden: 1, term_finish: 'close'}), #{ border: [], minwidth: &columns/2+&columns/4, minheight: &lines/2+&lines/4 })<CR>

" terminal read only mode (i to return terminal mode)
tnoremap <Esc> <C-w>N

" }}}

" #############################################################
" ##################         MOTION         ###################
" #############################################################
" {{{

" row move
nnoremap j gj|nnoremap k gk
nnoremap <Tab> 5gj|nnoremap <S-Tab> 5gk|vnoremap <Tab> 5gj|vnoremap <S-Tab> 5gk

" comfortable scroll
nnoremap <silent><C-u> :cal Scroll(0, 30)<CR>|nnoremap <silent><C-d> :cal Scroll(1, 30)<CR>
nnoremap <silent><C-b> :cal Scroll(0, 10)<CR>|nnoremap <silent><C-f> :cal Scroll(1, 10)<CR>

" custom scroll just like
" yuttie/comfortable-motion.vim
fu! Scroll(vector, delta)
  cal s:ScrollToggle(0)
  let vec = a:vector == 0 ? "\<C-y>" : "\<C-e>"
  let tmp = timer_start(a:delta, { -> feedkeys(vec) }, {'repeat': -1})
  cal timer_start(600, { -> timer_stop(tmp) })
  cal timer_start(600, { -> s:ScrollToggle(1) })
endf
fu! s:ScrollToggle(flg)
  set cursorcolumn!
  set cursorline!
endf

" mimic
" unblevable/quick-scope
nnoremap <silent><Leader>w :call FModeToggle()<CR>

" mark
nnoremap mm :call Marking()<CR>
nnoremap mn :call MarkHank("down")<CR>
nnoremap mp :call MarkHank("up")<CR>
nnoremap mc :call MarkSignDel()<CR>:delmarks!<CR>
nnoremap <silent><Leader>m :call MarkMenu()<CR>

" IDE action menu
nnoremap <silent><Leader>v :cal IDEMenu()<CR>

" }}}

" #############################################################
" ##################         EDIT           ###################
" #############################################################
" {{{

" basic
set virtualedit=all " virtual cursor movement
set whichwrap=b,s,h,l,<,>,[,],~ " motion over row
set backspace=indent,eol,start " backspace attitude on insert mode

" parentheses
set showmatch " jump pair of parentheses when write
set matchtime=3 " jump term sec

" move cursor at insert mode
inoremap <C-h> <C-o>h|inoremap <C-l> <C-o>l|inoremap <C-k> <C-o>k|inoremap <C-j> <C-o>j

" d = delete(no clipboard)
nnoremap d "_d|vnoremap d "_d

" block move at visual mode
vnoremap <C-j> "zx"zp`[V`]|vnoremap <C-k> "zx<Up>"zP`[V`]

" }}}

" #############################################################
" ##################       COMPLETION       ###################
" #############################################################
" {{{

" indent
set autoindent " uses the indent from the previous line
set smartindent " more smart indent than autoindent
set smarttab " use shiftwidth
set shiftwidth=4 " auto indent width
set tabstop=4 " view width of Tab
set expandtab " Tab to Space

" word
set wildmenu " command mode completion enable
set wildchar=<Tab> " command mode comletion key
set wildmode=full " command mode completion match mode
set complete=.,w,b,u,U,k,kspell,s,i,d,t " insert mode completion resource
set completeopt=menuone,noinsert,preview,popup " insert mode completion window

" completion with Tab
inoremap <expr> <CR> pumvisible() ? '<C-y>' : '<CR>'
inoremap <expr> <Tab> '<C-n>'
inoremap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'

" auto completion
function! Completion()
  let exclude_completion_chars = [" ", "(", "[", "{", "<", "'", '"', "`"]
  if col('.') == 1 || match(exclude_completion_chars, getline('.')[col('.')-2]) != -1 | return | endif
  if !pumvisible() | call feedkeys("\<Tab>") | endif
endfunction
if glob('~/.vim/pack/plugins/start/coc.nvim')  == ''
  autocmd TextChangedI,TextChangedP * silent call Completion()
endif

" jiangmiao/auto-pairs
inoremap ( ()<LEFT>|inoremap [ []<LEFT>|inoremap { {}<LEFT>|inoremap < <><LEFT>
inoremap ' ''<LEFT>|inoremap " ""<LEFT>|inoremap ` ``<LEFT>

function! AutoPairsDelete()
  let pairs_start = ["(", "[", "{", "<", "'", '"', "`"] | let pairs_end = [")", "]", "}", ">", "'", '"', "`"]
  let pre_cursor_char = getline('.')[col('.')-2] | let on_cursor_char = getline('.')[col('.')-1]
  let pre_chk = match(pairs_start, pre_cursor_char) | let on_chk = match(pairs_end, on_cursor_char)
  if pre_chk != -1 && pre_chk == on_chk | return "\<RIGHT>\<BS>\<BS>" | endif
  return "\<BS>"
endfunction
inoremap <buffer><silent><BS> <C-R>=AutoPairsDelete()<CR>


" }}}

" #############################################################
" ##################         SEARCH         ###################
" #############################################################
" {{{

" search
set incsearch " incremental search
set hlsearch " highlight match words
set ignorecase " ignore case search
set smartcase " don't ignore case when enterd UPPER CASE"
set shortmess-=S " show hit word's number at right bottom

" no move search word
nnoremap <silent>* *N:call HiSet()<CR>
nnoremap <silent># *N:call HiSet()<CR>

" incremental search
" TODO add like easymotion
nnoremap s :echo('no easymotion')<CR>
nnoremap <Leader>s /

" disable highlight
nnoremap <silent><Leader>q :windo noh<CR>:windo cal clearmatches()<CR>

" grep result -> quickfix
au QuickFixCmdPost *grep* cwindow
if executable('rg')
  let &grepprg = 'rg --vimgrep --hidden'
  set grepformat=%f:%l:%c:%m
endif

" explorer
" enable netrw & custom
filetype plugin on
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 70
set splitright " when opne file, split right window
nnoremap <silent><Leader>e :Vex 15<CR>

" TODO doeesn't work
augroup netrw_motion
  autocmd!
  autocmd FileType netrw call NetrwMotion()
augroup END

function! NetrwMotion()
  nnoremap <buffer><C-h> <C-w>h
endfunction

" fzf || fzf-mimic
nnoremap <silent><leader>f :cal FzfG()<CR>
nnoremap <silent><leader>h :cal FzfG()<CR>
nnoremap <silent><leader>b :cal FzfG()<CR>

" ripgrep || grep
nnoremap <silent><Leader>g :cal Grep()<CR>

" vimgrep current file
nnoremap <silent><Leader><Leader>s :cal GrepCurrent()<CR>

" }}}

" #############################################################
" ##################         OTHERS         ###################
" #############################################################
" {{{

" basic
scriptencoding utf-8 " this file's charset
set ttyfast " fast terminal connection
set regexpengine=0 " chose regexp engin

" fold
set foldmethod=marker " fold marker
set foldlevel=0 " fold max depth
set foldlevelstart=0 " fold depth on start view
set foldcolumn=1 " fold preview

" }}}

" #############################################################
" ##################    PLUGIN VARIABLES    ###################
" #############################################################
" {{{

if glob('~/.vim/colors/') != '' | colorscheme onedark | endif

" coc
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" vimspector
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

" fzf
set rtp+=~/.vim/pack/plugins/start/fzf

" easy motion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_keys='swadjkhlnmf'

" airline
let g:airline_theme = 'deus'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_powerline_fonts = 1

" auto pair
let g:AutoPairsMapCh = 0

" zen
let g:limelight_conceal_ctermfg = 'gray'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" startify
" ぼっちざろっく{{{
let g:startify_custom_header = [
    \'                                                                                                                           dN',
    \'                                                                                           ..                             JMF',
    \'                                                                                      ..gMMMM%                           JMF',
    \'                                                                                    .MM9^ .MF                           (MF',
    \'                                                                           .(,      ("   .M#                  .g,      .MF',
    \'                     .,  dN                                             gg,,M@          .M#                  .M#!      (M>',
    \'                     JM} M#             .MNgg.                     .g,  ?M[ 7B         .MMg+gg,.           .MM"        ."',
    \'             ...gNMN,.Mb MN           .gMM9!                      .(MN,  .=           .MMM9=  ?MN,         (WN,      .MM ',
    \'jN-      ..gMMN#!     (Mp(M}       .+MMYMF                    ..kMMWM%               ,M#^       dN.          .WNJ,   JM',
    \'MM     .MM9^  dN,                 dNB^ (M%                   ?M"!  ,M\        .,               .M#   .&MMMN,    ?"   M#',
    \'MN            .MN#^                    dM:  ..(J-,                 ,B         .TM             .M#   ,M@  .MF',
    \'MN.       ..MMBMN_                     dN_.MM@"!?MN.   TMm     .a,                           (M@         MM^',
    \'MN.     .MM"  JMb....       ..        dMMM=     .Mb            ?HNgJ..,                   .MM^',
    \'dM{          -MMM#7"T""   .dN#TMo       ?      .MM^                 ?!                 +gM#=',
    \'(M]         .MN(N#       .M@  .MF              .MM^                                      ~',
    \'.MN          ?"""             MM!            .MMD                        ',
    \' ?N[                                         7"                                ',
    \'  TMe                                                                          ',
    \'   ?MN,                                                                      ',
    \'     TMNg,                                                                     '
    \]
"}}}

" }}}

" #############################################################
" ##################      PLUGIN KEYMAP     ###################
" #############################################################
" {{{

" for no override default motion, if glob( plugin path ) is need

" tabline motion
if glob('~/.vim/pack/plugins/start/vim-airline') != ''
  nmap <silent><C-n> <Plug>AirlineSelectPrevTab
  nmap <silent><C-p> <Plug>AirlineSelectNextTab
endif

" coc
if glob('~/.vim/pack/plugins/start/coc.nvim') != ''
  " file search
  nnoremap <silent><Leader>e :CocCommand explorer --width 30<CR>
  nnoremap <silent><leader>h :CocCommand fzf-preview.MruFiles<CR>
  nnoremap <silent><leader>b :CocCommand fzf-preview.AllBuffers<CR>

  " cursor  highlight
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " grep
  nnoremap <Leader><Leader>s :CocList words<CR>

  " jump
  nnoremap <silent><Leader>l :CocCommand fzf-preview.Lines<CR>
  nnoremap <silent><Leader>j :CocCommand fzf-preview.Jumps<CR>
  nnoremap <silent><Leader>c :CocCommand fzf-preview.Changes<CR>

  " completion @ coc
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
  inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
  inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

  " IDE
  nnoremap <Leader>d <Plug>(coc-definition)
  nnoremap <Leader>r :CocCommand fzf-preview.CocReferences<CR>
  nnoremap <Leader>o :CocCommand fzf-preview.CocOutline<CR>
  nnoremap <Leader>? :cal CocAction('doHover')<CR>
  nnoremap <Leader>, <plug>(coc-diagnostic-next)
  nnoremap <Leader>. <plug>(coc-diagnostic-prev)
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) :  Scroll(1, 10)
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) :  Scroll(0, 10)
endif

" easy motion
if glob('~/.vim/pack/plugins/start/vim-easymotion') != ''
  nnoremap s <Plug>(easymotion-bd-w)
  nnoremap <Leader>s <Plug>(easymotion-sn)
endif

" zen mode
nnoremap <silent><Leader>z :Goyo<CR>

" }}}

" #############################################################
" ##################       FUNCTIONS        ###################
" #############################################################
" {{{

fu! MoveBuf(flg)
  let current_id = '' | let buf_arr = []
  for v in map(split(execute("ls"), '\n'), { i,v -> split(v, ' ')})
    let x = filter(v, { i,v -> v != ''})
    if stridx(x[1], 'F') == -1 && stridx(x[1], 'R') == -1
      let buf_arr = add(buf_arr, x[0])
      if stridx(x[1], '%') != -1 | let current_id = x[0] | endif
    endif
  endfor
  let buf_idx = a:flg == 'next' ? match(buf_arr, current_id) + 1 : match(buf_arr, current_id) - 1
  let buf_id = buf_idx == len(buf_arr) ? buf_arr[0] : buf_arr[buf_idx]
  execute("b ".buf_id)
endf

fu! CloseBuf()
  let l:now_b = bufnr('%')
  execute("normal \<C-n>")
  execute('bd ' . now_b)
endf

fu! FzfG() " if git repo, ref .gitignore. || no plugin
  if glob('~/.vim/pack/plugins/start/coc.nvim') == '' | cal FzfStart() | return | endif
  let pwd = system('pwd')
  try | exe 'lcd %:h' | catch | endtry
  let gitroot = system('git rev-parse --show-superproject-working-tree --show-toplevel')
  try | exe 'lcd ' . pwd | catch | endtry
  execute(!v:shell_error ? 'CocCommand fzf-preview.ProjectFiles' : 'Files')
endf

fu! Grep() abort
  " plugin mode
  if glob('~/.vim/pack/plugins/start/coc.nvim') != '' || executable('rg')
    let w = inputdialog("start ripgrep [word] >>")
    echo '<<'
    if w == '' | echo 'cancel' | retu | endif
    execute('CocCommand fzf-preview.ProjectGrep -w --ignore-case '.w)
    return
  endif
  " no plugin
  echo 'grep. choose [word] [ext] [target]'
  let pwd = system('pwd')
  let word = inputdialog("Enter [word]>>")
  echo '<<'
  if word == '' | echo 'cancel' | retu | endif
  let ext = inputdialog("Enter [ext]>>")
  echo '<<'
  if ext == '' | echo 'all ext' | let ext = '*' | endif
  let target = inputdialog("Enter [target (like ./*) pwd:".pwd."]>>")
  if target == '' | echo 'search current directory' | let target = './*' | endif
  echo '<<'
  echo 'grep [' . word . '] processing in [' . target . '] [' . ext . '] ...'
  cgetexpr system('grep -n -r --include="*.' . ext . '" "' . word . '" ' . target) | cw
  echo 'grep end'
  return
endf

fu! GrepCurrent() abort
  echo 'grep from this file.'
  let word = inputdialog("Enter [word]>>")
  echo '<<'
  if word == '' | echo 'cancel' | retu | endif
  echo 'grep [' . word . '] processing in [' . expand('%') . '] ...'
  cal execute('vimgrep /' . word . '/gj %') | cw
  echo 'grep end'
endf

let s:my_ide_menu_items = [
      \'[Format]         applay format for this file',
      \'[ReName*]        rename current word recursively',
      \'[ALL PUSH]       commit & push all changes',
      \'[QuickFix-Grep*] Open Preview Popup from quickfix - from fzfpreview Ctrl+Q',
      \'[Snippet*]       edit snippets',
      \'[Run*]           run current program',
      \'[Debug*]         debug current program',
      \'[Run as Shell]   run current row as shell command',
      \'[Color random]   change colorscheme at random',
      \]

let s:my_ide_action_cheet_sheet = [
      \' (Space d) [Definition]     Go to Definition ',
      \' (Space r) [Reference]      Reference ',
      \' (Space o) [Outline]        view outline on popup ',
      \' (Space ?) [Document]       show document on popup scroll C-f/b ',
      \' (Space ,) [Next Diagnosis] jump next diagnosis ',
      \' (Space .) [Prev Diagnosis] jump prev diagnosis ',
      \]

let s:colorscheme_arr_default = ['torte', 'elflord', 'pablo']
let s:colorscheme_arr = ['onedark', 'hybrid_material', 'molokai']

let s:popid = 0
fu! IDEMenu() abort
  let s:popid = popup_create(s:my_ide_action_cheet_sheet, #{ title: ' Other Plugin KeyMaps ', border: [], line: &columns/4 })
  cal popup_menu(s:my_ide_menu_items, #{ title: ' IDE MENU (j / k) Enter choose | * require plugin ', border: [], filter: function('IDEChoose', [{'idx': 0, 'files': s:my_ide_menu_items }]) })
endf

fu! IDEChoose(ctx, winid, key) abort
  if a:key is# 'j' && a:ctx.idx < len(a:ctx.files)-1
    let a:ctx.idx = a:ctx.idx+1
  elseif a:key is# 'k' && a:ctx.idx > 0
    let a:ctx.idx = a:ctx.idx-1
  elseif a:key is# "\<Esc>" || a:key is# "\<Space>"
    call popup_close(s:popid)
  elseif a:key is# "\<CR>"
    if a:ctx.idx == 0
      try
        cal CocActionAsync('format')
      catch
        let current_rownum = line('.')
        normal gg=G
        execute("normal" . current_rownum . "G")
      endtry
    elseif a:ctx.idx == 1
      cal CocActionAsync('rename')
    elseif a:ctx.idx == 2
      let w = inputdialog("commit message>>")
      if w == '' | echo 'cancel' | retu | endif
      cal execute('top terminal ++rows=10 ++shell git add . && git commit -m "'.w.'" && git push')
    elseif a:ctx.idx == 3
      execute("CocCommand fzf-preview.QuickFix")
    elseif a:ctx.idx == 4
      execute("CocCommand snippets.editSnippets")
    elseif a:ctx.idx == 5
      exe "QuickRun -hook/time/enable 1"
    elseif a:ctx.idx == 6
      cal vimspector#Launch()
    elseif a:ctx.idx == 7
      execute('top terminal ++rows=10 ++shell eval ' . getline('.'))
    elseif a:ctx.idx == 8
      let g:newcolorscheme = ''
      if glob('~/.vim/colors') != ''
        let g:newcolorscheme = s:colorscheme_arr[localtime() % len(s:colorscheme_arr)]
      else
        let g:newcolorscheme = s:colorscheme_arr_default[localtime() % len(s:colorscheme_arr_default)]
      endif
      execute('echo "change [".execute("colorscheme")[1:]."] -> [".g:newcolorscheme."]"')
      call timer_start(500, { -> execute('colorscheme ' . g:newcolorscheme) })
    endif
    call popup_close(s:popid)
  endif
  retu popup_filter_menu(a:winid, a:key)
endf

" }}}

" #############################################################
" ##################       IMITATION        ###################
" #############################################################

" ===================================================================
" junegunn/fzf.vim
" ===================================================================
" {{{

let s:not_path_arr = [
      \'"*/.**/*"',
      \'"*node_modules/*"',
      \'"*Applications/*"',
      \'"*Library/*"',
      \'"*Music/*"',
      \'"*Pictures/*"',
      \'"*Movies/*"',
      \'"*AppData/*"',
      \'"*OneDrive/*"',
      \'"*Videos/*"'
      \]
let s:fzf_find_cmd = 'find . -type f -name "*" -not -path ' . join(s:not_path_arr, ' -not -path ')
let s:fzf_searched_dir = execute('pwd')[1:] " first char is ^@, so trim
let s:fzf_find_result_tmp = []

fu! FzfStart() " open window
  if stridx(execute('pwd')[1:], s:fzf_searched_dir) == -1 || len(s:fzf_find_result_tmp) == 0 | cal s:fzf_re_find() | endif
  let s:fzf_mode = 'his'
  let s:fzf_searching_zone = '(*^-^)/ BUF & MRU'
  let s:fzf_pwd_prefix = 'pwd:[' . execute('pwd')[1:] . ']>>'
  let s:fzf_enter_keyword = []
  let s:fzf_his_result = map(split(execute('ls'), '\n'), { i,v -> split(filter(split(v, ' '), { i,v -> v != '' })[2], '"')[0] }) + map(split(execute('oldfiles'), '\n'), { i,v -> split(v, ': ')[1] })
  let s:fzf_find_result = s:fzf_his_result[0:29]
  let s:fzf_enter_win = popup_create(s:fzf_pwd_prefix, #{ title: 'MRU<>FZF:<Tab>/choose:<CR>/end:<Esc>/chache refresh:<C-f>',  border: [], zindex: 99, minwidth: &columns/2, maxwidth: &columns/2, maxheight: 1, line: &columns/4-&columns/36, filter: function('s:fzf_refresh_result') })
  cal win_execute(s:fzf_enter_win, "mapclear <buffer>")
  cal s:fzf_create_choose_win()
endf
fu! s:fzf_create_choose_win()
  let s:fzf_c_idx = 0
  let s:fzf_choose_win = popup_menu(s:fzf_find_result, #{ title: s:fzf_searching_zone, border: [], zindex: 98, minwidth: &columns/2, maxwidth: &columns/2, minheight: 2, maxheight: &lines/2, filter: function('s:fzf_choose') })
  cal win_execute(s:fzf_enter_win, "mapclear <buffer>")
endf

fu! s:fzf_re_find() " async find command
  cal RunCat()
  let s:fzf_find_result_tmp = []
  let s:fzf_searched_dir = execute('pwd')[1:]
  echo 'find files in ['.s:fzf_searched_dir.'] and chache ...'
  cal job_start(s:fzf_find_cmd, {'out_cb': function('s:fzf_find_start'), 'close_cb': function('s:fzf_find_end')})
endf
fu! s:fzf_find_start(ch, msg) abort
  let s:fzf_find_result_tmp = add(s:fzf_find_result_tmp, a:msg)
endf
fu! s:fzf_find_end(ch) abort
  echo 'find files in ['.s:fzf_searched_dir.'] and chache is complete!!'
  cal RunCatStop()
endf

fu! s:fzf_refresh_result(winid, key) abort " event to draw search result
  if a:key is# "\<Esc>"
    cal popup_close(s:fzf_enter_win)
    cal popup_close(s:fzf_choose_win)
    retu 1
  elseif a:key is# "\<CR>"
    call popup_close(s:fzf_enter_win)
    retu 1
  elseif a:key is# "\<C-f>"
    cal s:fzf_re_find()
  elseif a:key is# "\<C-v>"
    for i in range(0,strlen(@")-1)
      let s:fzf_enter_keyword = add(s:fzf_enter_keyword, strpart(@",i,1))
    endfor
  elseif a:key is# "\<Tab>"
    let s:fzf_mode = s:fzf_mode == 'his' ? 'fzf' : 'his'
    let s:fzf_searching_zone = s:fzf_mode == 'his' ? '(*^-^)/ BUF & MRU' : '(*"@w@)/ FZF [' . s:fzf_searched_dir . ']'
    cal popup_close(s:fzf_choose_win)
    if s:fzf_mode == 'his'
      let s:fzf_find_result = len(s:fzf_enter_keyword) != 0 ? matchfuzzy(s:fzf_his_result, join(s:fzf_enter_keyword, '')) : s:fzf_his_result
    else
      let s:fzf_find_result = len(s:fzf_enter_keyword) != 0 ? matchfuzzy(s:fzf_find_result_tmp, join(s:fzf_enter_keyword, '')) : s:fzf_find_result_tmp
    endif
    let s:fzf_find_result = s:fzf_find_result[0:29]
    cal s:fzf_create_choose_win()
    retu 1
  elseif a:key is# "\<BS>" && len(s:fzf_enter_keyword) > 0
    unlet s:fzf_enter_keyword[len(s:fzf_enter_keyword)-1]
  elseif a:key is# "\<BS>" && len(s:fzf_enter_keyword) == 0
  " noop
  elseif a:key is# "\<C-w>"
    let s:fzf_enter_keyword = []
  elseif strtrans(a:key) == "<80><fd>`"
    " noop (for polyglot bug adhoc)
    retu
  else
    let s:fzf_enter_keyword = add(s:fzf_enter_keyword, a:key)
  endif

  if s:fzf_mode == 'his'
    let s:fzf_find_result = len(s:fzf_enter_keyword) != 0 ? matchfuzzy(s:fzf_his_result, join(s:fzf_enter_keyword, '')) : s:fzf_his_result
  else
    let s:fzf_find_result = len(s:fzf_enter_keyword) != 0 ? matchfuzzy(s:fzf_find_result_tmp, join(s:fzf_enter_keyword, '')) : s:fzf_find_result_tmp
  endif

  cal setbufline(winbufnr(s:fzf_enter_win), 1, s:fzf_pwd_prefix . join(s:fzf_enter_keyword, ''))
  cal setbufline(winbufnr(s:fzf_choose_win), 1, map(range(1,30), { i,v -> '' }))
  cal setbufline(winbufnr(s:fzf_choose_win), 1, s:fzf_find_result[0:29]) " re view only first 30 files
  retu a:key is# "x" || a:key is# "\<Space>" ? 1 : popup_filter_menu(a:winid, a:key)
endf

fu! s:fzf_choose(winid, key) abort
  if a:key is# 'j'
    let s:fzf_c_idx = s:fzf_c_idx == len(s:fzf_find_result)-1 ? len(s:fzf_find_result)-1 : s:fzf_c_idx + 1
  elseif a:key is# 'k'
    let s:fzf_c_idx = s:fzf_c_idx == 0 ? 0 : s:fzf_c_idx - 1
  elseif a:key is# "\<CR>"
    retu s:fzf_open(a:winid, 'e', s:fzf_find_result[s:fzf_c_idx])
  elseif a:key is# "\<C-v>"
    retu s:fzf_open(a:winid, 'vnew', s:fzf_find_result[s:fzf_c_idx])
  elseif a:key is# "\<C-t>"
    retu s:fzf_open(a:winid, 'tabnew', s:fzf_find_result[s:fzf_c_idx])
  endif
  retu popup_filter_menu(a:winid, a:key)
endf
fu! s:fzf_open(winid, op, f) abort
  cal popup_close(a:winid)
  cal RunCatStop()
  exe a:op a:f
  retu 1
endf


" }}}


" run cat (load animation)
" {{{
let s:cat_frame = 0
fu! s:RunCatM() abort
  cal setbufline(winbufnr(s:runcat), 1, s:running_cat[s:cat_frame])
  let s:cat_frame = s:cat_frame == 4 ? 0 : s:cat_frame + 1
  if s:cat_stop == 1 | cal popup_close(s:runcat) | retu | endif
  cal timer_start(200, { -> s:RunCatM() })
endf
fu! RunCatStop()
  let s:cat_stop = 1
endf
fu! RunCat()
  let s:cat_stop = 0
  let s:runcat = popup_create(s:running_cat[0], #{line: 1, border: [], zindex: 1})
  cal s:RunCatM()
endf

" running cat AA {{{
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
" }}}

" }}}

" ===================================================================
" MattesGroeger/vim-bookmarks
" ===================================================================
" {{{

let s:mark_words = 'abcdefghijklmnopqrstuvwxyz'
fu! s:get_mark(tar) abort
  try | retu execute('marks ' . a:tar) | catch | retu '' | endtry
endf

fu! MarkMenu() abort
  let get_marks = s:get_mark(s:mark_words)
  if get_marks == '' | echo 'no marks' | retu | endif
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
endf

fu! Marking() abort
  let get_marks = s:get_mark(s:mark_words)
  if get_marks == '' | execute('mark a') | cal MarkShow() | echo 'marked' | retu | endif
  let l:now_marks = []
  let l:warr = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
  for row in split(get_marks , '\n')[1:]
    let l:r = filter(split(row, ' '), {i, v -> v != ''})
    if stridx(s:mark_words, r[0]) != -1 && r[1] == line('.')
      cal MarkSignDel() | execute('delmarks ' . r[0]) | cal MarkShow()
      echo 'delete mark '.r[0] | retu
    endif
    let l:now_marks = add(now_marks, r[0])
  endfor
  let l:can_use = filter(warr, {i, v -> stridx(join(now_marks, ''), v) == -1})
  if len(can_use) != 0
    cal MarkSignDel() | execute('mark ' . can_use[0]) | cal MarkShow()
    echo 'marked '.can_use[0]
  else
    echo 'over limit markable char'
  endif
endf

fu! MarkSignDel()
  let get_marks = s:get_mark(s:mark_words)
  if get_marks == '' | retu | endif
  let mark_dict = {}
  for row in split(get_marks, '\n')[1:]
    let l:r = filter(split(row, ' '), {i, v -> v != ''})
    let mark_dict[r[0]] = r[1]
  endfor
  for mchar in keys(mark_dict)
    let id = stridx(s:mark_words, mchar) + 1
    exe "sign unplace " . id . " file=" . expand("%:p")
    exe "sign undefine " . mchar
  endfor
endf

fu! MarkShow() abort
  let get_marks = s:get_mark(s:mark_words)
  if get_marks == '' | retu | endif
  let mark_dict = {}
  for row in split(get_marks, '\n')[1:]
    let l:r = filter(split(row, ' '), {i, v -> v != ''})
    let mark_dict[r[0]] = r[1]
  endfor
  for mchar in keys(mark_dict)
    let id = stridx(s:mark_words, mchar) + 1
    let txt = mchar
    let txthl = "CursorLineNr"
    exe "sign define " . mchar . " text=" . txt . " texthl=" . txthl
    exe "sign place " . id . " line=" . mark_dict[mchar] . " name=" . mchar . " file=" . expand("%:p")
  endfor
endf
aug sig_aus
  au!
  au BufEnter,CmdwinEnter * cal MarkShow()
aug END

fu! MarkHank(vector) abort " move to next/prev mark
  let get_marks = s:get_mark(s:mark_words)
  if get_marks == '' | echo 'no marks' | retu | endif
  let mark_dict = {} " [linenum: mark char]
  let rownums = []
  for row in split(get_marks, '\n')[1:]
    let l:r = filter(split(row, ' '), {i, v -> v != ''})
    let mark_dict[r[1]] = r[0]
    let rownums = add(rownums, r[1])
  endfor
  cal sort(rownums, a:vector == 'up' ? {x, y -> y-x} : {x, y -> x - y})
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
endf

" }}}

" ===================================================================
" t9md/vim-quickhl
" ===================================================================
" {{{

aug QuickhlManual
  au!
  au! ColorScheme * cal HlIni()
aug END
let s:search_hl= [
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
let s:now_hi = 0
fu! HlIni()
  for v in s:search_hl | exe "hi UserSearchHi" . index(s:search_hl, v) . " " . v | endfor
endf
cal HlIni()

let s:hi_reaseted = 0
fu! HiClear(cw) abort
  let s:hi_reaseted = 0
  let already = filter(getmatches(), {i, v-> has_key(v, 'pattern') ? v['pattern'] == a:cw : 0})
  if len(already) > 0 | cal matchdelete(already[0]['id']) | let s:hi_reaseted = 1 | endif
endf
fu! HiSet() abort
  let cw = expand('<cword>')
  windo cal HiClear(cw)
  if s:hi_reaseted == 1 | retu | endif
  windo cal matchadd("UserSearchHi" . s:now_hi, cw)
  let s:now_hi = s:now_hi >= len(s:search_hl)-1 ? 0 : s:now_hi + 1
endf

" }}}

" ===================================================================
" unblevable/quick-scope
" ===================================================================
" {{{

augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight FSCopePrimary ctermfg=196 cterm=underline guifg=#66D9EF guibg=#000000
  autocmd ColorScheme * highlight FSCodeSecondary ctermfg=219 cterm=underline guifg=#66D9EF guibg=#000000
  autocmd ColorScheme * highlight QuickScopeBack ctermfg=51 cterm=underline guifg=#66D9EF guibg=#000000
  autocmd ColorScheme * highlight QuickScopeBackSecond ctermfg=33 cterm=underline guifg=#66D9EF guibg=#000000
augroup END

highlight FSCopePrimary ctermfg=196 cterm=underline guifg=#66D9EF guibg=#000000
highlight FSCodeSecondary ctermfg=219 cterm=underline guifg=#66D9EF guibg=#000000
highlight QuickScopeBack ctermfg=51 cterm=underline guifg=#66D9EF guibg=#000000
highlight QuickScopeBackSecond ctermfg=33 cterm=underline guifg=#66D9EF guibg=#000000

let g:fmode_flg = 1
fu! FModeToggle()
  if g:fmode_flg == 1 | let g:fmode_flg = 0 | call FModeDeactivate()
  else | let g:fmode_flg = 1 | call FModeActivate() | endif
endf

fu! HiReset(group_name)
  let already = filter(getmatches(), {i, v -> v['group'] == a:group_name})
  if len(already) > 0 | cal matchdelete(already[0]['id']) | endif
endf

fu! HiFLine()
  cal HiReset('FSCopePrimary')
  cal HiReset('FSCodeSecondary')
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

  if len(target_arr) != 0 | cal matchaddpos("FSCopePrimary", target_arr, 16) | endif
  if len(target_arr_second) != 0 | cal matchaddpos("FSCodeSecondary", target_arr_second, 16) | endif
  if len(target_arr_back) != 0 | cal matchaddpos("QuickScopeBack", target_arr_back, 16) | endif
  if len(target_arr_back_second) != 0 | cal matchaddpos("QuickScopeBackSecond", target_arr_back_second, 16) | endif
endf

fu! FModeActivate()
  aug f_scope | au! |  au CursorMoved * cal HiFLine() | aug End
  cal HiFLine()
endf
cal FModeActivate()

fu! FModeDeactivate()
  aug f_scope | au! |  aug End
  let current_win = win_getid()
  windo cal clearmatches() " reset highlight on all window in tab
  cal win_gotoid(current_win) " return current window
endf

" }}}

" #############################################################
" ##################         PLUGINS        ###################
" #############################################################
" {{{

" my colorscheme
let s:colors = [ 'onedark.vim', 'hybrid_material.vim', 'molokai.vim' ]

" repo
" neoclide/coc.nvim has special args
let s:repos = [
    \ 'easymotion/vim-easymotion',
    \ 'mhinz/vim-startify',
    \ 'junegunn/fzf', 'junegunn/fzf.vim',
    \ 'github/copilot.vim', 'thinca/vim-quickrun', 'puremourning/vimspector',
    \ 'sheerun/vim-polyglot', 'uiiaoo/java-syntax.vim',
    \ 'vim-airline/vim-airline', 'vim-airline/vim-airline-themes',
    \ 'junegunn/goyo.vim', 'junegunn/limelight.vim',
    \ ]

" extentions
let s:coc_extentions = [
    \ 'coc-fzf-preview', 'coc-explorer', 'coc-lists', 'coc-snippets',
    \ 'coc-sh', 'coc-vimlsp', 'coc-json', 'coc-sql', 'coc-html', 'coc-css',
    \ 'coc-tsserver', 'coc-clangd', 'coc-go', 'coc-pyright', 'coc-java',
    \ ]

fu! ColorInstall()
  let cmd = "mkdir -p ~/.vim/colors && cd ~/.vim/colors && colors=('".join(s:colors, "' '")."')"
    \ . " && for v in ${colors[@]};do curl https://raw.githubusercontent.com/serna37/vim-color/master/${v} > ${v};done"
  execute("bo terminal ++shell echo 'start' && ".cmd." && echo 'end'")
endf

fu! PlugInstall(...)
  " colors
  let color_cmd = "mkdir -p ~/.vim/colors && cd ~/.vim/colors && colors=('".join(s:colors, "' '")."')"
    \ . " && for v in ${colors[@]};do curl https://raw.githubusercontent.com/serna37/vim-color/master/${v} > ${v};done"
  " plugins
  let cmd = "mkdir -p ~/.vim/pack/plugins/start && cd ~/.vim/pack/plugins/start && repos=('".join(s:repos,"' '")."')"
    \ . " && for v in ${repos[@]};do git clone --depth 1 https://github.com/${v} ;done"
    \ . " && git clone -b release https://github.com/neoclide/coc.nvim"
    \ . " && fzf/install --no-key-bindings --completion --no-bash --no-zsh --no-fish"
  cal RunCat()
  cal job_start(["/bin/zsh","-c",color_cmd])
  cal job_start(["/bin/zsh","-c",cmd], {'close_cb': function('s:coc_setup')})
  echo 'colors, plugins installing...'
  cal popup_notification("colors, plugins installing...", #{ border: [], line: &columns/4-&columns/37, close: "button" })
endf

" coc extentions
fu! s:coc_setup(ch) abort
  cal RunCatStop()
  echo 'colors, plugins installed. coc-extentions installing. PLEASE REBOOT VIM after this.'
  cal popup_notification('colors, plugins installed. coc-extentions installing. PLEASE REBOOT VIM after this.', #{ border: [], line: &columns/4-&columns/37, close: "button" })
  execute("source ~/.vim/pack/plugins/start/coc.nvim/plugin/coc.vim")
  execute("CocInstall " . join(s:coc_extentions," "))
  let cocconfig = ['{',
    \ '  \"snippets.ultisnips.pythonPrompt\": false,',
    \ '  \"explorer.icon.enableNerdfont\": true,',
    \ '  \"explorer.file.showHiddenFiles\": true,',
    \ '  \"python.formatting.provider\": \"yapf\",',
    \ '  \"pyright.inlayHints.variableTypes\": false',
    \ '}',
    \]
  for v in cocconfig | cal system('echo "'.v.'" >> ~/.vim/coc-settings.json') | endfor
  "cal coc#util#install() if git clone --depth 1, need this statement
endf

" uninstall
fu! PlugUnInstall(...)
  echo 'delete ~/.vim'
  echo 'are you sure to delete these folder ?'
  let w = inputdialog("YES (Y) / NO (N)")
  if w != 'Y' || w != 'y' | echo 'cancel' | retu | endif
  execute("bo terminal ++shell echo 'start' && rm -rf ~/.vim && echo 'end. PLEASE REBOOT VIM'")
endf

" }}}

command! ColorInstall cal ColorInstall()
command! PlugInstall cal PlugInstall()
command! PlugUnInstall cal PlugUnInstall()


" #############################################################
" ##################        TRAINING        ###################
" #############################################################

command! Popupclear call popup_clear()
command! -nargs=? TrainingWheelsProtocol call TrainingWheelsProtocol(<f-args>)

" {{{

function! TrainingWheelsProtocol(...)
  if a:0 == 0
    call TrainingWheelsPopupsActivate()
  elseif a:1 == 0
    call TrainingWheelsPopupsDeActivate()
  elseif a:1 == 1
    call TrainingWheelsPopupsActivateQuick()
  endif
endfunction

let s:training_popup_cursor1_winid = 0
let s:training_popup_cursor2_winid = 0
let s:training_popup_window1_winid = 0
let s:training_popup_window2_winid = 0
let s:training_popup_mode1_winid = 0
let s:training_popup_mode2_winid = 0
let s:training_popup_search_winid = 0
let s:training_popup_opeobj_winid = 0
let s:training_popup_tips_winid = 0
let s:training_popup_tips_win_flg = 0
let s:training_popup_tips_win_tid = 0

function! TrainingWheelsPopupsActivate()
  call TrainingWheelsPratticeFileCreate()
  let s:show_cheat_sheet_flg = 0 " my cheat sheet disable
  call TrainingWheelsPopupsAllClose()
  let s:training_info_idx = 0
  highlight TrainingNotification ctermfg=green guifg=green
  highlight Traininginfo ctermfg=cyan guifg=cyan cterm=BOLD gui=BOLD
  call popup_notification([
        \'             = Infomation =          ',
        \' Training Wheels Protocol Activated.',
        \'  ↓Create and Open practice file. ',
        \'   ~/practice.md. ',
        \'  ',
        \' :TrainingWheelsProtocol 0  to DeActivate. '
        \],#{border:[],
        \zindex:999,
        \highlight:'TrainingNotification',
        \time:3000})
  call timer_start(1000, function('TrainingInfo'))
  call timer_start(6000, function('TrainingInfo'))
  call timer_start(6500, function('TrainingPopupCursor1'))
  call timer_start(6500, function('TrainingPopupCursor1SampleMv'))
  call timer_start(10000, function('TrainingInfo'))
  call timer_start(10500, function('TrainingPopupCursor2'))
  call timer_start(10500, function('TrainingPopupCursor2SampleMv'))
  call timer_start(15000, function('TrainingInfo'))
  call timer_start(15500, function('TrainingPopupWindow1'))
  call timer_start(15500, function('TrainingPopupWindow1SampleMv'))
  call timer_start(20000, function('TrainingInfo'))
  call timer_start(20500, function('TrainingPopupWindow2'))
  call timer_start(20500, function('TrainingPopupWindow2SampleMv'))
  call timer_start(26000, function('TrainingInfo'))
  call timer_start(29000, function('TrainingInfo'))
  call timer_start(29500, function('TrainingPopupMode1'))
  call timer_start(32000, function('TrainingInfo'))
  call timer_start(35000, function('TrainingInfo'))
  call timer_start(35500, function('TrainingPopupMode2'))
  call timer_start(35500, function('TrainingPopupMode2SampleMv'))
  call timer_start(38000, function('TrainingInfo'))
  call timer_start(38500, function('TrainingPopupSearch'))
  call timer_start(38500, function('TrainingPopupSearchSampleMv'))
  call timer_start(42000, function('TrainingInfo'))
  call timer_start(45000, function('TrainingInfo'))
  call timer_start(45500, function('TrainingPopupOpeObj'))
  call timer_start(45500, function('TrainingPopupOpeObjSampleMv'))
  call timer_start(49000, function('TrainingInfo'))
  let s:training_popup_tips_win_tid = timer_start(49500, function('TrainingPopupTips'))
  call timer_start(49500, function('TrainingPopupTipsCursor'))
  call timer_start(52000, function('TrainingInfo'))
endfunction

function! TrainingWheelsPopupsActivateQuick()
  if s:training_info_idx != 0 && s:training_info_idx != len(s:training_info_txt)
    echo 'Enjoy tutorial till the end.'
    return
  endif

  let s:show_cheat_sheet_flg = 0 " my cheat sheet disable
  call popup_notification([' Traning Wheels Activated. ',' :TrainingWheelsProtocol 0  to DeActivate. '],#{border:[]})
  let s:training_info_idx = len(s:training_info_txt)
  call TrainingWheelsPopupsAllClose()
  call TrainingPopupCursor1(0)
  call TrainingPopupCursor2(0)
  call TrainingPopupWindow1(0)
  call TrainingPopupWindow2(0)
  call TrainingPopupMode1(0)
  call TrainingPopupMode2(0)
  call TrainingPopupSearch(0)
  call TrainingPopupOpeObj(0)
  let s:training_popup_tips_win_tid = timer_start(100, function('TrainingPopupTips'))
  call TrainingPopupTipsCursor(0)
endfunction

function! TrainingWheelsPopupsDeActivate()
  if s:training_info_idx == 0
    echo 'No Training Wheels.'
    return
  elseif s:training_info_idx != len(s:training_info_txt)
    echo 'Enjoy tutorial till the end.'
    return
  endif

  let s:show_cheat_sheet_flg = 1 " my cheat sheet enable
  augroup training_tips_popup
    au!
  augroup END
  call popup_notification([' Traning Wheels DeActivated. ',' :TrainingWheelsProtocol 1  to open popups without tutorial.  '],#{border:[]})
  call TrainingWheelsPopupsAllClose()
endfunction

function! TrainingWheelsPopupsAllClose()
  let s:training_popup_tips_win_flg = 0
  call timer_stop(s:training_popup_tips_win_tid)
  call popup_close(s:training_popup_cursor1_winid)
  call popup_close(s:training_popup_cursor2_winid)
  call popup_close(s:training_popup_window1_winid)
  call popup_close(s:training_popup_window2_winid)
  call popup_close(s:training_popup_mode1_winid)
  call popup_close(s:training_popup_mode2_winid)
  call popup_close(s:training_popup_search_winid)
  call popup_close(s:training_popup_opeobj_winid)
  call popup_close(s:training_popup_tips_winid)
endfunction

" [[txtarr, time], ...]
let s:training_info_idx = 0
let s:training_info_txt = [
      \[[' ======================================== ',
      \'     WELCOME TO TUTORIAL ANIMATION.   ',
      \' ======================================== ',
      \' Please watch this on full screen.  ',
      \'',
      \'    While this training mode is active, ',
      \'    always show you popups',
      \'    that learn how to operate vim. ',
      \'',
      \' Enjoy 1 min tutorial, then practice vim!'], 5000],
      \[[' This is the cursor motion at NORMAL MODE. '], 4000],
      \[[' And how to JUMP cursor in ROW is ... '], 5000],
      \[[' Then, window SCROLL motions are there. '], 5000],
      \[[' Also you can JUMP cursor ON WINDOW. '], 6000],
      \[[' When you edit file, maybe write words. ',
      \' Then you can use INSERT MODE. '], 3000],
      \[[' How to get INSERT MODE is here. '], 3000],
      \[[' Do you want to save file? '], 3000],
      \[[' COMMAND MODE is convenience. '], 3000],
      \[[' And how to SEARCH word is here. '], 3000],
      \[[' You can improve motion moreover. '], 3000],
      \[[' Use "Operator" & "TextObject". '], 4000],
      \[[' Undo Redo Repeat is ... '], 3000],
      \[[" At the end, tutorial is over. ",
      \' These popup remain until DeActivate TrainingWheelsProtocol ',
      \' Enjoy your vim life ! '], 5000],
      \]
function! TrainingInfo(timer)
  let inf = s:training_info_txt[s:training_info_idx]
  call popup_notification(inf[0],#{border:[],
        \zindex:999,
        \highlight:'Traininginfo',
        \pos:'center',
        \time:inf[1]})
  let s:training_info_idx += 1
endfunction

" cursor move
function! TrainingPopupCursor1(timer)
  let s:training_popup_cursor1_winid = popup_create([
        \'     ↑ k ',
        \' h ←   → l ',
        \'   j ↓  ',
        \],#{title: ' cursor move ',
        \border: [], zindex: 1,
        \line: 3,
        \col: &columns - 46
        \})
  cal matchaddpos("Identifier", [[1,10],[2,2],[2,14],[3,4]], 16, -1, #{window: s:training_popup_cursor1_winid})
endfunction

function! TrainingPopupCursor1SampleMv(timer)
  execute("normal gg")
  call cursor(26, 6)
  call timer_start(600, function('TrainingPopupCursor1SampleMv1'))
  call timer_start(1200, function('TrainingPopupCursor1SampleMv2'))
  call timer_start(1800, function('TrainingPopupCursor1SampleMv3'))
  call timer_start(2400, function('TrainingPopupCursor1SampleMv4'))
endfunction
function! TrainingPopupCursor1SampleMv1(timer)
  execute("normal h")
  echo("h   cursor move")
endfunction
function! TrainingPopupCursor1SampleMv2(timer)
  execute("normal j")
  echo("j   cursor move")
endfunction
function! TrainingPopupCursor1SampleMv3(timer)
  execute("normal l")
  echo("l   cursor move")
endfunction
function! TrainingPopupCursor1SampleMv4(timer)
  execute("normal k")
  echo("k   cursor move")
endfunction

" cursor jump
function! TrainingPopupCursor2(timer)
  let s:training_popup_cursor2_winid = popup_create([
        \' -[jump_in_row]------------ ',
        \'  0    b←  →w   w  e     $',
        \'  This is | the test text. ',
        \'        cursor     ',
        \' -[jump_to_char f / t]-----',
        \'               repeat ',
        \'    Th Fi    fe  ;    tx ',
        \'    ↓  ↓      ↓  ↓    ↓  ',
        \'  This is | the test text. ',
        \'        cursor     ',
        \],#{title: ' cursor jump ',
        \border: [], zindex: 1,
        \line: 3,
        \col: &columns - 31
        \})
  cal matchaddpos("Identifier", [[2,3],[2,8],[2,17],[2,21],[2,24],[2,30]], 16, -1, #{window: s:training_popup_cursor2_winid})
  cal matchaddpos("Identifier", [[5,17],[5,21]], 16, -1, #{window: s:training_popup_cursor2_winid})
  cal matchaddpos("Identifier", [[7,5,2],[7,8,2],[7,14,2],[7,18],[7,23,2]], 16, -1, #{window: s:training_popup_cursor2_winid})
  cal matchaddpos("Comment", [[3,3,7],[3,13,14],[9,3,7],[9,13,14]], 16, -1, #{window: s:training_popup_cursor2_winid})
endfunction

function! TrainingPopupCursor2SampleMv(timer)
  execute("normal gg")
  call cursor(15, 12)
  call timer_start(200, function('TrainingPopupCursor2SampleMv1'))
  call timer_start(900, function('TrainingPopupCursor2SampleMv1'))
  call timer_start(1600, function('TrainingPopupCursor2SampleMv2'))
  call timer_start(2300, function('TrainingPopupCursor2SampleMv3'))
  call timer_start(3000, function('TrainingPopupCursor2SampleMv4'))
  call timer_start(3700, function('TrainingPopupCursor2SampleMv5'))
endfunction
function! TrainingPopupCursor2SampleMv1(timer)
  execute("normal w")
  echo("w   next word first char")
endfunction
function! TrainingPopupCursor2SampleMv2(timer)
  execute("normal e")
  echo("e   next wort last char")
endfunction
function! TrainingPopupCursor2SampleMv3(timer)
  call cursor(15, 12)
  echo("and ...")
endfunction
function! TrainingPopupCursor2SampleMv4(timer)
  execute("normal fe")
  echo("fe   next first e")
endfunction
function! TrainingPopupCursor2SampleMv5(timer)
  execute("normal tx")
  echo("tx   next first x, before 1")
endfunction


" move window
function! TrainingPopupWindow1(timer)
  let s:training_popup_window1_winid = popup_create([
        \'   page top/bottom         scroll ',
        \'  -----------------   ----------------- ',
        \' | gg              | | C-f  forward    | ',
        \' |                 | |                 | ',
        \' |                 | | C-u  up         | ',
        \' |                 | | ↑               | ',
        \' | 15G (line no)   | |                 | ',
        \' |                 | | ↓               | ',
        \' |                 | | C-d  down       | ',
        \' |                 | |                 | ',
        \' | G               | | C-b  back       | ',
        \'  -----------------   ----------------- ',
        \],#{title: ' move window ',
        \border: [], zindex: 1,
        \line: 16,
        \col: &columns - 44
        \})
  cal matchaddpos("Identifier", [[3,4,2],[3,24,3]], 16, -1, #{window: s:training_popup_window1_winid})
  cal matchaddpos("Identifier", [[5,24,3]], 16, -1, #{window: s:training_popup_window1_winid})
  cal matchaddpos("Identifier", [[7,4,3]], 16, -1, #{window: s:training_popup_window1_winid})
  cal matchaddpos("Identifier", [[9,24,3]], 16, -1, #{window: s:training_popup_window1_winid})
  cal matchaddpos("Identifier", [[11,4,1],[11,24,3]], 16, -1, #{window: s:training_popup_window1_winid})
endfunction

function! TrainingPopupWindow1SampleMv(timer)
  execute("normal gg")
  call timer_start(200, function('TrainingPopupWindow1SampleMv1'))
  call timer_start(1200, function('TrainingPopupWindow1SampleMv2'))
  call timer_start(2200, function('TrainingPopupWindow1SampleMv3'))
  call timer_start(3200, function('TrainingPopupWindow1SampleMv4'))
endfunction
function! TrainingPopupWindow1SampleMv1(timer)
  execute "normal \<C-d>"
  echo("C-d   pade down")
endfunction
function! TrainingPopupWindow1SampleMv2(timer)
  execute("normal gg")
  echo("gg   page top")
endfunction
function! TrainingPopupWindow1SampleMv3(timer)
  execute("normal G")
  echo("G   page last")
endfunction
function! TrainingPopupWindow1SampleMv4(timer)
  execute("normal 15G")
  echo("15G   line 15")
endfunction

" cursor jump in window
function! TrainingPopupWindow2(timer)
  let s:training_popup_window2_winid = popup_create([
        \'   High Middle Low         paragraph         scroll stay cursor ',
        \'  -----------------    ------------------    -------------------- ',
        \' |                 |  |                  |  |                    | ',
        \' | H               |  | {                |  | == current line == | ',
        \' |                 |  | This is          |  |  zEnter            | ',
        \' |                 |  |  the | test      |  |                    | ',
        \' | M               |  |   paragraph      |  |                    | ',
        \' |                 |  | }                |  |                    | ',
        \' |                 |  | }                |  | == zz ====         | ',
        \' | L               |  | This is          |  |                    | ',
        \' |                 |  |  the test        |  |                    | ',
        \'  -----------------   |   paragraph      |  |                    | ',
        \'                      | }                |  | == z- =====        | ',
        \'  { ...up paragraph   |                  |  |                    | ',
        \'  } ...down paragraph  ------------------    --------------------  ',
        \],#{title: ' cursor jump in window ',
        \border: [], zindex: 1,
        \line: 49,
        \col: &columns - 71
        \})
  cal matchaddpos("Identifier", [[4,4],[4,25]], 16, -1, #{window: s:training_popup_window2_winid})
  cal matchaddpos("Identifier", [[5,48,6]], 16, -1, #{window: s:training_popup_window2_winid})
  cal matchaddpos("Identifier", [[7,4]], 16, -1, #{window: s:training_popup_window2_winid})
  cal matchaddpos("Identifier", [[8,25]], 16, -1, #{window: s:training_popup_window2_winid})
  cal matchaddpos("Identifier", [[9,25],[9,50,2]], 16, -1, #{window: s:training_popup_window2_winid})
  cal matchaddpos("Identifier", [[10,4]], 16, -1, #{window: s:training_popup_window2_winid})
  cal matchaddpos("Identifier", [[13,25],[13,50,2]], 16, -1, #{window: s:training_popup_window2_winid})
  cal matchaddpos("Comment", [[5,25,7],[6,26,3],[6,32,4],[7,27,9]], 16, -1, #{window: s:training_popup_window2_winid})
  cal matchaddpos("Comment", [[10,25,7],[11,26,8],[12,27,9]], 16, -1, #{window: s:training_popup_window2_winid})
endfunction

function! TrainingPopupWindow2SampleMv(timer)
  execute("normal gg")
  call cursor(15, 1)
  call timer_start(200, function('TrainingPopupWindow2SampleMv1'))
  call timer_start(800, function('TrainingPopupWindow2SampleMv2'))
  call timer_start(1400, function('TrainingPopupWindow2SampleMv3'))
  call timer_start(2200, function('TrainingPopupWindow2SampleMv4'))
  call timer_start(2600, function('TrainingPopupWindow2SampleMv4'))
  call timer_start(3400, function('TrainingPopupWindow2SampleMv5'))
  call timer_start(4200, function('TrainingPopupWindow2SampleMv6'))
  call timer_start(4500, function('TrainingPopupWindow2SampleMv7'))
endfunction
function! TrainingPopupWindow2SampleMv1(timer)
  execute("normal H")
  echo("H   window High")
endfunction
function! TrainingPopupWindow2SampleMv2(timer)
  execute("normal L")
  echo("L   window Low")
endfunction
function! TrainingPopupWindow2SampleMv3(timer)
  execute("normal M")
  echo("M   window Middle")
endfunction
function! TrainingPopupWindow2SampleMv4(timer)
  execute("normal }")
  echo("}   next paragraph")
endfunction
function! TrainingPopupWindow2SampleMv5(timer)
  execute "normal z\<CR>"
  echo("z+Enter   stay cursor, top")
endfunction
function! TrainingPopupWindow2SampleMv6(timer)
  execute("normal zz")
  echo("zz   stay cursor, middle")
endfunction
function! TrainingPopupWindow2SampleMv7(timer)
  echo("")
endfunction

" insert mode
function! TrainingPopupMode1(timer)
  let s:training_popup_mode1_winid = popup_create([
        \' -[insert_in_row]------------ ',
        \' I       i a              A ',
        \'  This is | the test text.  ',
        \'       cursor     ',
        \' -[insert_up/down_row]------- ',
        \'  O ',
        \'  This is | the test text.  ',
        \'  o     cursor      ',
        \' -[insert_completion]------- ',
        \' C-p      | completion ',
        \],#{title: ' INSERT (Esc NORMAL) ',
        \border: [], zindex: 1,
        \line: 49,
        \col: &columns - 105
        \})
  cal matchaddpos("Identifier", [2,6,[8,3],[10,2,3]], 16, -1, #{window: s:training_popup_mode1_winid})
  cal matchaddpos("Comment", [[3,3,7],[3,13,14],[7,3,7],[7,13,14]], 16, -1, #{window: s:training_popup_mode1_winid})
endfunction

" command mode
function! TrainingPopupMode2(timer)
  let s:training_popup_mode2_winid = popup_create([
        \' :w      | save file',
        \' :q      | quit',
        \' :wq     | savee & quiut',
        \' :smile  | something will happen',
        \' :echo "Hello Vim!!"  | use command in vim',
        \' :!echo "Hello Vim!!" | use command in shell ',
        \' :TrainingWheelsProtocol 0   | quit tutorial',
        \],#{title: ' COMMAND (Esc NORMAL) ',
        \border: [], zindex: 1,
        \line: 49,
        \col: 5
        \})
  cal matchaddpos("Identifier", [[1,2,2],[2,2,2],[3,2,3],[4,2,6],[5,2,19],[6,2,20]], 16, -1, #{window: s:training_popup_mode2_winid})
endfunction

function! TrainingPopupMode2SampleMv(timer)
  call timer_start(400, function('TrainingPopupMode2SampleMv1'))
endfunction
function! TrainingPopupMode2SampleMv1(timer)
  echo("Hello Vim!!")
endfunction

" search
function! TrainingPopupSearch(timer)
  let s:training_popup_search_winid = popup_create([
        \' *   | search current cursor word ',
        \' #   | search current cursor word(reverse) ',
        \' n   | next hit',
        \' N   | prev hit',
        \' /word  | search free word',
        \' :noh   | clear highlight',
        \],#{title: ' Search (NORMAL MODE) ',
        \border: [], zindex: 1,
        \line: 49,
        \col: 53
        \})
  cal matchaddpos("Identifier", [[1,2],[2,2],[3,2],[4,2],[5,2,5],[6,2,4]], 16, -1, #{window: s:training_popup_search_winid})
endfunction

function! TrainingPopupSearchSampleMv(timer)
  execute("normal gg")
  call cursor(15, 9)
  call timer_start(200, function('TrainingPopupSearchSampleMv1'))
  call timer_start(800, function('TrainingPopupSearchSampleMv2'))
  call timer_start(1200, function('TrainingPopupSearchSampleMv2'))
  call timer_start(1600, function('TrainingPopupSearchSampleMv3'))
endfunction
function! TrainingPopupSearchSampleMv1(timer)
  call feedkeys("\/test\<CR>")
endfunction
function! TrainingPopupSearchSampleMv2(timer)
  call feedkeys("n")
endfunction
function! TrainingPopupSearchSampleMv3(timer)
  call feedkeys("N")
endfunction

" operator + textobject
function! TrainingPopupOpeObj(timer)
  let s:training_popup_opeobj_winid = popup_create([
        \' -[operator]--------------------------------------- ',
        \' v    | choose (VISUAL MODE) ',
        \' S-v  | choose row (VISUAL MODE) ',
        \' y    | yank (copy) ',
        \' p P  | past left, past right ',
        \' x    | cut ',
        \' d    | delete ',
        \' c    | change (cut & INSERT MODE) ',
        \' -[textobject]------------------------------------- ',
        \' iw   | inner word',
        \' i"   | inner "" (any pair char) ',
        \' a"   | include ""  ',
        \' is   | inner sentence  ',
        \' ip   | inner paragraph  ',
        \' -[sample]----------------------------------------- ',
        \'  "This is | the test text."  ',
        \'        cursor        ',
        \' vi"y | chose "This is the test text." and copy',
        \' yi"  | copy "This is the test text." (same)',
        \],#{title: ' operator & textobject ',
        \border: [], zindex: 1,
        \line: 9,
        \col: &columns - 100
        \})
  cal matchaddpos("Identifier", [[2,2],[3,2,3],[4,2],[5,2,3],[6,2],[7,2],[8,2]], 16, -1, #{window: s:training_popup_opeobj_winid})
  cal matchaddpos("Identifier", [[10,2,2],[11,2,2],[12,2,2],[13,2,2],[14,2,2]], 16, -1, #{window: s:training_popup_opeobj_winid})
  cal matchaddpos("Comment", [[16,3,8],[16,14,15]], 16, -1, #{window: s:training_popup_opeobj_winid})
  cal matchaddpos("Identifier", [[18,2,4],[19,2,3]], 16, -1, #{window: s:training_popup_opeobj_winid})
endfunction

function! TrainingPopupOpeObjSampleMv(timer)
  call cursor(52, 13)
  execute("normal zz")
  call timer_start(200, function('TrainingPopupOpeObjSampleMv1'))
  call timer_start(800, function('TrainingPopupOpeObjSampleMv2'))
  call timer_start(1500, function('TrainingPopupOpeObjSampleMv3'))
  call timer_start(1600, function('TrainingPopupOpeObjSampleMv4'))
  call timer_start(2200, function('TrainingPopupOpeObjSampleMv5'))
  call timer_start(2900, function('TrainingPopupOpeObjSampleMv3'))
endfunction
function! TrainingPopupOpeObjSampleMv1(timer)
  echo("vi<   visual inner <>")
endfunction
function! TrainingPopupOpeObjSampleMv2(timer)
  execute("normal vi<")
endfunction
function! TrainingPopupOpeObjSampleMv3(timer)
  execute "normal \<Esc>"
  call cursor(72, 6)
  execute("normal zz")
endfunction
function! TrainingPopupOpeObjSampleMv4(timer)
  echo("vis   visual inner statement")
endfunction
function! TrainingPopupOpeObjSampleMv5(timer)
  execute("normal vis")
endfunction

" undo redo repeat
function! TrainingPopupTips(timer)
  if s:training_popup_tips_win_flg == 0
    return
  endif
  call popup_close(s:training_popup_tips_winid)
  let s:training_popup_tips_winid = popup_create([
        \' u   | undo ',
        \' C-r | redo ',
        \' .   | repeat ',
        \],#{title: ' Tips ',
        \border: [], zindex: 1,
        \line: 'cursor+1',
        \col: 'cursor+1'
        \})
  cal matchaddpos("Identifier", [[1,2],[2,2,3],[3,2]], 16, -1, #{window: s:training_popup_tips_winid})
endfunction

" add cursor hold
function! TrainingPopupTipsCursor(timer)
  let s:training_popup_tips_win_flg = 1
  augroup training_tips_popup
    au!
    autocmd CursorHold * silent call TrainingPopupTipsOpen()
    autocmd CursorMoved * silent call TrainingPopupTipsClose()
    autocmd CursorMovedI * silent call TrainingPopupTipsClose()
  augroup END
endfunction

function! TrainingPopupTipsOpen()
  call timer_stop(s:training_popup_tips_win_tid)
  let s:training_popup_tips_win_tid = timer_start(500, function('TrainingPopupTips'))
endfunction
function! TrainingPopupTipsClose()
  call timer_stop(s:training_popup_tips_win_tid)
  call popup_close(s:training_popup_tips_winid)
endfunction


let g:training_wheels_practice_file = []

" create practice file
function! TrainingWheelsPratticeFileCreate()
  " TODO
  " if すでにあるなら開くだけ
  " if vimレポ落としてるならコピー
  let repo = 'https://raw.githubusercontent.com/serna37/vim/master/practice.md'
  let cmd = 'curl '.repo.' > ~/practice.md'
  cal job_start(["/bin/zsh","-c",cmd], {'close_cb': function('TrainingWheelsPracticeFileOpen')})
endfunction

" open practice file (only tutorial)
function! TrainingWheelsPracticeFileOpen(ch) abort
  execute('e ~/practice.md')
  call cursor(26, 6)
endfunction

" }}}



