" vim:set foldmethod=marker:
" ==============================================================================
" alse see [https://github.com/serna37/vim/]
"  CONTENTS
"
"   # BASIC VIM SETTINGS
"     ## FILE .................. | file encoding, charset, vim specific setting.
"     ## VISUALIZATION ......... | enhanced visual information.
"     ## WINDOW ................ | window forcus, resize, open terminal.
"     ## MOTION ................ | row move, scroll, mark, IDE action menu.
"     ## EDIT .................. | insert mode cursor, block move.
"     ## COMPLETION ............ | indent, word completion.
"     ## SEARCH ................ | incremental search, emotion, fzf, grep, explorer.
"     ## OTHERS ................ | fast terminal, reg engin, fold.
"
"   # FUNCTIONS
"     ## ORIGINALS ............. | original / adhoc functions.
"     ## IMITATIONS ............ | imitated plugins as functions.
"     ## PLUG MANAGE ........... | plugin manager functions.
"     ## TRAINING .............. | training default vim functions.
"
"   # PLUGINS SETTING
"     ## PLUGIN VARIABLES ...... | setting for plugins without conflict.
"     ## PLUGIN KEYMAP ......... | setting for plugins without conflict.
"
"   # STARTING
"     ## STARTING .............. | functions called when vim started.
"
" ==============================================================================
let mapleader = "\<SPACE>"

" #############################################################
" ###############      BASIC VIM SETTINGS       ###############
" #############################################################
" {{{
" ##################          FILE          ################### {{{

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
aug reopenGoRow
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "norm g`\"" | endif
aug END

" }}}

" ##################     VISUALIZATION      ################### {{{

" enable syntax highlight
syntax on

" window
set background=dark " basic color
set title " show filename on terminal title
set showcmd " show enterd command on right bottom

" visible
set list " show invisible char
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:% " custom invisible char

" row number + relativenumber
set number relativenumber

" cursor
set scrolloff=5 " page top bottom offset view row
set cursorline cursorcolumn " show cursor line/column
set ruler " show row/col position number at right bottom

" show status, tabline
set laststatus=2 showtabline=2

" }}}

" ##################         WINDOW        ################### {{{

" just like
" simeji/winresizer
" window forcus move
nnoremap <C-h> <C-w>h|nnoremap <C-l> <C-w>l|nnoremap <C-k> <C-w>k|nnoremap <C-j> <C-w>j
tnoremap <C-h> <C-w>h|tnoremap <C-l> <C-w>l|tnoremap <C-k> <C-w>k|tnoremap <C-j> <C-w>j
" window resize
nnoremap <Left> 4<C-w><|nnoremap <Right> 4<C-w>>|nnoremap <Up> 4<C-w>-|nnoremap <Down> 4<C-w>+

" move buffer
nnoremap <silent><C-n> :MoveBufPrev<CR>
nnoremap <silent><C-p> :MoveBufNext<CR>
" close buffer
nnoremap <silent><Leader>x :CloseBuf<CR>

" terminal
"nnoremap <silent><Leader>t :bo terminal ++rows=10<CR>
nnoremap <silent><Leader>t :cal popup_create(term_start([&shell], #{hidden: 1, term_finish:'close'}), #{border: [], minwidth: &columns/2+&columns/4, minheight: &lines/2+&lines/4})<CR>
" terminal read only mode (i to return terminal mode)
tnoremap <Esc> <C-w>N

" zen
nnoremap <silent><Leader>z :ImitatedZenModeToggle<CR>

" }}}

" ##################         MOTION         ################### {{{

" row move
nnoremap j gj|nnoremap k gk
nnoremap <silent><Tab> 5gj:Anchor<CR>|nnoremap <silent><S-Tab> 5gk:Anchor<CR>|vnoremap <Tab> 5gj|vnoremap <S-Tab> 5gk

" comfortable scroll
nnoremap <silent><C-u> :ImitatedComfortableScroll 0 30<CR>|nnoremap <silent><C-d> :ImitatedComfortableScroll 1 30<CR>
nnoremap <silent><C-b> :ImitatedComfortableScroll 0 10<CR>|nnoremap <silent><C-f> :ImitatedComfortableScroll 1 10<CR>

" f-scope toggle
nnoremap <silent><Leader>w :ImitatedQuickScopeToggle<CR>

" mark
nnoremap <silent>mm :ImitatedBookmarksMarkToggle<CR>
nnoremap <silent>mn :ImitatedBookmarksHankDown<CR>
nnoremap <silent>mp :ImitatedBookmarksHankUp<CR>
nnoremap <silent>mc :ImitatedBookmarksClear<CR>
nnoremap <silent><Leader>m :ImitatedBookmarksList<CR>

" IDE action menu
nnoremap <silent><Leader>v :IDEMenu<CR>

" }}}

" ##################         EDIT           ################### {{{

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

" x = cut(yank register)
nnoremap x "0x|vnoremap x "0x

" p P = paste(from yank register)
nnoremap p "0p|nnoremap P "0P
vnoremap p "0p|vnoremap P "0P

" block move at visual mode
vnoremap <C-j> "zx"zp`[V`]|vnoremap <C-k> "zx<Up>"zP`[V`]

" }}}

" ##################       COMPLETION       ################### {{{

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

" }}}

" ##################         SEARCH         ################### {{{

" search
set incsearch " incremental search
set hlsearch " highlight match words
set ignorecase " ignore case search
set smartcase " don't ignore case when enterd UPPER CASE"
set shortmess-=S " show hit word's number at right bottom

" no move search word with multi highlight
nnoremap <silent>* *N:ImitatedQuickHighlight<CR>
nnoremap <silent># *N:ImitatedQuickHighlight<CR>
nnoremap <silent><Leader>q :ImitatedQuickHighlightClear<CR>

" incremental search
nnoremap <silent>s :ImitatedEasymotion<CR>
nnoremap <Leader>s /
" TODO wip

" grep result -> quickfix
au QuickFixCmdPost *grep* cwindow
if executable('rg') | let &grepprg = 'rg --vimgrep --hidden' | set grepformat=%f:%l:%c:%m | endif

" explorer
filetype plugin on
let g:netrw_liststyle = 3 | let g:netrw_altv = 1 | let g:netrw_winsize = 70
nnoremap <silent><Leader>e :cal NetrwToggle()<CR>

" fzf || fzf-imitation
nnoremap <silent><leader>f :SmartFzf fz<CR>
nnoremap <silent><leader>h :SmartFzf his<CR>
nnoremap <silent><leader>b :SmartFzf buf<CR>

" ripgrep || grep
nnoremap <silent><Leader>g :Grep<CR>
" vimgrep current file
nnoremap <silent><Leader><Leader>s :GrepCurrent<CR>

" }}}

" ##################         OTHERS         ################### {{{

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
" }}}

" #############################################################
" ##################       FUNCTIONS        ###################
" #############################################################
" {{{
" ##################       ORIGINALS        ################### {{{

" tab 5row anchor {{{
sign define anch text=> texthl=Identifier
let s:anchor = #{tid: 0}
fu! s:anchor.set() abort
  cal timer_stop(s:anchor.tid) | cal s:anchor.rm(0) | let u=line('.')+5 | let d=line('.')-5
  exe 'sign place 99 line='.u.' name=anch' | exe 'sign place 101 line='.line('.').' name=anch'
  if d > 0 | exe 'sign place 100 line='.d.' name=anch' '' | endif
  let s:anchor.tid = timer_start(2000, s:anchor.rm)
endf
fu! s:anchor.rm(tid) abort
  exe 'sign unplace 99' | exe 'sign unplace 100' | exe 'sign unplace 101'
endf
com! Anchor cal s:anchor.set()
" }}}

" switch fzf {{{
" if plugin -> switch ProjectFiles / Files
" no plugin -> call imitated fzf
fu! s:smartFzf(fz) abort
  if glob('~/.vim/pack/plugins/start/coc.nvim') == '' | cal s:fzf.exe(a:fz) | retu | endif
  let pwd = system('pwd')
  try | exe 'lcd %:h' | catch | endtry
  let gitroot = system('git rev-parse --show-superproject-working-tree --show-toplevel')
  try | exe 'lcd ' . pwd | catch | endtry
  execute(!v:shell_error ? 'CocCommand fzf-preview.ProjectFiles' : 'Files')
endf
com! -nargs=1 SmartFzf cal s:smartFzf(<f-args>)
" }}}

" grep {{{
fu! s:grep() abort
  " plugin mode
  if glob('~/.vim/pack/plugins/start/coc.nvim') != '' && executable('rg')
    echohl Special | let w = inputdialog("start ripgrep [word] >>") | echo '<<'
    if w == '' | echo 'cancel' | echohl None | retu | endif
    execute('CocCommand fzf-preview.ProjectGrep -w --ignore-case '.w)
    echohl None | retu
  endif
  " no plugin
  echo 'grep. choose ' | echohl ErrorMsg | echon '[word]' | echohl Special | echon ' [ext]' | echohl WarningMsg | echon ' [target]'
  let pwd = system('pwd') | echohl ErrorMsg | let word = inputdialog("Enter [word]>>") | echon '<<'
  if word == '' | echohl None | echo 'cancel' | retu | endif
  echohl Special | let ext = inputdialog("Enter [ext]>>") | echon '<<'
  if ext == '' | echo 'any ext' | let ext = '*' | endif
  echohl WarningMsg | let target = inputdialog("Enter [target (like ./*) pwd:".pwd."]>>")
  if target == '' | echo 'search current directory' | let target = './*' | endif
  echon '<<' | echohl None | echo 'grep [' . word . '] processing in [' . target . '] [' . ext . '] ...'
  cgetexpr system('grep -n -r --include="*.' . ext . '" "' . word . '" ' . target) | cw
  echohl ErrorMsg | echo 'grep end' | echohl None | retu
endf
com! Grep cal s:grep()
" }}}

" current file grep {{{
fu! s:grepCurrent() abort
  echohl Special | echo 'grep from this file.' | let word = inputdialog("Enter [word]>>") | echon '<<' | if word == '' | echo 'cancel' | retu | endif | echohl WarningMsg | echo 'grep ['.word.'] processing in ['.expand('%').'] ...' | exe 'vimgrep /'.word.'/gj %' | cw | echohl ErrorMsg | echon 'grep end' | echohl None
endf
com! GrepCurrent cal s:grepCurrent()
" }}}

" IDE menu {{{
let s:idemenu = #{
  \menu: [
    \'[Format]         applay format for this file',
    \'[ReName*]        rename current word recursively',
    \'[ALL PUSH]       commit & push all changes',
    \'[QuickFix-Grep*] Open Preview Popup from quickfix - from fzfpreview Ctrl+Q',
    \'[Snippet*]       edit snippets',
    \'[Run*]           run current program',
    \'[Debug*]         debug current program',
    \'[Run as Shell]   run current row as shell command',
    \'[Color random]   change colorscheme at random',
  \],
  \cheat: [
    \' (Space d) [Definition]     Go to Definition ',
    \' (Space r) [Reference]      Reference ',
    \' (Space o) [Outline]        view outline on popup ',
    \' (Space ?) [Document]       show document on popup scroll C-f/b ',
    \' (Space ,) [Next Diagnosis] jump next diagnosis ',
    \' (Space .) [Prev Diagnosis] jump prev diagnosis ',
  \],
  \colors: ['torte', 'elflord', 'pablo'],
  \colors_plug: ['onedark', 'hybrid_material', 'molokai']
\}

fu! s:idemenu.open() abort
  let s:idemenu.popid = popup_create(s:idemenu.cheat, #{title: ' Other Plugin KeyMaps ', border: [], line: &columns/4})
  cal popup_menu(s:idemenu.menu, #{title: ' IDE MENU (j / k) Enter choose | * require plugin ', border: [], filter: function(s:idemenu.choose, [{'idx': 0, 'files': s:idemenu.menu }])})
endf

fu! s:idemenu.choose(ctx, winid, key) abort
  if a:key is# 'j' && a:ctx.idx < len(a:ctx.files)-1
    let a:ctx.idx = a:ctx.idx+1
  elseif a:key is# 'k' && a:ctx.idx > 0
    let a:ctx.idx = a:ctx.idx-1
  elseif a:key is# "\<Esc>" || a:key is# "\<Space>"
    cal popup_close(s:idemenu.popid)
  elseif a:key is# "\<CR>"
    if a:ctx.idx == 0
      try | cal CocActionAsync('format')
      catch | let current_rn = line('.') | norm gg=G | exe 'norm'.current_rn.'G'
      endtry
    elseif a:ctx.idx == 1
      cal CocActionAsync('rename')
    elseif a:ctx.idx == 2
      echohl Special | let w = inputdialog("commit message>>") | if w == '' | echohl None | echo 'cancel' | retu | endif
      exe 'top terminal ++rows=10 ++shell git add .&&git commit -m "'.w.'"&&git push') | echohl None
    elseif a:ctx.idx == 3
      exe 'CocCommand fzf-preview.QuickFix'
    elseif a:ctx.idx == 4
      exe 'CocCommand snippets.editSnippets'
    elseif a:ctx.idx == 5
      exe 'QuickRun -hook/time/enable 1'
    elseif a:ctx.idx == 6
      cal vimspector#Launch()
    elseif a:ctx.idx == 7
      exe 'top terminal ++rows=10 ++shell eval '.getline('.')
    elseif a:ctx.idx == 8
      let s:idemenu.tobecolor = glob('~/.vim/colors') != '' ? s:idemenu.colors_plug[localtime() % len(s:idemenu.colors_plug)] : s:idemenu.colors[localtime() % len(s:idemenu.colors)]
      exe 'echo "change [".execute("colorscheme")[1:]."] -> [".s:idemenu.tobecolor."]"'
      cal timer_start(500, { -> execute('colorscheme '.s:idemenu.tobecolor) })
    endif
    cal popup_close(s:idemenu.popid)
  endif
  retu popup_filter_menu(a:winid, a:key)
endf

com! IDEMenu cal s:idemenu.open()
" }}}

" running cat (loading animation) {{{
let s:runcat = #{frame: 0, winid: 0, stopflg: 0}
fu! s:runcat.animation(_) abort
  cal setbufline(winbufnr(s:runcat.winid), 1, s:runcat.cat[s:runcat.frame])
  let s:runcat.frame = s:runcat.frame == 4 ? 0 : s:runcat.frame + 1
  if s:runcat.stopflg | cal popup_close(s:runcat.winid) | retu | endif
  cal timer_start(200, s:runcat.animation)
endf
fu! s:runcat.stop() abort
  let s:runcat.stopflg = 1
endf
fu! s:runcat.start() abort
  let s:runcat.stopflg = 0
  let s:runcat.winid = popup_create(s:runcat.cat[0], #{line: 1, border: [], zindex: 1})
  cal s:runcat.animation(0)
endf

" running cat AA {{{
let s:runcat.cat = [
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

com! RunCat cal s:runcat.start()
com! RunCatStop cal s:runcat.stop()
" }}}

" cheat sheet {{{

" cursor hold
" motion cheat sheet on popup

augroup cheat_sheet_hover
  au!
  autocmd CursorHold * silent cal s:CheatSheet()
  autocmd CursorMoved * silent cal s:CheatSheetClose()
  autocmd CursorMovedI * silent cal s:CheatSheetClose()
augroup END

" TODO fix cheatsheet color
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
      \' (:RunCat :RunCatStop) [running cat]',
      \' -------------------------------------------------------- ',
      \' (Space*3)      [ON/OFF Cheat Sheet] ',
      \]

" no plugin version
if glob('~/.vim/pack/plugins/start') == ''
  let s:my_vim_cheet_sheet = [
        \' --[window]---------------------------------------------- ',
        \' (C-n/p)(Space x)   [buffer tab][next/prev/close] ',
        \' (←↑↓→)(C-hjkl)  [window][resize/forcus] ',
        \' (Space t)(Space z) [terminal][Zen Mode] ',
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
        \' (:PlugInstall)      [plugins install] ',
        \' (:TrainingWheelsProtocol) [training default vim]',
        \' (:RunCat :RunCatStop) [running cat]',
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
    cal timer_stop(s:cheat_sheet_timer_id)
    retu
  endif
  if s:cheat_sheet_open_flg == 0
    let s:cheat_sheet_open_flg = 1
    cal timer_stop(s:cheat_sheet_timer_id)
    let s:cheat_sheet_timer_id = timer_start(10000, function("s:CheatSheetPopup"))
  endif
endf
fu! s:CheatSheetClose()
  if s:show_cheat_sheet_flg == 0
    cal timer_stop(s:cheat_sheet_timer_id)
    retu
  endif
  let s:cheat_sheet_open_flg = 0
  cal popup_close(s:cheatwinid)
  cal timer_stop(s:cheat_sheet_timer_id)
endf

nnoremap <silent><Leader><Leader><Leader> :cal PopupFever()<CR>:cal ToggleCheatHover()<CR>
let s:show_cheat_sheet_flg = 0
fu! CheatAlert(tid)
  execute("echohl ErrorMsg | echo '[INFO] Space * 3 to enable cheat sheet !!' | echohl None")
endf
if has('vim_starting')
  cal timer_start(200, function("CheatAlert"))
endif
let s:recheatwinid = 0
fu! PopupFever()
  cal s:runcat.start()
  let s:recheatwinid = popup_create(s:my_vim_cheet_sheet, #{ title: ' Action Cheet Sheet ', border: [], line: &columns/4 })
  let s:logowinid = popup_create(g:btr_logo, #{ border: [] })
endf
fu! PopupFeverStop()
  cal s:runcat.stop()
  cal popup_close(s:recheatwinid )
  cal popup_close(s:logowinid)
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
  cal timer_start(3000, { -> PopupFeverStop()})
endf

" }}}

" completion {{{

" TODO なんか変
fu! s:completion()
  let exclude_completion_chars = [" ", "(", "[", "{", "<", "'", '"', "`"]
  if col('.') == 1 || match(exclude_completion_chars, getline('.')[col('.')-2]) != -1 | retu | endif
  if !pumvisible() | cal feedkeys("\<Tab>") | endif
endf
if glob('~/.vim/pack/plugins/start/coc.nvim')  == ''
  autocmd TextChangedI,TextChangedP * silent cal s:completion()
endif


" }}}

" }}}

" ##################       IMITATIONS       ################### {{{

" ===================================================================
" jiangmiao/auto-pairs
" ===================================================================
" {{{
inoremap ( ()<LEFT>|inoremap [ []<LEFT>|inoremap { {}<LEFT>|inoremap < <><LEFT>
inoremap ' ''<LEFT>|inoremap " ""<LEFT>|inoremap ` ``<LEFT>
" TODO doesn't work?'
fu! AutoPairsDelete()
  let pairs_start = ["(", "[", "{", "<", "'", '"', "`"] | let pairs_end = [")", "]", "}", ">", "'", '"', "`"]
  let pre_cursor_char = getline('.')[col('.')-2] | let on_cursor_char = getline('.')[col('.')-1]
  let pre_chk = match(pairs_start, pre_cursor_char) | let on_chk = match(pairs_end, on_cursor_char)
  if pre_chk != -1 && pre_chk == on_chk | retu "\<RIGHT>\<BS>\<BS>" | endif
  retu "\<BS>"
endf
inoremap <buffer><silent><BS> <C-R>=AutoPairsDelete()<CR>
" }}}

" ===================================================================
" preservim/nerdtree
" ===================================================================
" {{{

" TODO
""augroup netrw_motion
""  autocmd!
""  autocmd fileType netrw cal NetrwMotion()
""augroup END

fu! NetrwMotion()
  nnoremap <buffer><C-l> <C-w>l
  autocmd CursorMoved * cal NetrwOpenJudge()
endf

fu! NetrwOpenJudge()
  " XXX windows gitbashだとmapしたら上手く動かない
  " キー入力監視に変えるか？
  nnoremap <buffer><CR> <Plug>NetrwLocalBrowseCheck
  if getline('.')[len(getline('.'))-1] != '/'
    nnoremap <buffer><CR> <Plug>NetrwLocalBrowseCheck:cal NetrwOpen()<CR>
  endif
endf

fu! NetrwOpen()
  cal feedkeys("\<C-l>:q\<CR>\<Space>e")
endf

fu! s:create_winid2bufnr_dict() abort
  let winid2bufnr_dict = {}
  for bnr in range(1, bufnr('$'))
    for wid in win_findbuf(bnr) | let winid2bufnr_dict[wid] = bnr | endfor
  endfor | retu winid2bufnr_dict
endf
fu! s:winid2bufnr(wid) abort
  retu s:create_winid2bufnr_dict()[a:wid]
endf

fu! NetrwToggle()
  for win_no in range(1, winnr('$'))
    let win_id = win_getid(win_no)
    if bufname(s:winid2bufnr(win_id)) == 'NetrwTreeListing' | cal win_execute(win_id, 'close') | retu | endif
  endfor | execute('Vex 15')
endf


" }}}

" ===================================================================
" vim-airline/vim-airline
" ===================================================================
" {{{
" status line with git info
const g:modes = {'i':'1* INSERT', 'n':'2* NORMAL', 'R':'3* REPLACE', 'c':'4* COMMAND', 't':'4* TERMIAL', 'v':'5* VISUAL', 'V':'5* VISUAL', "\<C-v>":'5* VISUAL'}
const g:ff_table = {'dos' : 'CRLF', 'unix' : 'LF', 'mac' : 'CR'}
let g:gitinf = 'no git '
fu! s:gitinfo() abort
  try | cal system('git status') | catch | retu | endtry
  if trim(system('cd '.expand('%:h').' && git status')) =~ "^fatal:" | let g:gitinf = 'no repo ' | retu | endif
  let cmd = "cd ".expand('%:h')." && git status --short | awk -F ' ' '{print($1)}' | grep -c "
  let a = trim(system(cmd."'A'")) | let aa = a !='0'?'+'.a :''
  let m = trim(system(cmd."-e 'M' -e 'D'")) | let mm = m !='0'?'!'.m :''
  let nw = trim(system(cmd."'??'")) | let nwnw = nw !='0'?'?'.nw :''
  let er = trim(system(cmd."'U'")) | let ee = er !='0'?'✗'.er :''
  let g:gitinf = trim(system("git branch | awk -F '*' '{print($2)}'")).join([aa,mm,nwnw,ee],' ')
endf
aug statusLine
  au!
  au BufWinEnter,BufWritePost * cal s:gitinfo()
  au ColorScheme * hi User1 cterm=bold ctermfg=7 ctermbg=4
  au ColorScheme * hi User1 cterm=bold ctermfg=7 ctermbg=4
  au ColorScheme * hi User2 cterm=bold ctermfg=7 ctermbg=34
  au ColorScheme * hi User3 cterm=bold ctermbg=5 ctermfg=0
  au ColorScheme * hi User4 cterm=bold ctermfg=7 ctermbg=56
  au ColorScheme * hi User5 cterm=bold ctermfg=7 ctermbg=5
  au ColorScheme * hi User6 ctermfg=7 ctermbg=8
aug END
fu! g:SetStatusLine() abort
  let mode = match(keys(g:modes), mode()) != -1 ? g:modes[mode()] : '5* SP'
  retu '%'.mode.' %*➤ %6* %<%F%m%r%h%w %0* %6* %{g:gitinf}%0* %=%'.split(mode,' ')[0].' %p%% %l/%L %02v [%{&fenc!=""?&fenc:&enc}][%{g:ff_table[&ff]}] %*'
endf
set stl=%!g:SetStatusLine()

" tabline
aug tabLine
  au ColorScheme * hi UserBuflineActive ctermfg=7 ctermbg=34
  au ColorScheme * hi UserBuflineDeactive ctermfg=7 ctermbg=8
  au ColorScheme * hi UserBuflineModified ctermfg=7 ctermbg=4
  au ColorScheme * hi UserTablineActive ctermfg=7 ctermbg=34
  au ColorScheme * hi UserTablineDeactive ctermfg=7 ctermbg=8
aug END
fu! s:buffers_label() abort
  let b = '' | for v in split(execute('ls'), '\n')->map({ _,v -> split(v, ' ')})
    let x = copy(v)->filter({ _,v -> !empty(v) })
    if stridx(x[1], 'F') == -1 && stridx(x[1], 'R') == -1
      let hi = stridx(x[1], '%') != -1 ? '%#UserBuflineActive#' : '%#UserBuflineDeactive#'
      if x[2] == '+' | let hi = '%#UserBuflineModified#' | endif
      let f = x[2] == '+' ? '✗'.x[3] : x[2] | let b = b.'%'.x[0].'T'.hi.f.' ⁍|'.'%T%#TabLineFill# '
    endif
  endfor | retu b
endf
fu! s:tabpage_label(n) abort
  let hi = a:n is tabpagenr() ? '%#UserTablineActive#' : '%#UserTablineDeactive#'
  let bufnrs = tabpagebuflist(a:n)
  let no = len(bufnrs) | if no is 1 | let no = '' | endif
  let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '✗' : ''
  let fname = pathshorten(bufname(bufnrs[tabpagewinnr(a:n) - 1]))
  retu '%'.a:n.'T'.hi.no.mod.fname.' ⁍|'.'%T%#TabLineFill#'
endf
fu! g:SetTabLine() abort
  if tabpagenr('$') == 1 | retu s:buffers_label() | endif
  retu range(1,tabpagenr('$'))->map('s:tabpage_label(v:val)')->join(' ').' %#TabLineFill#%T'
endf
set tabline=%!g:SetTabLine()

fu! s:moveBuf(flg) abort
  let current_id = '' | let buf_arr = []
  for v in split(execute('ls'), '\n')->map({ _,v -> split(v, ' ')})
    let x = copy(v)->filter({ _,v -> !empty(v) })
    if stridx(x[1], 'F') == -1 && stridx(x[1], 'R') == -1
      cal add(buf_arr, x[0])
      if stridx(x[1], '%') != -1 | let current_id = x[0] | endif
    endif
  endfor
  let buf_idx = a:flg == 'next' ? match(buf_arr, current_id) + 1 : match(buf_arr, current_id) - 1
  let buf_id = buf_idx == len(buf_arr) ? buf_arr[0] : buf_arr[buf_idx]
  exe 'b '.buf_id
endf

fu! s:closeBuf() abort
  let now_b = bufnr('%') | execute("norm \<C-n>") | execute('bd ' . now_b)
endf

com! MoveBufPrev cal s:moveBuf('prev')
com! MoveBufNext cal s:moveBuf('next')
com! CloseBuf cal s:closeBuf()
" }}}

" ===================================================================
" yuttie/comfortable-motion.vim
" ===================================================================
" {{{
let s:scroll = #{tid: 0, curL: '', curC: ''}
fu! s:scroll.exe(vector, delta) abort
  if !empty(s:scroll.tid) | retu | endif
  cal timer_stop(s:scroll.tid) | cal s:scroll.toggle(0)
  let vec = a:vector == 0 ? "\<C-y>" : "\<C-e>"
  let s:scroll.tid = timer_start(a:delta, { -> feedkeys(vec) }, {'repeat': -1})
  cal timer_start(600, s:scroll.stop) | cal timer_start(600, s:scroll.toggle)
endf
fu! s:scroll.stop(_) abort
  cal timer_stop(s:scroll.tid) | let s:scroll.tid = 0
endf
fu! s:scroll.toggle(tid) abort
  if empty(a:tid)
    let s:scroll.curL = execute('set cursorline?')->trim()
    let s:scroll.curC = execute('set cursorcolumn?')->trim()
    set nocursorline nocursorcolumn
    cal s:fmode.deactivate()
    retu
  endif
  if s:scroll.curL !~'^no' | set cursorline | endif
  if s:scroll.curC !~'^no' | set cursorcolumn | endif
  cal s:fmode.takeover()
endf
com! -nargs=+ ImitatedComfortableScroll cal s:scroll.exe(<f-args>)
" }}}

" ===================================================================
" junegunn/fzf.vim
" ===================================================================
" {{{
let s:fzf = #{
  \not_path_arr: [
     \'"*/.**/*"',
     \'"*node_modules/*"', '"*target/*"'
     \'"*Applications/*"', '"*AppData/*"', '"*Library/*"',
     \'"*Music/*"', '"*Pictures/*"', '"*Movies/*"', '"*Videos/*"'
     \'"*OneDrive/*"',
  \],
  \chache: [],
  \start_fz: ''
\}
let s:fzf.find_cmd = 'find . -type f -name "*" -not -path '.join(s:fzf.not_path_arr, ' -not -path ')
let s:fzf.searched = execute('pwd')[1:] " first char is ^@, so trim

fu! s:fzf.exe(fz) abort " open window
  if stridx(execute('pwd')[1:], s:fzf.searched) == -1 || empty(s:fzf.chache) | cal s:fzf.refind() | endif
  let s:fzf.start_fz = a:fz
  let s:fzf.mode = s:fzf.start_fz == 'fz' ? 'fzf' : 'his'
  let s:fzf.mode_title = s:fzf.mode == 'his' ? '(*^-^)/ BUF & MRU' : '(*"@w@)/ FZF ['.s:fzf.searched.']'
  let s:fzf.pwd_prefix = 'pwd:['.execute('pwd')[1:].']>>'
  let s:fzf.enter_keyword = []
  let s:fzf.his_result = split(execute('ls'), '\n')->map({ _,v -> split(split(v, ' ')->filter({ _,x -> !empty(x) })[2], '"')[0] })
   \+split(execute('oldfiles'), '\n')->map({ _,v -> split(v, ': ')[1] })
  let s:fzf.filterd = s:fzf.mode == 'his' ? s:fzf.his_result[0:29] : s:fzf.chache[0:29]
  let s:fzf.winid_enter = popup_create(s:fzf.pwd_prefix, #{title: 'MRU<>FZF:<Tab>/choose:<CR>/end:<Esc>/chache refresh:<C-f>',  border: [], zindex: 99, minwidth: &columns/2, maxwidth: &columns/2, maxheight: 1, line: &columns/4-&columns/36, mapping: 0, filter: s:fzf.refresh_result})
  cal s:fzf.open_result_win()
endf
fu! s:fzf.open_result_win() abort
  let s:fzf.cidx = 0
  let s:fzf.winid_result = popup_menu(s:fzf.filterd, #{title: s:fzf.mode_title, border: [], zindex: 98, minwidth: &columns/2, maxwidth: &columns/2, minheight: 2, maxheight: &lines/2, filter: s:fzf.choose})
endf

fu! s:fzf.refind() abort " async find command
  cal s:runcat.start() | let s:fzf.chache = [] | let s:fzf.searched = execute('pwd')[1:]
  echohl WarningMsg | echo 'find files in ['.s:fzf.searched.'] and chache ...' | echohl None
  cal job_start(s:fzf.find_cmd, #{out_cb: s:fzf.find_start, close_cb: s:fzf.find_end})
endf
fu! s:fzf.find_start(ch, msg) abort
  cal add(s:fzf.chache, a:msg)
endf
fu! s:fzf.find_end(ch) abort
  echohl Special | echo 'find files in ['.s:fzf.searched.'] and chache is complete!!' | echohl None | cal s:runcat.stop()
  " after init, see fzf if specified
  if s:fzf.start_fz == 'fz' && s:fzf.mode == 'his'
    cal win_execute(s:fzf.winid_enter, 'cal feedkeys("\<Tab>")')
  elseif s:fzf.start_fz == 'fz' && s:fzf.mode == 'fzf'
    cal win_execute(s:fzf.winid_enter, 'cal feedkeys("\<Tab>\<Tab>")')
  endif
endf

fu! s:fzf.refresh_result(winid, key) abort " event to draw search result
  if a:key is# "\<Esc>"
    cal popup_close(s:fzf.winid_enter) | cal popup_close(s:fzf.winid_result) | retu 1
  elseif a:key is# "\<CR>"
    cal popup_close(s:fzf.winid_enter) | retu 1
  elseif a:key is# "\<C-f>"
    cal s:fzf.refind()
  elseif a:key is# "\<C-v>"
    for i in range(0,strlen(@")-1) | cal add(s:fzf.enter_keyword, strpart(@",i,1)) | endfor
  elseif a:key is# "\<Tab>"
    let s:fzf.mode = s:fzf.mode == 'his' ? 'fzf' : 'his'
    let s:fzf.mode_title = s:fzf.mode == 'his' ? '(*^-^)/ BUF & MRU' : '(*"@w@)/ FZF [' . s:fzf.searched . ']'
    cal popup_close(s:fzf.winid_result)
    if s:fzf.mode == 'his'
      let s:fzf.filterd = len(s:fzf.enter_keyword) != 0 ? matchfuzzy(s:fzf.his_result, join(s:fzf.enter_keyword, '')) : s:fzf.his_result
    else
      let s:fzf.filterd = len(s:fzf.enter_keyword) != 0 ? matchfuzzy(s:fzf.chache, join(s:fzf.enter_keyword, '')) : s:fzf.chache
    endif
    let s:fzf.filterd = s:fzf.filterd[0:29]
    cal s:fzf.open_result_win()
    retu 1
  elseif a:key is# "\<BS>" && len(s:fzf.enter_keyword) > 0
    unlet s:fzf.enter_keyword[len(s:fzf.enter_keyword)-1]
  elseif a:key is# "\<BS>" && len(s:fzf.enter_keyword) == 0
  " noop
  elseif a:key is# "\<C-w>"
    let s:fzf.enter_keyword = []
  elseif strtrans(a:key) == "<80><fd>`"
    " noop (for polyglot bug adhoc)
    retu
  else
    let s:fzf.enter_keyword = add(s:fzf.enter_keyword, a:key)
  endif

  if s:fzf.mode == 'his'
    let s:fzf.filterd = len(s:fzf.enter_keyword) != 0 ? matchfuzzy(s:fzf.his_result, join(s:fzf.enter_keyword, '')) : s:fzf.his_result
  else
    let s:fzf.filterd = len(s:fzf.enter_keyword) != 0 ? matchfuzzy(s:fzf.chache, join(s:fzf.enter_keyword, '')) : s:fzf.chache
  endif

  cal setbufline(winbufnr(s:fzf.winid_enter), 1, s:fzf.pwd_prefix . join(s:fzf.enter_keyword, ''))
  cal setbufline(winbufnr(s:fzf.winid_result), 1, map(range(1,30), { i,v -> '' }))
  cal setbufline(winbufnr(s:fzf.winid_result), 1, s:fzf.filterd[0:29]) " re view only first 30 files
  retu a:key is# "x" || a:key is# "\<Space>" ? 1 : popup_filter_menu(a:winid, a:key)
endf

fu! s:fzf.choose(winid, key) abort
  if a:key is# 'j' | let s:fzf.cidx = s:fzf.cidx == len(s:fzf.filterd)-1 ? len(s:fzf.filterd)-1 : s:fzf.cidx + 1
  elseif a:key is# 'k' | let s:fzf.cidx = s:fzf.cidx == 0 ? 0 : s:fzf.cidx - 1
  elseif a:key is# "\<CR>" | retu s:fzf.open(a:winid, 'e', s:fzf.filterd[s:fzf.cidx])
  elseif a:key is# "\<C-v>" | retu s:fzf.open(a:winid, 'vnew', s:fzf.filterd[s:fzf.cidx])
  elseif a:key is# "\<C-t>" | retu s:fzf.open(a:winid, 'tabnew', s:fzf.filterd[s:fzf.cidx])
  endif | retu popup_filter_menu(a:winid, a:key)
endf
fu! s:fzf.open(winid, op, f) abort
  cal popup_close(a:winid) | cal s:runcat.stop() | exe a:op a:f | retu 1
endf

" }}}

" ===================================================================
" MattesGroeger/vim-bookmarks
" ===================================================================
" {{{
let s:mark = #{words: 'abcdefghijklmnopqrstuvwxyz'}
fu! s:mark.get(tar) abort
  try | retu execute('marks '.a:tar) | catch | retu '' | endtry
endf

fu! s:mark.list() abort
  let get_marks = s:mark.get(s:mark.words) | if empty(get_marks) | echo 'no marks' | retu | endif | let markdicarr = []
  for v in split(get_marks , '\n')[1:]
    cal add(markdicarr, #{linenum: str2nr(split(v, ' ')->filter({ _,v -> !empty(v) })[1]), val: v})
  endfor
  let marks_this = markdicarr->sort({ x, y -> x.linenum - y.linenum })->map({ _,v -> v.val })
  cal popup_menu(marks_this, #{title: 'choose marks', border: [], zindex: 100, minwidth: &columns/2, maxwidth: &columns/2, minheight: 2, maxheight: &lines/2, filter: function(s:mark.choose, [{'idx': 0, 'files': marks_this}])})
endf

fu! s:mark.choose(ctx, winid, key) abort
  if a:key is# 'j' && a:ctx.idx < len(a:ctx.files)-1 | let a:ctx.idx = a:ctx.idx+1
  elseif a:key is# 'k' && a:ctx.idx > 0 | let a:ctx.idx = a:ctx.idx-1
  elseif a:key is# "\<CR>" | exe 'norm!`'.a:ctx.files[a:ctx.idx][1]
  endif | retu popup_filter_menu(a:winid, a:key)
endf

fu! s:mark.toggle() abort
  let get_marks = s:mark.get(s:mark.words)
  if empty(get_marks) | execute('mark a') | cal s:mark.sign() | echo 'marked' | retu | endif
  let now_marks = [] | let warr = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
  for row in split(get_marks , '\n')[1:]
    let r = split(row, ' ')->filter({ _,v -> !empty(v) })
    if stridx(s:mark.words, r[0]) != -1 && r[1] == line('.')
      cal s:mark.clear_sign() | exe 'delmarks '.r[0] | cal s:mark.sign() | echo 'delete mark '.r[0] | retu
    endif
    cal add(now_marks, r[0])
  endfor
  let can_use = warr->filter({ _,v -> stridx(join(now_marks, ''), v) == -1 })
  if !empty(can_use) | cal s:mark.clear_sign() | exe 'mark '.can_use[0] | cal s:mark.sign() | echo 'marked '.can_use[0]
  else | echo 'over limit markable char' | endif
endf

fu! s:mark.clear_sign()
  let get_marks = s:mark.get(s:mark.words) | if empty(get_marks) | retu | endif
  let mark_dict = {}
  for row in split(get_marks, '\n')[1:]
    let r = split(row, ' ')->filter({ _,v -> !empty(v) }) | let mark_dict[r[0]] = r[1]
  endfor
  for mchar in keys(mark_dict)
    let id = stridx(s:mark.words, mchar) + 1
    exe 'sign unplace '.id.' file='.expand('%:p') | exe 'sign undefine '.mchar
  endfor
endf

fu! s:mark.sign() abort
  let get_marks = s:mark.get(s:mark.words) | if empty(get_marks) | retu | endif
  let mark_dict = {}
  for row in split(get_marks, '\n')[1:]
    let r = split(row, ' ')->filter({ _,v -> !empty(v) }) | let mark_dict[r[0]] = r[1]
  endfor
  for mchar in keys(mark_dict)
    let id = stridx(s:mark.words, mchar) + 1
    exe 'sign define '.mchar.' text='.mchar.' texthl=CursorLineNr'
    exe 'sign place '.id.' line='.mark_dict[mchar].' name='.mchar.' file='. expand('%:p')
  endfor
endf
aug sig_aus
  au!
  au BufEnter,CmdwinEnter * cal s:mark.sign()
aug END

fu! s:mark.hank(vector) abort " move to next/prev mark
  let get_marks = s:mark.get(s:mark.words) | if empty(get_marks) | echo 'no marks' | retu | endif
  let mark_dict = {} " [linenum: mark char]
  let rownums = []
  for row in split(get_marks, '\n')[1:]
    let r = split(row, ' ')->filter({ _,v -> !empty(v) }) | let mark_dict[r[1]] = r[0]
    cal add(rownums, r[1])
  endfor
  cal sort(rownums, a:vector == 'up' ? {x, y -> y-x} : {x, y -> x - y})
  for rownum in rownums
    if a:vector == 'down' && rownum > line('.')
      exe 'norm! `' . mark_dict[rownum] | echo index(rownums, rownum) + 1 . '/' . len(rownums) | retu
    elseif a:vector == 'up' && rownum < line('.')
      exe 'norm! `' . mark_dict[rownum] | echo len(rownums) - index(rownums, rownum) . '/' . len(rownums) | retu
    endif
  endfor
  echo 'last mark'
endf

fu! s:mark.clear() abort
  cal s:mark.clear_sign() | delmarks!
endf

com! ImitatedBookmarksMarkToggle cal s:mark.toggle()
com! ImitatedBookmarksHankDown cal s:mark.hank('down')
com! ImitatedBookmarksHankUp cal s:mark.hank('up')
com! ImitatedBookmarksClear cal s:mark.clear()
com! ImitatedBookmarksList cal s:mark.list()
" }}}

" ===================================================================
" t9md/vim-quickhl
" ===================================================================
" {{{
let s:quickhl = #{hlidx: 0, reseted: 0}
aug quickhl
  au!
  au! ColorScheme * cal s:quickhl.hlini()
aug END
let s:quickhl.hl= [
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
fu! s:quickhl.hlini() abort
  for v in s:quickhl.hl | exe 'hi UserSearchHi'.index(s:quickhl.hl, v).' '.v | endfor
endf
fu! s:quickhl.reset(cw) abort
  let s:quickhl.reseted = 0
  let already = getmatches()->filter({ _,v -> has_key(v, 'pattern') ? v.pattern == a:cw : 0 })
  if !empty(already) | cal matchdelete(already[0].id) | let s:quickhl.reseted = 1 | endif
endf
fu! s:quickhl.set() abort
  let current_win = winnr() | let cw = expand('<cword>') | windo cal s:quickhl.reset(cw)
  if s:quickhl.reseted | exe current_win.'wincmd w' | retu | endif
  windo cal matchadd('UserSearchHi'.s:quickhl.hlidx, cw)
  let s:quickhl.hlidx = s:quickhl.hlidx >= len(s:quickhl.hl)-1 ? 0 : s:quickhl.hlidx + 1
  exe current_win.'wincmd w'
endf
fu! s:quickhl.clear() abort
  let current_win = winnr()
  windo cal getmatches()->filter({ _,v -> v.group =~ 'UserSearchHi.*' })->map('execute("cal matchdelete(v:val.id)")')
  exe current_win.'wincmd w'
endf
com! ImitatedQuickHighlight cal s:quickhl.set()
com! ImitatedQuickHighlightClear noh | cal s:quickhl.clear()
" }}}

" ===================================================================
" unblevable/quick-scope
" ===================================================================
" {{{
let s:fmode = #{flg: 1}
aug fmode_colors
  au!
  au ColorScheme * hi FScopePrimary ctermfg=196 cterm=underline guifg=#66D9EF guibg=#000000
  au ColorScheme * hi FScopeSecondary ctermfg=219 cterm=underline guifg=#66D9EF guibg=#000000
  au ColorScheme * hi FScopeBackPrimary ctermfg=51 cterm=underline guifg=#66D9EF guibg=#000000
  au ColorScheme * hi FScopeBackSecondary ctermfg=33 cterm=underline guifg=#66D9EF guibg=#000000
aug END

fu! s:fmode.set() abort
  cal getmatches()->filter({ _,v -> v.group =~ 'FScope.*' })->map('execute("cal matchdelete(v:val.id)")')
  let rn = line('.') | let cn = col('.') | let rtxt = getline('.')
  let tar = [] | let tar2 = [] | let bak = [] | let bak2 = []
  let offset = 0
  while offset != -1
    let start = matchstrpos(rtxt, '\<.', offset)
    let offset = matchstrpos(rtxt, '.\>', offset)[2]
    let ashiato = start[1] >= cn ? rtxt[cn:start[1]-1] : rtxt[start[2]+1:cn]
    if stridx(ashiato, start[0]) == -1 && start[0] =~ '[ -~]'
      cal add(start[1] >= cn ? tar : bak, [rn, start[2]]) " uniq char
    elseif start[2] > 0 && start[0] =~ '[ -~]'
      let next_char = rtxt[start[2]:start[2]]
      if start[1] >= cn
        cal add(stridx(ashiato, next_char) == -1 ? tar : tar2, [rn, start[2]+1]) " uniq char
      else
        cal add(stridx(ashiato, next_char) == -1 ? bak  : bak2 , [rn, start[2]+1])
      endif
    endif
  endwhile
  if !empty(tar) | cal matchaddpos('FScopePrimary', tar, 16) | endif
  if !empty(tar2) | cal matchaddpos('FScopeSecondary', tar2, 16) | endif
  if !empty(bak) | cal matchaddpos('FScopeBackPrimary', bak, 16) | endif
  if !empty(bak2) | cal matchaddpos('FScopeBackSecondary', bak2, 16) | endif
endf

fu! s:fmode.activate() abort
  aug f_scope
    au!
    au CursorMoved * cal s:fmode.set()
  aug End
  cal s:fmode.set()
endf
cal s:fmode.activate()

fu! s:fmode.deactivate() abort
  aug f_scope
    au!
  aug End
  let current_win = win_getid()
  windo cal getmatches()->filter({ _,v -> v.group =~ 'FScope.*' })->map('execute("cal matchdelete(v:val.id)")')
  cal win_gotoid(current_win)
endf

fu! s:fmode.toggle() abort
  if s:fmode.flg | let s:fmode.flg = 0 | cal s:fmode.deactivate() | else | let s:fmode.flg = 1 | cal s:fmode.activate() | endif
endf
fu! s:fmode.takeover() abort
  if s:fmode.flg | cal s:fmode.activate() | else | cal s:fmode.deactivate() | endif
endf

com! ImitatedQuickScopeToggle cal s:fmode.toggle()
" }}}

" ===================================================================
" junegunn/goyo.vim
" ===================================================================
" {{{
let s:zen_mode_flg = 0
fu! s:zenModeToggle() abort
  if !empty(s:zen_mode_flg)
    let s:zen_mode_flg = 0 | set number cursorline cursorcolumn laststatus=2 showtabline=2 | tabc | syntax on | retu
  endif
  let s:zen_mode_flg = 1 | tab split | norm zR
  set nonumber norelativenumber nocursorline nocursorcolumn laststatus=0 showtabline=0
  vert to new | setl buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nonu noru winfixheight
  vert res 40 | exe winnr('#').'wincmd w'
  vert bo new | setl buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nonu noru winfixheight
  vert res 40 | exe winnr('#').'wincmd w'
  for grp in ['NonText', 'FoldColumn', 'ColorColumn', 'VertSplit', 'StatusLine', 'StatusLineNC', 'SignColumn']
    exe 'hi '.grp.' ctermfg=black' | exe 'hi '.grp.' ctermbg=NONE' | exe 'hi '.grp.' cterm=NONE'
  endfor
  setl number relativenumber
endf
com! ImitatedZenModeToggle cal s:zenModeToggle()
" }}}

" ===================================================================
" easymotion/vim-easymotion
" ===================================================================
" {{{
" m, g read some function? doesn't work just as I want
let s:emotion = #{keypos: [], klen: 1, keys: ['s', 'w', 'a', 'd', 'j', 'k', 'h', 'l'], popid: 0}

fu! s:emotion.exe() abort
  " fold all open
  norm zR
  " get target chars in current window without empty line
  " [{'row': row number, 'col': [ col number, ... ]}...]
  let s:emotion.keypos = [] | let s:emotion.klen = 1 | let wininfo = [] | let tarcnt = 0 | let rn = line('w0') | let crn = line('.')
  for l in getline('w0', 'w$')
    " loop row without 'including MultiByte' and 'empty', get head chars
    " 日本語は1文字でマルチバイト3文字分だが、カーソル幅は2なのでめんどい、日本語を含む行は弾く
    if l !~ '^[ -~]\+$' | let rn+=1 | continue | endif
    let chars = [] | let ofst = 0
    while ofst != -1
      let st = matchstrpos(l, '\<.', ofst) | let ofst = matchstrpos(l, '.\>', ofst)[2]
      if st[0] != '' | cal add(chars, st[2]) | endif
    endwhile
    if !empty(chars) | cal add(wininfo, #{row: rn, col: chars}) | endif
    let tarcnt = tarcnt+len(chars) | let rn+=1
  endfor
  if tarcnt==0 | retu | endif
  " calc key stroke length, keyOrder is 'ssw' = [0,0,1]
  while tarcnt > pow(len(s:emotion.keys), s:emotion.klen) | let s:emotion.klen+=1 | endwhile
  let keyOrder = range(1, s:emotion.klen)->map({->0})
  " sort near current line, create 's:emotion_keypos' map like this
  " [{'row': 1000, 'col': [{'key': 'ssw', 'pos': 7}, ... ]}, ... ]
  for r in sort(deepcopy(wininfo), { x,y -> abs(x.row-crn) - abs(y.row-crn) })
    let tmp = []
    for col in r.col
      cal add(tmp, #{key: copy(keyOrder)->map({i,v->s:emotion.keys[v]})->join(''), pos: col})
      let keyOrder = s:emotion.incrementNOrder(len(s:emotion.keys)-1, keyOrder)
    endfor
    cal add(s:emotion.keypos, #{row: r.row, col: tmp})
  endfor
  " draw , disable f-scope(with clear matches)
  cal s:fmode.deactivate()
  for rn in range(line('w0'), line('w$')) | cal matchaddpos('EmotionBase', [rn], 98) | endfor
  cal s:emotion.draw(s:emotion.keypos) | cal popup_close(s:emotion.popid)
  let s:emotion.popid = popup_create('e-motion', #{line: &lines, col: &columns*-1, mapping: 0, filter: s:emotion.char_enter})
  echo ''
endf

" function: increment N order
" 配列をN進法とみなし、1増やす. 使うキーがssf → sws と繰り上がる仕組み
fu! s:emotion.incrementNOrder(nOrder, keyOrder) abort
  if len(a:keyOrder) == 1 | retu [a:keyOrder[0]+1] | endif
  let tmp = [] | let overflow = 0
  for idx in reverse(range(0, len(a:keyOrder)-1))
    " 1. increment last digit
    if idx == len(a:keyOrder)-1
      cal insert(tmp, a:keyOrder[idx] == a:nOrder ? 0 : a:keyOrder[idx]+1)
      if tmp[0] == 0 | let overflow = 1 | endif | continue
    endif
    " 2. check next digit
    if overflow
      cal insert(tmp, a:keyOrder[idx] == a:nOrder ? 0 : a:keyOrder[idx]+1)
      let overflow = a:keyOrder[idx] == a:nOrder ? 1 : 0
    else
      cal insert(tmp, a:keyOrder[idx])
    endif
  endfor
  retu tmp
endf

" about highlight setting
aug emotion_hl
  au!
  au ColorScheme * hi EmotionBase ctermfg=59
  au ColorScheme * hi EmotionWip ctermfg=166 cterm=bold
  au ColorScheme * hi EmotionFin ctermfg=196 cterm=bold
aug END
fu! s:emotion.hl_del(group_name) abort
  cal getmatches()->filter({ _,v -> v.group == a:group_name })->map('execute("cal matchdelete(v:val.id)")')
endf

" draw keystroke
" 日本語は1文字でマルチバイト3文字分だが、カーソル幅は2なのでめんどいから弾いてある
" posの次文字がマルチバイトだと、strokeが2回以上残ってる時、変に文字を書き換えてカラム数変わる
fu! s:emotion.draw(keypos) abort
  cal s:emotion.hl_del('EmotionFin') | cal s:emotion.hl_del('EmotionWip')
  let hlpos_wip = [] | let hlpos_fin = []
  for r in a:keypos | let line = getline(r.row)
    for c in r.col
      let colidx = c.pos-1 | let view_keystroke = c.key[:0] | let offset = colidx-1
      cal add(hlpos_fin, [r.row, c.pos])
      if len(c.key)>=2
        let view_keystroke = c.key[:1]
        cal add(hlpos_wip, [r.row, c.pos, 2])
      endif
      let line = colidx == 0
       \ ? view_keystroke.line[len(view_keystroke):]
       \ : line[0:offset].view_keystroke.line[colidx+len(view_keystroke):]
    endfor
    cal setline(r.row, line)
  endfor
  for t in hlpos_fin | cal matchaddpos('EmotionFin', [t], 99) | endfor
  for t in hlpos_wip | cal matchaddpos('EmotionWip', [t], 100) | endfor
endf

fu! s:emotion.char_enter(winid, key) abort
  " noop (for polyglot bug adhoc)
  if strtrans(a:key) == "<80><fd>`" | retu 1 | endif
  " only accept defined emotion key
  if s:emotion.keys->index(a:key) == -1
    " go out e-motion
    cal popup_close(s:emotion.popid)
    let p = getpos('.') | u | cal cursor(p[1],p[2])
    cal s:emotion.hl_del('EmotionFin') | cal s:emotion.hl_del('EmotionWip') | cal s:emotion.hl_del('EmotionBase')
    " restore f-scope
    cal s:fmode.takeover()
    echohl Special | echo 'e-motion: go out' | echohl None | retu 1
  endif
  " upd emotion.keypos
  let tmp = s:emotion.keypos->deepcopy()->map({ _,r -> #{row: r.row,
   \col: r.col->filter({_,v->v.key[0]==a:key})->map({_,v->#{key: v.key[1:], pos: v.pos}})} })
   \->filter({_,v->!empty(v.col)})
  " nomatch -> noop
  if empty(tmp) | retu 1 | else | let s:emotion.keypos = tmp | endif
  " if last match -> end e-motion
  if len(s:emotion.keypos) == 1 && len(s:emotion.keypos[0].col) == 1
    cal popup_close(s:emotion.popid)
    u | cal cursor(s:emotion.keypos[0].row, s:emotion.keypos[0].col[0].pos)
    cal s:emotion.hl_del('EmotionFin') | cal s:emotion.hl_del('EmotionWip') | cal s:emotion.hl_del('EmotionBase')
    " restore f-scope
    cal s:fmode.takeover()
    echohl Special | echo 'e-motion: finish' | echohl None | retu 1
  endif
  " redraw
  let p = getpos('.') | u | cal cursor(p[1],p[2]) | echo '' | cal s:emotion.draw(s:emotion.keypos)
  retu 1
endf

com! ImitatedEasymotion cal s:emotion.exe()
" }}}

" ===================================================================
" mhinz/vim-startify
" ===================================================================
" {{{

" TODO startify






" }}}

" }}}

" ##################      PLUG MANAGE       ################### {{{
let s:plug = #{colors: [ 'onedark.vim', 'hybrid_material.vim', 'molokai.vim' ]}

fu! s:plug.color_install() abort
  exe "bo terminal ++shell echo 'start'&&mkdir -p ~/.vim/colors&&cd ~/.vim/colors&&colors=('".join(s:plug.colors,"' '")."')&&for v in ${colors[@]};do curl https://raw.githubusercontent.com/serna37/vim-color/master/${v}>${v};done&&echo 'end'"
endf

" repo
" neoclide/coc.nvim has special args
" TODO delete some
let s:plug.repos = [
    \ 'easymotion/vim-easymotion',
    \ 'mhinz/vim-startify',
    \ 'junegunn/goyo.vim', 'junegunn/limelight.vim',
    \ 'junegunn/fzf', 'junegunn/fzf.vim',
    \ 'github/copilot.vim', 'thinca/vim-quickrun', 'puremourning/vimspector',
    \ 'sheerun/vim-polyglot', 'uiiaoo/java-syntax.vim',
    \ 'vim-airline/vim-airline', 'vim-airline/vim-airline-themes',
    \ ]

" coc extentions
let s:plug.coc_extentions = [
    \ 'coc-fzf-preview', 'coc-explorer', 'coc-lists', 'coc-snippets',
    \ 'coc-sh', 'coc-vimlsp', 'coc-json', 'coc-sql', 'coc-html', 'coc-css',
    \ 'coc-tsserver', 'coc-clangd', 'coc-go', 'coc-pyright', 'coc-java',
    \ ]

fu! s:plug.install() abort
  " colors
  let color_cmd = "mkdir -p ~/.vim/colors&&cd ~/.vim/colors&&colors=('".join(s:plug.colors,"' '")."')&&for v in ${colors[@]};do curl https://raw.githubusercontent.com/serna37/vim-color/master/${v}>${v};done"
  " plugins
  let cmd = "mkdir -p ~/.vim/pack/plugins/start&&cd ~/.vim/pack/plugins/start&&repos=('".join(s:plug.repos,"' '")."')&&for v in ${repos[@]};do git clone --depth 1 https://github.com/${v};done"
    \ ."&&git clone -b release https://github.com/neoclide/coc.nvim"
    \ ."&&fzf/install --no-key-bindings --completion --no-bash --no-zsh --no-fish"
  cal s:runcat.start() | cal job_start(["/bin/zsh","-c",color_cmd]) | cal job_start(["/bin/zsh","-c",cmd], #{close_cb: s:plug.coc_setup})
  echo 'colors, plugins installing...' | cal popup_notification('colors, plugins installing...', #{border: [], line: &columns/4-&columns/37, close: 'button'})
endf

" coc extentions
fu! s:plug.coc_setup(ch) abort
  cal s:runcat.stop() | echohl Special | echo 'colors, plugins installed. coc-extentions installing. PLEASE REBOOT VIM after this.' | echohl None
  cal popup_notification('colors, plugins installed. coc-extentions installing. PLEASE REBOOT VIM after this.', #{ border: [], line: &columns/4-&columns/37, close: "button" })
  exe 'source ~/.vim/pack/plugins/start/coc.nvim/plugin/coc.vim' | exe 'CocInstall '.join(s:plug.coc_extentions,' ')
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
fu! s:plug.uninstall() abort
  echohl ErrorMsg | echo 'delete ~/.vim' | echo 'are you sure to delete these folder ?'
  echohl Special | let w = inputdialog("YES (Y) / NO (N)") | if w != 'Y' || w != 'y' | echohl None | echo 'cancel' | retu | endif
  echohl None | exe "bo terminal ++shell echo 'start'&&rm -rf ~/.vim&&echo 'end. PLEASE REBOOT VIM'"
endf

com! ColorInstall cal s:plug.color_install()
com! PlugInstall cal s:plug.install()
com! PlugUnInstall cal s:plug.uninstall()
" }}}

" ##################        TRAINING        ################### {{{
command! Popupclear cal popup_clear()
command! -nargs=? TrainingWheelsProtocol cal TrainingWheelsProtocol(<f-args>)

fu! TrainingWheelsProtocol(...)
  if a:0 == 0
    cal TrainingWheelsPopupsActivate()
  elseif a:1 == 0
    cal TrainingWheelsPopupsDeActivate()
  elseif a:1 == 1
    cal TrainingWheelsPopupsActivateQuick()
  endif
endf

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

fu! TrainingWheelsPopupsActivate()
  cal TrainingWheelsPratticeFileCreate()
  let s:show_cheat_sheet_flg = 0 " my cheat sheet disable
  cal TrainingWheelsPopupsAllClose()
  let s:training_info_idx = 0
  highlight TrainingNotification ctermfg=green guifg=green
  highlight Traininginfo ctermfg=cyan guifg=cyan cterm=BOLD gui=BOLD
  cal popup_notification([
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
  cal timer_start(1000, function('TrainingInfo'))
  cal timer_start(6000, function('TrainingInfo'))
  cal timer_start(6500, function('TrainingPopupCursor1'))
  cal timer_start(6500, function('TrainingPopupCursor1SampleMv'))
  cal timer_start(10000, function('TrainingInfo'))
  cal timer_start(10500, function('TrainingPopupCursor2'))
  cal timer_start(10500, function('TrainingPopupCursor2SampleMv'))
  cal timer_start(15000, function('TrainingInfo'))
  cal timer_start(15500, function('TrainingPopupWindow1'))
  cal timer_start(15500, function('TrainingPopupWindow1SampleMv'))
  cal timer_start(20000, function('TrainingInfo'))
  cal timer_start(20500, function('TrainingPopupWindow2'))
  cal timer_start(20500, function('TrainingPopupWindow2SampleMv'))
  cal timer_start(26000, function('TrainingInfo'))
  cal timer_start(29000, function('TrainingInfo'))
  cal timer_start(29500, function('TrainingPopupMode1'))
  cal timer_start(32000, function('TrainingInfo'))
  cal timer_start(35000, function('TrainingInfo'))
  cal timer_start(35500, function('TrainingPopupMode2'))
  cal timer_start(35500, function('TrainingPopupMode2SampleMv'))
  cal timer_start(38000, function('TrainingInfo'))
  cal timer_start(38500, function('TrainingPopupSearch'))
  cal timer_start(38500, function('TrainingPopupSearchSampleMv'))
  cal timer_start(42000, function('TrainingInfo'))
  cal timer_start(45000, function('TrainingInfo'))
  cal timer_start(45500, function('TrainingPopupOpeObj'))
  cal timer_start(45500, function('TrainingPopupOpeObjSampleMv'))
  cal timer_start(49000, function('TrainingInfo'))
  let s:training_popup_tips_win_tid = timer_start(49500, function('TrainingPopupTips'))
  cal timer_start(49500, function('TrainingPopupTipsCursor'))
  cal timer_start(52000, function('TrainingInfo'))
endf

fu! TrainingWheelsPopupsActivateQuick()
  if s:training_info_idx != 0 && s:training_info_idx != len(s:training_info_txt)
    echo 'Enjoy tutorial till the end.'
    retu
  endif

  let s:show_cheat_sheet_flg = 0 " my cheat sheet disable
  cal popup_notification([' Traning Wheels Activated. ',' :TrainingWheelsProtocol 0  to DeActivate. '],#{border:[]})
  let s:training_info_idx = len(s:training_info_txt)
  cal TrainingWheelsPopupsAllClose()
  cal TrainingPopupCursor1(0)
  cal TrainingPopupCursor2(0)
  cal TrainingPopupWindow1(0)
  cal TrainingPopupWindow2(0)
  cal TrainingPopupMode1(0)
  cal TrainingPopupMode2(0)
  cal TrainingPopupSearch(0)
  cal TrainingPopupOpeObj(0)
  let s:training_popup_tips_win_tid = timer_start(100, function('TrainingPopupTips'))
  cal TrainingPopupTipsCursor(0)
endf

fu! TrainingWheelsPopupsDeActivate()
  if s:training_info_idx == 0
    echo 'No Training Wheels.'
    retu
  elseif s:training_info_idx != len(s:training_info_txt)
    echo 'Enjoy tutorial till the end.'
    retu
  endif

  let s:show_cheat_sheet_flg = 1 " my cheat sheet enable
  augroup training_tips_popup
    au!
  augroup END
  cal popup_notification([' Traning Wheels DeActivated. ',' :TrainingWheelsProtocol 1  to open popups without tutorial.  '],#{border:[]})
  cal TrainingWheelsPopupsAllClose()
endf

fu! TrainingWheelsPopupsAllClose()
  let s:training_popup_tips_win_flg = 0
  cal timer_stop(s:training_popup_tips_win_tid)
  cal popup_close(s:training_popup_cursor1_winid)
  cal popup_close(s:training_popup_cursor2_winid)
  cal popup_close(s:training_popup_window1_winid)
  cal popup_close(s:training_popup_window2_winid)
  cal popup_close(s:training_popup_mode1_winid)
  cal popup_close(s:training_popup_mode2_winid)
  cal popup_close(s:training_popup_search_winid)
  cal popup_close(s:training_popup_opeobj_winid)
  cal popup_close(s:training_popup_tips_winid)
endf

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
fu! TrainingInfo(timer)
  let inf = s:training_info_txt[s:training_info_idx]
  cal popup_notification(inf[0],#{border:[],
        \zindex:999,
        \highlight:'Traininginfo',
        \pos:'center',
        \time:inf[1]})
  let s:training_info_idx += 1
endf

" cursor move
fu! TrainingPopupCursor1(timer)
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
endf

fu! TrainingPopupCursor1SampleMv(timer)
  execute("norm gg")
  cal cursor(26, 6)
  cal timer_start(600, function('TrainingPopupCursor1SampleMv1'))
  cal timer_start(1200, function('TrainingPopupCursor1SampleMv2'))
  cal timer_start(1800, function('TrainingPopupCursor1SampleMv3'))
  cal timer_start(2400, function('TrainingPopupCursor1SampleMv4'))
endf
fu! TrainingPopupCursor1SampleMv1(timer)
  execute("norm h")
  echo("h   cursor move")
endf
fu! TrainingPopupCursor1SampleMv2(timer)
  execute("norm j")
  echo("j   cursor move")
endf
fu! TrainingPopupCursor1SampleMv3(timer)
  execute("norm l")
  echo("l   cursor move")
endf
fu! TrainingPopupCursor1SampleMv4(timer)
  execute("norm k")
  echo("k   cursor move")
endf

" cursor jump
fu! TrainingPopupCursor2(timer)
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
endf

fu! TrainingPopupCursor2SampleMv(timer)
  execute("norm gg")
  cal cursor(15, 12)
  cal timer_start(200, function('TrainingPopupCursor2SampleMv1'))
  cal timer_start(900, function('TrainingPopupCursor2SampleMv1'))
  cal timer_start(1600, function('TrainingPopupCursor2SampleMv2'))
  cal timer_start(2300, function('TrainingPopupCursor2SampleMv3'))
  cal timer_start(3000, function('TrainingPopupCursor2SampleMv4'))
  cal timer_start(3700, function('TrainingPopupCursor2SampleMv5'))
endf
fu! TrainingPopupCursor2SampleMv1(timer)
  execute("norm w")
  echo("w   next word first char")
endf
fu! TrainingPopupCursor2SampleMv2(timer)
  execute("norm e")
  echo("e   next wort last char")
endf
fu! TrainingPopupCursor2SampleMv3(timer)
  cal cursor(15, 12)
  echo("and ...")
endf
fu! TrainingPopupCursor2SampleMv4(timer)
  execute("norm fe")
  echo("fe   next first e")
endf
fu! TrainingPopupCursor2SampleMv5(timer)
  execute("norm tx")
  echo("tx   next first x, before 1")
endf


" move window
fu! TrainingPopupWindow1(timer)
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
endf

fu! TrainingPopupWindow1SampleMv(timer)
  execute("norm gg")
  cal timer_start(200, function('TrainingPopupWindow1SampleMv1'))
  cal timer_start(1200, function('TrainingPopupWindow1SampleMv2'))
  cal timer_start(2200, function('TrainingPopupWindow1SampleMv3'))
  cal timer_start(3200, function('TrainingPopupWindow1SampleMv4'))
endf
fu! TrainingPopupWindow1SampleMv1(timer)
  execute "norm \<C-d>"
  echo("C-d   pade down")
endf
fu! TrainingPopupWindow1SampleMv2(timer)
  execute("norm gg")
  echo("gg   page top")
endf
fu! TrainingPopupWindow1SampleMv3(timer)
  execute("norm G")
  echo("G   page last")
endf
fu! TrainingPopupWindow1SampleMv4(timer)
  execute("norm 15G")
  echo("15G   line 15")
endf

" cursor jump in window
fu! TrainingPopupWindow2(timer)
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
endf

fu! TrainingPopupWindow2SampleMv(timer)
  execute("norm gg")
  cal cursor(15, 1)
  cal timer_start(200, function('TrainingPopupWindow2SampleMv1'))
  cal timer_start(800, function('TrainingPopupWindow2SampleMv2'))
  cal timer_start(1400, function('TrainingPopupWindow2SampleMv3'))
  cal timer_start(2200, function('TrainingPopupWindow2SampleMv4'))
  cal timer_start(2600, function('TrainingPopupWindow2SampleMv4'))
  cal timer_start(3400, function('TrainingPopupWindow2SampleMv5'))
  cal timer_start(4200, function('TrainingPopupWindow2SampleMv6'))
  cal timer_start(4500, function('TrainingPopupWindow2SampleMv7'))
endf
fu! TrainingPopupWindow2SampleMv1(timer)
  execute("norm H")
  echo("H   window High")
endf
fu! TrainingPopupWindow2SampleMv2(timer)
  execute("norm L")
  echo("L   window Low")
endf
fu! TrainingPopupWindow2SampleMv3(timer)
  execute("norm M")
  echo("M   window Middle")
endf
fu! TrainingPopupWindow2SampleMv4(timer)
  execute("norm }")
  echo("}   next paragraph")
endf
fu! TrainingPopupWindow2SampleMv5(timer)
  execute "norm z\<CR>"
  echo("z+Enter   stay cursor, top")
endf
fu! TrainingPopupWindow2SampleMv6(timer)
  execute("norm zz")
  echo("zz   stay cursor, middle")
endf
fu! TrainingPopupWindow2SampleMv7(timer)
  echo("")
endf

" insert mode
fu! TrainingPopupMode1(timer)
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
endf

" command mode
fu! TrainingPopupMode2(timer)
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
endf

fu! TrainingPopupMode2SampleMv(timer)
  cal timer_start(400, function('TrainingPopupMode2SampleMv1'))
endf
fu! TrainingPopupMode2SampleMv1(timer)
  echo("Hello Vim!!")
endf

" search
fu! TrainingPopupSearch(timer)
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
endf

fu! TrainingPopupSearchSampleMv(timer)
  execute("norm gg")
  cal cursor(15, 9)
  cal timer_start(200, function('TrainingPopupSearchSampleMv1'))
  cal timer_start(800, function('TrainingPopupSearchSampleMv2'))
  cal timer_start(1200, function('TrainingPopupSearchSampleMv2'))
  cal timer_start(1600, function('TrainingPopupSearchSampleMv3'))
endf
fu! TrainingPopupSearchSampleMv1(timer)
  cal feedkeys("\/test\<CR>")
endf
fu! TrainingPopupSearchSampleMv2(timer)
  cal feedkeys("n")
endf
fu! TrainingPopupSearchSampleMv3(timer)
  cal feedkeys("N")
endf

" operator + textobject
fu! TrainingPopupOpeObj(timer)
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
endf

fu! TrainingPopupOpeObjSampleMv(timer)
  cal cursor(52, 13)
  execute("norm zz")
  cal timer_start(200, function('TrainingPopupOpeObjSampleMv1'))
  cal timer_start(800, function('TrainingPopupOpeObjSampleMv2'))
  cal timer_start(1500, function('TrainingPopupOpeObjSampleMv3'))
  cal timer_start(1600, function('TrainingPopupOpeObjSampleMv4'))
  cal timer_start(2200, function('TrainingPopupOpeObjSampleMv5'))
  cal timer_start(2900, function('TrainingPopupOpeObjSampleMv3'))
endf
fu! TrainingPopupOpeObjSampleMv1(timer)
  echo("vi<   visual inner <>")
endf
fu! TrainingPopupOpeObjSampleMv2(timer)
  execute("norm vi<")
endf
fu! TrainingPopupOpeObjSampleMv3(timer)
  execute "norm \<Esc>"
  cal cursor(72, 6)
  execute("norm zz")
endf
fu! TrainingPopupOpeObjSampleMv4(timer)
  echo("vis   visual inner statement")
endf
fu! TrainingPopupOpeObjSampleMv5(timer)
  execute("norm vis")
endf

" undo redo repeat
fu! TrainingPopupTips(timer)
  if s:training_popup_tips_win_flg == 0
    retu
  endif
  cal popup_close(s:training_popup_tips_winid)
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
endf

" add cursor hold
fu! TrainingPopupTipsCursor(timer)
  let s:training_popup_tips_win_flg = 1
  augroup training_tips_popup
    au!
    autocmd CursorHold * silent cal TrainingPopupTipsOpen()
    autocmd CursorMoved * silent cal TrainingPopupTipsClose()
    autocmd CursorMovedI * silent cal TrainingPopupTipsClose()
  augroup END
endf

fu! TrainingPopupTipsOpen()
  cal timer_stop(s:training_popup_tips_win_tid)
  let s:training_popup_tips_win_tid = timer_start(300, function('TrainingPopupTips'))
endf
fu! TrainingPopupTipsClose()
  cal timer_stop(s:training_popup_tips_win_tid)
  cal popup_close(s:training_popup_tips_winid)
endf


let g:training_wheels_practice_file = []

" create practice file
fu! TrainingWheelsPratticeFileCreate()
  " TODO get practice.md
  " if すでにあるなら開くだけ
  " if vimレポ落としてるならコピー
  let repo = 'https://raw.githubusercontent.com/serna37/vim/master/practice.md'
  let cmd = 'curl '.repo.' > ~/practice.md'
  cal job_start(["/bin/zsh","-c",cmd], {'close_cb': function('TrainingWheelsPracticeFileOpen')})
endf

" open practice file (only tutorial)
fu! TrainingWheelsPracticeFileOpen(ch) abort
  " TODO 左に開きたいし、tabeにするか
  execute('tabe ~/practice.md')
  cal cursor(26, 6)
endf

" }}}
" }}}

" #############################################################
" ##################    PLUGINS SETTING     ###################
" #############################################################
" {{{
" ##################    PLUGIN VARIABLES    ################### {{{

" coc
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" vimspector
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

" fzf
set rtp+=~/.vim/pack/plugins/start/fzf

" TODO delete
" easy motion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_keys='swadjkhlnmf'

" airline
let g:airline_theme = 'deus'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_powerline_fonts = 1

" TODO delete
" auto pair
let g:AutoPairsMapCh = 0

" TODO delete
" zen
let g:limelight_conceal_ctermfg = 'gray'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" startify
" ぼっちざろっく{{{
const g:btr_logo = [
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

let g:startify_custom_header = g:btr_logo

" }}}

" ##################      PLUGIN KEYMAP     ################### {{{

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
  autocmd CursorHold * silent cal CocActionAsync('highlight')

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

" TODO delete
" easy motion
if glob('~/.vim/pack/plugins/start/vim-easymotion') != ''
  nnoremap s <Plug>(easymotion-bd-w)
  nnoremap <Leader>s <Plug>(easymotion-sn)
endif

" TODO delete
" zen mode
if glob('~/.vim/pack/plugins/start/goyo.vim') != ''
  nnoremap <silent><Leader>z :Goyo<CR>
endif

" }}}
" }}}

" #############################################################
" ##################        STARTING        ###################
" #############################################################
" {{{

colorscheme torte
if glob('~/.vim/colors/') != '' | colorscheme onedark | endif

" }}}

" alse see [https://github.com/serna37/vim/]
