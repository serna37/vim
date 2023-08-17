" vim:set foldmethod=marker:
let mapleader = "\<SPACE>"

" ==============================================================================
" =====================         CONTENTS         ===============================
" ============================================================================== {{{
" alse see [https://github.com/serna37/vim/]
"    CONTENTS
"
"     # BASIC VIM SETTINGS
"         ## FILE .................. | file encoding, charset, vim specific setting.
"         ## VISUALIZATION ......... | enhanced visual information.
"         ## WINDOW ................ | window forcus, resize, open terminal.
"         ## MOTION ................ | row move, scroll, mark, IDE action menu.
"         ## EDIT .................. | insert mode cursor, block move.
"         ## COMPLETION ............ | indent, word completion.
"         ## SEARCH ................ | incremental search, emotion, fzf, grep, explorer.
"         ## OTHERS ................ | fast terminal, reg engin, fold.
"
"     # FUNCTIONS
"         ## ORIGINALS ............. | original / adhoc functions.
"         ## IMITATIONS ............ | imitated plugins as functions.
"         ## PLUG MANAGE ........... | plugin manager functions.
"         ## TRAINING .............. | training default vim functions.
"
"     # PLUGINS SETTING
"         ## PLUGIN VARIABLES ...... | setting for plugins without conflict.
"         ## PLUGIN KEYMAP ......... | setting for plugins without conflict.
"
"     # STARTING
"         ## STARTING .............. | functions called when vim started.
"
" ==============================================================================
" }}}

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
    au!
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
" simeji/winresizer
" window forcus move
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
tnoremap <C-h> <C-w>h
tnoremap <C-l> <C-w>l
tnoremap <C-k> <C-w>k
tnoremap <C-j> <C-w>j
" window resize
nnoremap <Left> 4<C-w><
nnoremap <Right> 4<C-w>>
nnoremap <Up> 4<C-w>-
nnoremap <Down> 4<C-w>+
" move buffer
nmap <C-n> <Plug>(buf-prev)
nmap <C-p> <Plug>(buf-next)
" close buffer
nmap <Leader>x <Plug>(buf-close)
" terminal
nnoremap <silent><Leader>t :cal popup_create(term_start([&shell],#{hidden:1,term_finish:'close'}),#{border:[],minwidth:&columns*3/4,minheight:&lines*3/4})<CR>
" terminal read only mode (i to return terminal mode)
tnoremap <Esc> <C-w>N
" zen
nmap <Leader>z <Plug>(zen-mode)
" }}}

" ##################         MOTION         ################### {{{
" row move
nnoremap j gj
nnoremap k gk
vnoremap <Tab> 5gj
vnoremap <S-Tab> 5gk
nmap <Tab> 5j<Plug>(anchor)
nmap <S-Tab> 5k<Plug>(anchor)
" comfortable scroll
nmap <C-u> <Plug>(scroll-u)
nmap <C-d> <Plug>(scroll-d)
nmap <C-b> <Plug>(scroll-b)
nmap <C-f> <Plug>(scroll-f)
" f-scope toggle
nmap <Leader>w <Plug>(f-scope)
" mark
nmap mm <Plug>(mk-toggle)
nmap mp <Plug>(mk-prev)
nmap mn <Plug>(mk-next)
nmap mc <Plug>(mk-clthis)
nmap mx <Plug>(mk-clall)
nmap <Leader>m <Plug>(mk-list)
" IDE action menu
nmap <Leader>v <Plug>(ide-menu)
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
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>l
inoremap <C-k> <C-o>k
inoremap <C-j> <C-o>j
" d = delete(no clipboard)
nnoremap d "_d
vnoremap d "_d
" x = cut(yank register)
nnoremap x "+x
vnoremap x "+x
" p P = paste(from yank register)
nnoremap p "+p
nnoremap P "+P
vnoremap p "+p
vnoremap P "+P
" block move at visual mode
vnoremap <C-j> "zx"zp`[V`]
vnoremap <C-k> "zx<Up>"zP`[V`]
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
inoremap <expr><CR> pumvisible() ? '<C-y>' : '<CR>'
inoremap <expr><Tab> pumvisible() ? '<C-n>' : '<C-t>'
inoremap <expr><S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'
" }}}

" ##################         SEARCH         ################### {{{
" search
set incsearch " incremental search
set hlsearch " highlight match words
set ignorecase " ignore case search
set smartcase " don't ignore case when enterd UPPER CASE"
set shortmess-=S " show hit word's number at right bottom
" no move search word with multi highlight
nmap # *N<Plug>(qikhl-toggle)
nmap <silent><Leader>q <Plug>(qikhl-clear):noh<CR>
" incremental search
nmap s <Plug>(emotion)
nmap <Leader>s <Plug>(fuzzy-search)
" grep result -> quickfix
au QuickFixCmdPost *grep* cwindow
" explorer
filetype plugin indent on
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 70
"nmap <Leader>e <Plug>(explorer-toggle)
nmap <silent><Leader>e :echo 'sorry tmp deactivated.'<CR>
" fzf-imitation
nmap <leader>f <Plug>(fzf-smartfiles)
nmap <leader>h <Plug>(fzf-histories)
nmap <leader>b <Plug>(fzf-buffers)
" grep
nmap <Leader>g <Plug>(grep)
" vimgrep current file
nmap <Leader><Leader>s <Plug>(grep-current)
" }}}

" ##################         OTHERS         ################### {{{
" basic
scriptencoding utf-8 " this file's charset
set ttyfast " fast terminal connection
set regexpengine=0 " chose regexp engin
" fold
set foldmethod=marker " fold marker
set foldlevel=0 " fold max depth
set foldlevelstart=5 " fold depth on start view
set foldcolumn=1 " fold preview
" }}}
" }}}

" #############################################################
" ##################       FUNCTIONS        ###################
" #############################################################
" {{{
" ##################       ORIGINALS        ################### {{{

" Running Cat (loading animation) {{{
let s:runcat = #{frame: 0, winid: 0, tid: 0, delay: 300, fg: 17}
fu! s:runcat.animation(_) abort
    cal setbufline(winbufnr(self.winid), 1, self.cat[self.frame])
    exe 'hi RunningCat ctermfg='.self.fg
    cal matchadd('RunningCat', '[^ ]', 16, -1, #{window: self.winid})
    let self.fg = self.fg == 255 ? 17 : self.fg+1
    let self.frame = self.frame == 4 ? 0 : self.frame + 1
    let self.tid = timer_start(self.delay, self.animation)
endf
fu! s:runcat.stop() abort
    cal popup_close(self.winid)
    cal timer_stop(self.tid)
endf
fu! s:runcat.start(...) abort
    cal self.stop()
    let self.winid = popup_create(self.cat[0], #{line: 1, zindex: 1})
    let self.delay = a:0 ? 700-(a:1-1)*140 : self.delay
    cal self.animation(0)
endf
fu! s:runcat_gear_list(A, L, P) abort
    retu ['1', '2', '3', '4', '5']
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

com! -bar -nargs=? -complete=customlist,s:runcat_gear_list RunCat cal s:runcat.start(<f-args>)
com! -bar RunCatStop cal s:runcat.stop()
" }}}

" color echo/echon, input {{{
fu! EchoE(msg, ...) abort
    echohl DarkRed
    exe printf('echo%s "%s"', a:0 ? 'n' : '', a:msg)
    echohl None
endf

fu! EchoW(msg, ...) abort
    echohl DarkOrange
    exe printf('echo%s "%s"', a:0 ? 'n' : '', a:msg)
    echohl None
endf

fu! EchoI(msg, ...) abort
    echohl DarkBlue
    exe printf('echo%s "%s"', a:0 ? 'n' : '', a:msg)
    echohl None
endf

fu! InputE(msg, ...) abort
    echohl DarkRed
    if !a:0
        let w = input(a:msg)
    elseif a:0 == 1
        let w = input(a:msg, a:1)
    elseif a:0 == 2
        let w = input(a:msg, a:1, a:2)
    endif
    echohl None
    retu w
endf
fu! InputW(msg, ...) abort
    echohl DarkOrange
    if !a:0
        let w = input(a:msg)
    elseif a:0 == 1
        let w = input(a:msg, a:1)
    elseif a:0 == 2
        let w = input(a:msg, a:1, a:2)
    endif
    echohl None
    retu w
endf
fu! InputI(msg, ...) abort
    echohl DarkBlue
    if !a:0
        let w = input(a:msg)
    elseif a:0 == 1
        let w = input(a:msg, a:1)
    elseif a:0 == 2
        let w = input(a:msg, a:1, a:2)
    endif
    echohl None
    retu w
endf

aug logging_char_color
    au!
    au ColorScheme * hi DarkRed ctermfg=204
    au ColorScheme * hi DarkOrange ctermfg=180
    au ColorScheme * hi DarkBlue ctermfg=39
aug END
" }}}

" Tab 5row Anchor {{{
sign define anch text=> texthl=DarkRed
let s:anchor = #{tid: 0,
    \ getlines: { l -> l-5 > 0 ? [l-5, l, l+5] : [l, l+5] },
    \ put: { f, l -> sign_place(0, 'anchor', 'anch', f, #{lnum: l}) },
    \ rm: { tid -> sign_unplace('anchor') },
    \ }

fu! s:anchor.set() abort
    cal timer_stop(self.tid)
    cal self.rm(0)
    cal self.getlines(line('.'))->map({ _,v -> self.put(bufname('%'), v) })
    let self.tid = timer_start(2000, self.rm)
endf

fu! s:anchor() abort
    cal s:anchor.set()
endf
noremap <silent><Plug>(anchor) :<C-u>cal <SID>anchor()<CR>
" }}}

" Fuzzy search current file {{{
fu! s:fuzzySearch() abort
    let buf = getline(1, line('$'))
    " quickfix fuzzySearch
    " empty buffer -> no data
    if expand('%')->empty()
        cal s:fzsearch.popup(#{title: 'QuickFix', list: buf, type: 'flm', eprfx: 0})
        retu
    endif
    " buffer fuzzySearch
    cal s:fzsearch.popup(#{title: 'Current Buffer', list: map(buf, {i,v->i+1.': '.v}), type: 'lm', eprfx: 0})
endf

noremap <silent><Plug>(fuzzy-search) :<C-u>cal <SID>fuzzySearch()<CR>
" }}}

" Grep current file {{{
fu! s:grepCurrent() abort
    cal EchoI('grep from this file. (empty to cancel)')
    let word = InputI('[word]>>', expand('<cword>'))
    cal EchoI('<<', 0)
    if empty(word)
        cal EchoE('cancel')
        retu
    endif
    cal EchoW(printf('grep word[%s] processing in [%s] ...', word, expand('%:t')))
    try
        exe 'vimgrep /'.word.'/gj %'
        cw
    catch
        cal EchoE('grep no hit')
    finally
        cal EchoI('grep complete!')
    endtry
endf

noremap <silent><Plug>(grep-current) :<C-u>cal <SID>grepCurrent()<CR>
" }}}

" Grep {{{
fu! s:grep() abort
    echo 'grep by'
    cal EchoE(' [word]', 0)
    cal EchoI(' [ext]', 0)
    cal EchoW(' [target]', 0)
    echo '=========== empty to cancel ==================='
    echo 'pwd:'.substitute(getcwd(), $HOME, '~', 'g')
    let word = InputE('[word]>>', expand('<cword>'))
    cal EchoE('<<', 0)
    if empty(word)
        echo 'cancel'
        retu
    endif

    let ext = InputI('[ext]>>', '*')
    cal EchoI('<<', 0)
    if empty(ext)
        echo 'cancel'
        retu
    endif

    let target = InputW('[target] TabCompletion>>', '.*', 'file')
    cal EchoW('<<', 0)
    if empty(target)
        echo 'cancel'
        retu
    endif

    echo '==============================================='
    echo 'grep'
    cal EchoE(' word['.word.']', 0)
    cal EchoI(' ext['.ext.']', 0)
    echon ' processing in'
    cal EchoW(' target['.target.']', 0)
    echon ' ...'
    echo ''
    let result = system('grep -rin --include="*.'.ext.'" "'.word.'" '.target)
    if empty(result)
        cal EchoE('grep no hit')
        cal EchoI('grep complete!')
        retu
    endif
    cgetexpr result
    cw
    cal EchoI('grep complete!')
endf

noremap <silent><Plug>(grep) :<C-u>cal <SID>grep()<CR>
" }}}

" IDE menu {{{
let s:idemenu = #{
    \ menuid: 0, mttl: ' IDE MENU (j / k) Enter choose | * require plugin ',
    \ menu: [
        \ '[Format]         applay format for this file',
        \ '[ReName*]        rename current word recursively',
        \ '[ALL PUSH]       commit & push all changes',
        \ '[Snippet*]       edit snippets',
        \ '[Run]            run current program',
        \ '[Run Server]     run current program',
        \ '[Debug*]         debug current program',
        \ '[Run as Shell]   run current row as shell command',
    \ ],
    \ cheatid: 0, cheattitle: ' LSP KeyMaps ',
    \ cheat: [
        \ ' (Space d) [Definition]     Go to Definition ',
        \ ' (Space r) [Reference]      Reference ',
        \ ' (Space o) [Outline]        view outline on popup ',
        \ ' (Space ?) [Document]       show document on popup scroll C-f/b ',
        \ ' (Space ,) [Next Diagnosis] jump next diagnosis ',
        \ ' (Space .) [Prev Diagnosis] jump prev diagnosis ',
    \ ],
    \ }

fu! s:idemenu.open() abort
    let self.menuid = popup_menu(self.menu, #{title: self.mttl, border: [], borderchars: ['─','│','─','│','╭','╮','╯','╰'],
        \ callback: 'Idemenu_exe'})
    cal setwinvar(self.menuid, '&wincolor', 'User_greenfg_blackbg')
    cal matchadd('DarkRed', '\[.*\]', 16, -1, #{window: self.menuid})
    let self.cheatid = popup_create(self.cheat, #{title: self.cheattitle, line: &lines-5})
    cal setwinvar(self.cheatid, '&wincolor', 'User_greenfg_blackbg')
    cal matchadd('DarkRed', '\[.*\]', 16, -1, #{window: self.cheatid})
    cal matchadd('DarkBlue', '(.*)', 16, -1, #{window: self.cheatid})
endf

fu! Idemenu_exe(_, idx) abort
    if a:idx == 1
        " TODO ide menu format 選択部分のみをしたい
        if exists(':Coc')
            cal CocActionAsync('format')
        else
            execute('norm gg=G'.line('.').'G')
        endif
    elseif a:idx == 2
        if exists(':Coc')
            cal CocActionAsync('rename')
        else
            cal EchoE('Sorry, [ReName*] needs coc.nvim.')
            cal popup_close(s:idemenu.cheatid)
            retu 1
        endif
    elseif a:idx == 3
        let w = InputI('commit message>>')
        if empty(w)
            cal EchoE('cancel')
            cal popup_close(s:idemenu.cheatid)
            retu 1
        endif
        exe 'top terminal ++rows=10 ++shell git add . && git commit -m "'.w.'" && git push'
    elseif a:idx == 4
        if exists(':CocCommand')
            exe 'CocCommand snippets.editSnippets'
        else
            cal EchoE('Sorry, [Snippet*] needs coc.nvim.')
            cal popup_close(s:idemenu.cheatid)
            retu 1
        endif
    elseif a:idx == 5
        cal s:quickrun.exe()
    elseif a:idx == 6
        cal s:quickrun.server()
    elseif a:idx == 7
        if exists(':Vimspector')
            cal vimspector#Launch()
        else
            cal EchoE('Sorry, [Debug*] needs vimspector.')
            cal popup_close(s:idemenu.cheatid)
            retu 1
        endif
    elseif a:idx == 8
        exe 'top terminal ++rows=10 ++shell eval '.getline('.')
    endif
    cal popup_close(s:idemenu.cheatid)
    retu 0
endf

fu! s:idemenu() abort
    cal s:idemenu.open()
endf
noremap <silent><Plug>(ide-menu) :<C-u>cal <SID>idemenu()<CR>
" }}}

" completion {{{
" TODO completion リファクタ
" TODO completion ~の後ろで正規表現やりに行っちゃう。=は大丈夫
""let s:completion = #{exclude: [" ()[]{}<>'`".'"'], confirmed: 0, done: {-> execute('let s:completion.confirmed = 1')}}
let s:completion = #{exclude: [" ~()[]{}<>'`".'"'], opened: 0, confirmed: 0}

fu! s:completion.exe() abort
    if self.confirmed
        let self.confirmed = 0
        let self.opend = 0
        retu
    endif
    if col('.') == 1 || match(self.exclude, getline('.')[col('.')-2]) != -1
        retu
    endif
    if !pumvisible()
        " 開いてたはずだが、確定されずに閉じてるなら何もしない
        if self.opened
            retu
        endif
        let self.opened = 1
        cal feedkeys("\<C-n>")
    endif
endf

fu! s:completion.done() abort
    let self.confirmed = 1
    let self.opened = 0
endf

" TODO completion <BS>のあとに補完だしたくない
if glob('~/.vim/pack/plugins/start/coc.nvim') == ''
    au TextChangedI,TextChangedP * cal s:completion.exe()
    au CompleteDone * cal s:completion.done()
endif
" }}}

" }}}

" ##################       IMITATIONS       ################### {{{

" ===================================================================
" jiangmiao/auto-pairs
" ===================================================================
" {{{
" TODO auto pair リファクタ
let s:pairs_start = ["(", "[", "{", "<", "'", '"', "`"]
let s:pairs_end = [")", "]", "}", ">", "'", '"', "`"]
fu! AutoPairsDelete()
    let pre_cursor_char = getline('.')[col('.')-2]
    let on_cursor_char = getline('.')[col('.')-1]
    let pre_chk = match(s:pairs_start, pre_cursor_char)
    let on_chk = match(s:pairs_end, on_cursor_char)
    if pre_chk != -1 && pre_chk == on_chk
        retu "\<RIGHT>\<BS>\<BS>"
    endif
    retu "\<BS>"
endf

inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>
inoremap < <><LEFT>
inoremap ' ''<LEFT>
inoremap " ""<LEFT>
inoremap ` ``<LEFT>
" TODO auto pair ~の後ろで正規表現やりに行っちゃう。=は大丈夫
inoremap <silent><expr><BS> AutoPairsDelete()
""inoremap <silent><BS> <C-r>=AutoPairsDelete()

" TODO auto pair 直前に押したキーが(なら、()と入力しても良いってしたい
" }}}

" ===================================================================
" vim-airline/vim-airline
" ===================================================================
" {{{
let g:right_arrow = ''
let g:left_arrow = ''
let powerline_chk_mac = system('fc-list | grep powerline | wc -l')->trim()
let powerline_chk_win = system('cd /C/Windows/Fonts && ls | grep powerline | wc -l')->trim()
if !powerline_chk_mac+0 && !powerline_chk_win+0
    let g:right_arrow = '▶︎'
    let g:left_arrow = '◀︎'
endif

let g:modes = {
    \ 'i': ['#User_blackfg_bluebg_bold#', '#User_bluefg_blackbg#', 'INSERT'],
    \ 'n': ['#User_blackfg_greenbg_bold#', '#User_greenfg_blackbg#', 'NORMAL'],
    \ 'R': ['#User_blackfg_redbg_bold#', '#User_redfg_blackbg#', 'REPLACE'],
    \ 'c': ['#User_blackfg_greenbg_bold#', '#User_greenfg_blackbg#', 'COMMAND'],
    \ 't': ['#User_blackfg_redbg_bold#', '#User_redfg_blackbg#', 'TERMIAL'],
    \ 'v': ['#User_blackfg_pinkbg_bold#', '#User_pinkfg_blackbg#', 'VISUAL'],
    \ 'V': ['#User_blackfg_pinkbg_bold#', '#User_pinkfg_blackbg#', 'VISUAL'],
    \ "\<C-v>": ['#User_blackfg_pinkbg_bold#', '#User_pinkfg_blackbg#', 'VISUAL'],
    \ }

let g:ff_table = {'dos' : 'CRLF', 'unix' : 'LF', 'mac' : 'CR'}

let g:gitinf = 'no git '
fu! s:gitinfo() abort
    if !executable('git')
        retu
    endif
    let status = system('cd '.expand('%:h').' && git status')->trim()
    if status =~ "^fatal:"
        let g:gitinf = 'no repo '
        retu
    endif
    " TODO airline gitstatus結果を使いまわした方が早い？ -> いいだろべつに
    " TODO airline ls-filesに変える
    let cmd = "cd ".expand('%:h')." && git status --short | awk -F ' ' '{print($1)}' | grep -c "
    let a = trim(system(cmd."'A'"))
    let aa = a !='0'?'+'.a :''
    let m = trim(system(cmd."-e 'M' -e 'D'"))
    let mm = m !='0'?'!'.m :''
    let nw = trim(system(cmd."'??'"))
    let nwnw = nw !='0'?'?'.nw :''
    let er = trim(system(cmd."'U'"))
    let ee = er !='0'?'✗'.er :''
    let g:gitinf = trim(system("cd ".expand('%:h')." && git branch | awk -F '*' '{print($2)}'")).join([aa,mm,nwnw,ee],' ')
endf

fu! g:SetStatusLine() abort
    let mode = get(g:modes, mode(), ['#User_blackfg_redbg_bold#', '#User_redfg_blackbg#', 'SP'])
    " start menu BTR
    if &filetype == 'Bocchi_The_Rock'
        let mode = ['#User_blackfg_greenbg_bold#', '#User_greenfg_blackbg#', 'BTR_start_menu']
    endif
    retu '%'.mode[0].' '.mode[2].' '.'%'.mode[1].g:right_arrow.'%#User_blackfg_graybg#'.g:right_arrow
        \ .'%#User_greenfg_graybg# %<%f%m%r%h%w %#User_grayfg_blackbg#'.g:right_arrow
        \ .'%#User_greenfg_blackbg# %{g:gitinf}%*'.g:right_arrow
        \ .'%* %='
        \ .'%*'.g:left_arrow.'%#User_greenfg_blackbg# %{&filetype}'
        \ .' %#User_grayfg_blackbg#'.g:left_arrow.'%#User_greenfg_graybg# %p%% %l/%L %02v%#User_blackfg_graybg#'.g:left_arrow
        \ .'%'.mode[1].g:left_arrow.'%'.mode[0].' [%{&fenc!=""?&fenc:&enc}][%{g:ff_table[&ff]}] %*'
endf
set stl=%!g:SetStatusLine()

" tabline
fu! s:buffers_label() abort
    " airline TODO リファクタ
    let b = ''
    for v in split(execute('ls'), '\n')->map({ _,v -> split(v, ' ')})
        let x = copy(v)->filter({ _,v -> !empty(v) })
        if stridx(x[1], 'F') == -1 && stridx(x[1], 'R') == -1
            let hi = stridx(x[1], '%') != -1 ? '%#User_blackfg_greenbg#' : '%#User_greenfg_graybg#'
            let hiar = stridx(x[1], '%') != -1 ? '%#User_greenfg_blackbg#' : '%#User_grayfg_blackbg#'
            let hiarb = stridx(x[1], '%') != -1 ? '%#User_blackfg_greenbg#' : '%#User_blackfg_graybg#'
            if x[2] == '+'
                let hi = '%#User_blackfg_bluebg#'
                let hiar = '%#User_bluefg_blackbg#'
                let hiarb = '%#User_blackfg_bluebg#'
            endif
"[^/]*$
            let f = x[2] == '+' ? '✗'.matchstr(join(split(x[3],'"'),''),'[^/]*$') : matchstr(join(split(x[2],'"'),''),'[^/]*$')
            let b = b.'%'.x[0].'T'.hiarb.g:right_arrow.hi.f.hiar.g:right_arrow
        endif
    endfor
    retu b
endf
fu! s:tabpage_label(n) abort
    let hi = a:n is tabpagenr() ? '%#User_blackfg_greenbg#' : '%#User_greenfg_graybg#'
    let bufnrs = tabpagebuflist(a:n)
    let no = len(bufnrs)
    if no is 1
        let no = ''
    endif
    let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '✗' : ''
    let fname = pathshorten(bufname(bufnrs[tabpagewinnr(a:n) - 1]))
    retu '%'.a:n.'T'.hi.no.mod.fname.' ⁍|'.'%T%#TabLineFill#'
endf
fu! g:SetTabLine() abort
    if tabpagenr('$') == 1
        retu s:buffers_label()
    endif
    retu range(1,tabpagenr('$'))->map('s:tabpage_label(v:val)')->join(' ').' %#TabLineFill#%T'
endf
set tabline=%!g:SetTabLine()

fu! s:moveBuf(flg) abort
    let current_id = ''
    let buf_arr = []
    for v in split(execute('ls'), '\n')->map({ _,v -> split(v, ' ')})
        let x = copy(v)->filter({ _,v -> !empty(v) })
        if stridx(x[1], 'F') == -1 && stridx(x[1], 'R') == -1
            cal add(buf_arr, x[0])
            if stridx(x[1], '%') != -1
                let current_id = x[0]
            endif
        endif
    endfor
    let buf_idx = a:flg == 'next' ? match(buf_arr, current_id) + 1 : match(buf_arr, current_id) - 1
    let buf_id = buf_idx == len(buf_arr) ? buf_arr[0] : buf_arr[buf_idx]
    exe 'b '.buf_id
endf

fu! s:closeBuf() abort
    let now_b = bufnr('%')
    " TODO airline not key, you should call function
    execute("norm \<C-n>")
    execute('bd ' . now_b)
endf

aug user_onedark
    au!
    au ColorScheme * hi User_greenfg_blackbg ctermfg=114 ctermbg=235
    au ColorScheme * hi User_greenfg_graybg ctermfg=114 ctermbg=238
    au ColorScheme * hi User_bluefg_blackbg ctermfg=39 ctermbg=235
    au ColorScheme * hi User_pinkfg_blackbg ctermfg=169 ctermbg=235
    au ColorScheme * hi User_redfg_blackbg ctermfg=203 ctermbg=235
    au ColorScheme * hi User_grayfg_blackbg ctermfg=238 ctermbg=235
    au ColorScheme * hi User_blackfg_graybg ctermfg=235 ctermbg=238
    au ColorScheme * hi User_blackfg_greenbg ctermfg=235 ctermbg=114
    au ColorScheme * hi User_blackfg_greenbg_bold cterm=bold ctermfg=234 ctermbg=114
    au ColorScheme * hi User_blackfg_bluebg ctermfg=235 ctermbg=39
    au ColorScheme * hi User_blackfg_bluebg_bold cterm=bold ctermfg=234 ctermbg=39
    au ColorScheme * hi User_blackfg_pinkbg_bold cterm=bold ctermfg=234 ctermbg=170
    au ColorScheme * hi User_blackfg_redbg_bold cterm=bold ctermfg=234 ctermbg=204
aug END

aug status_tabLine
    au!
    au BufWinEnter,BufWritePost * cal s:gitinfo()
aug END

noremap <silent><Plug>(buf-prev) :<C-u>cal <SID>moveBuf('prev')<CR>
noremap <silent><Plug>(buf-next) :<C-u>cal <SID>moveBuf('next')<CR>
noremap <silent><Plug>(buf-close) :<C-u>cal <SID>closeBuf()<CR>
" }}}

" ===================================================================
" junegunn/fzf.vim
" ===================================================================
" {{{
" usage
" let arguments_def = #{
"     \ title: popup title as String,
"     \ list: search targets as List,
"     \ type: format in list. f, lm, flm (file, line, msg),
"     \ eprfx: enter zone prefix text as String (0 to default value),
"     \ }
" and call like this.
" cal s:fzsearch.popup(arguments_def)

let s:fzsearch = #{bwid: 0, ewid: 0, rwid: 0, pwid: 0, tid: 0, res: [],
    \ ffdict: #{vimrc: 'vim', zshrc: 'sh', js: 'javascript', py: 'python', md: 'markdown',
        \ ts: 'typescript', tsx: 'typescriptreact',
        \ },
    \ }

let s:fzsearch.allow_exts = glob($VIMRUNTIME.'/ftplugin/*.vim')->split('\n')
            \ ->map({_,v->matchstr(v,'[^/]\+\.vim')->split('\.')[0]})

fu! s:fzsearch.popup(v) abort
    if empty(a:v.list) || (len(a:v.list) == 1 && empty(a:v.list[0]))
        cal EchoE('no data')
        retu
    endif

    let self.list = a:v.list
    let self.type = a:v.type
    let self.pr = a:v.eprfx ?? '>>'
    let self.wd = ''
    let self.ridx = 0
    let self.max = 50
    let self.res = a:v.list[0:self.max]

    let self.bwid = popup_create([], #{title: ' '.a:v.title.' ',
        \ zindex: 50, mapping: 0, scrollbar: 0,
        \ border: [], borderchars: ['─','│','─','│','╭','╮','╯','╰'],
        \ minwidth: &columns*9/12, maxwidth: &columns*9/12,
        \ minheight: &lines/2+6, maxheight: &lines/2+6,
        \ line: &lines/4-2, col: &columns/8+1,
        \ })

    let self.ewid = popup_create(self.pr, #{title: ' Fuzzy Search | ClearText: <C-w> ',
        \ zindex: 100, mapping: 0,
        \ border: [], borderchars: ['─','│','─','│','╭','╮','╯','╰'],
        \ minwidth: &columns/3, maxwidth: &columns/3,
        \ minheight: 1, maxheight: 1,
        \ line: &lines*3/4+2, col: &columns/7+1,
        \ filter: function(self.fil, [#{wd: []}]),
        \ })

    let self.rwid = popup_menu(self.res, #{title: ' Choose: <C-n/p> <CR> | QuickFix: <C-q> ',
        \ zindex: 99, mapping: 0, scrollbar: 1,
        \ border: [], borderchars: ['─','│','─','│','╭','╮','╯','╰'],
        \ minwidth: &columns/3, maxwidth: &columns/3,
        \ minheight: &lines/2, maxheight: &lines/2,
        \ pos: 'topleft', line: &lines/4, col: &columns/7,
        \ callback: 'Fzsearch_confirm',
        \ filter: function(self.jk, [0]),
        \ })

    " result list syntax
    if self.type == 'lm'
        cal setbufvar(winbufnr(self.rwid), '&filetype', &filetype)
    elseif self.type == 'flm'
        cal setbufvar(winbufnr(self.rwid), '&filetype', 'vim')
    endif

    " get preview file
    let path = bufname('%')
    if self.type =~ 'flm'
        let path = split(self.res[0], '|')[0]
    elseif self.type =~ 'f'
        let path = substitute(self.res[0], '\~', $HOME, 'g')
    endif
    let read = ['Cannot open file.', 'please check this file path.', path]
    try
        let read = readfile(path)
    catch
    endtry

    " preview
    let self.pwid = popup_menu(read, #{title: ' File Preview | Scroll: <C-d/u> ',
        \ zindex: 98, mapping: 0, scrollbar: 1,
        \ border: [], borderchars: ['─','│','─','│','╭','╮','╯','╰'],
        \ minwidth: &columns/3, maxwidth: &columns/3,
        \ minheight: &lines/2+3, maxheight: &lines/2+3,
        \ pos: 'topleft', line: &lines/4, col: &columns/2+1,
        \ firstline: 1,
        \ filter: function(self.pv, [0]),
        \ })

    " get preview ext for syntax highlight
    let ext = matchstr(path, '[^\.]\+$')
    let ext = ext !~ '^[a-zA-Z0-9]\+$' ? '' : ext
    let ext = get(self.ffdict, ext, ext)
    cal setbufvar(winbufnr(self.pwid), '&filetype', self.type =~ 'f' ? ext : &filetype)

    " first line
    let lnm = 1
    if self.type == 'flm'
        let sep = split(self.res[0], '|')
        let lnm = len(sep) < 2 ? 1 : split(sep[1], ' ')[0]
    elseif self.type == 'lm'
        let lnm = split(self.res[0], ':')[0]
    endif
    " cursor line top from 10row
    cal popup_setoptions(self.pwid, #{firstline: (lnm-10 > 0 ? lnm-10 : 1)})
    cal win_execute(self.pwid, 'exe '.lnm)
endf

" on confirm
fu! Fzsearch_confirm(wid, idx) abort
    if a:idx == -1
        cal EchoE('cancel')
        cal s:fzsearch.finalize()
        retu
    endif
    let result = s:fzsearch.res[a:idx-1]

    if s:fzsearch.type == 'f'
        exe 'e '.result
    elseif s:fzsearch.type == 'lm'
        let l = split(result, ':')[0]
        cal EchoI('jump to '.l)
        exe l
    elseif s:fzsearch.type == 'flm'
        let sep = split(result, '|')
        let fnm = substitute(sep[0], $HOME, '~', 'g')
        let lnm = len(sep) < 2 ? 1 : split(sep[1], ' ')[0]
        " if quickfix window
        if expand('%')->empty()
            wincmd w
        endif
        exe 'e '.fnm
        exe lnm
        cal EchoI('jump to '.fnm.' line:'.lnm)
    endif
    cal s:fzsearch.finalize()
endf

" create quickfix
fu! s:fzsearch.quickfix() abort
    let tmp = &errorformat
    let resource = self.res
    let ef = '%f: %l: %m'

    if self.type == 'lm'
        let fnm = expand('%')
        let resource = deepcopy(self.res)->map({_,v->fnm.': '.v})
    elseif self.type == 'f'
        let resource = deepcopy(self.res)->map({_,v->v.': 1: open'})
    elseif self.type == 'flm'
        " sample
        " filename|100 col 10-15|message
        " want-> filename, 100, message
        let resource = deepcopy(self.res)->map({_,v
                    \ ->split(v,'|')[0].': '
                    \ .split(split(v,'|')[1], ' ')[0].': '
                    \ .join(split(v,'|')[2:], '')})
    endif

    let &errorformat = ef
    cgetexpr resource | cw
    let &errorformat = tmp
    cal s:fzsearch.finalize()
endf

" finalize
fu! s:fzsearch.finalize() abort
    let s:fzsearch.list = []
    let s:fzsearch.res = []
    cal s:runcat.stop()
    cal popup_clear()
endf

" preview scroll
fu! s:fzsearch.scroll(wid, vector) abort
    if self.tid
        retu
    endif
    cal timer_stop(self.tid)
    let vec = a:vector ? "\<C-n>" : "\<C-p>"
    let self.tid = timer_start(10, { -> popup_filter_menu(a:wid, vec) }, #{repeat: -1})
    let delay = 600
    cal timer_start(delay, self.scstop)
endf

fu! s:fzsearch.scstop(_) abort
    cal timer_stop(self.tid)
    let self.tid = 0
endf

" preview draw update
fu! s:fzsearch.pvupd() abort
    let win = winbufnr(self.pwid)

    if empty(self.res) && self.type == 'lm'
        retu
    endif
    if self.type == 'lm'
        let lnm = split(self.res[self.ridx], ':')[0]
        cal popup_setoptions(self.pwid, #{firstline: (lnm-10 > 0 ? lnm-10 : 1)})
        cal win_execute(self.pwid, 'exe '.lnm)
        retu
    endif

    " del
    sil! cal deletebufline(win, 1, getbufinfo(win)[0].linecount)
    " put
    if empty(self.res)
        retu
    endif
    let path = self.type == 'flm'
                \ ? split(self.res[self.ridx], '|')[0]
                \ : substitute(self.res[self.ridx], '\~', $HOME, 'g')
    let read = ['Cannot open file.', 'please check this file path.', path]
    try
        let read = readfile(path)
    catch
    endtry
    cal setbufline(win, 1, read)
    " syntax
    let ext = matchstr(path, '[^\.]\+$')
    let ext = ext !~ '^[a-zA-Z0-9]\+$' ? '' : ext
    let ext = get(self.ffdict, ext, ext)
    cal setbufvar(win, '&filetype', ext)
    " line
    let sep = split(self.res[self.ridx], '|')
    let lnm = len(sep) < 2 ? 1 : split(sep[1], ' ')[0]
    cal popup_setoptions(self.pwid, #{firstline: (lnm-10 > 0 ? lnm-10 : 1)})
    cal win_execute(self.pwid, 'exe '.lnm)
endf

" search result update
fu! s:fzsearch.list_upd() abort
    " upd match result list
    let filterd = empty(self.wd) ? self.list : matchfuzzy(self.list, self.wd)
    let self.res = filterd[0:self.max]
    let self.ridx = len(self.res)-1 < self.ridx ? len(self.res)-1 : self.ridx
    cal setbufline(winbufnr(self.ewid), 1, self.pr . self.wd)
    cal deletebufline(winbufnr(self.rwid), 1, self.max)
    echo ''
    cal setbufline(winbufnr(self.rwid), 1, self.res)
    " highlight match char
    cal clearmatches(self.rwid)
    let char = printf('[%s]', escape(self.wd, '\[\]\-\.\*'))
    cal matchadd('DarkRed', char, 16, -1, #{window: self.rwid})
    " upd preview
    cal self.pvupd()
endf

" enter search word
fu! s:fzsearch.fil(ctx, wid, key) abort
    if a:key is# "\<Esc>"
        cal popup_close(self.bwid)
        cal popup_close(self.pwid)
        cal popup_close(self.ewid)
        cal feedkeys("\<C-c>")
        retu 1
    elseif a:key is# "\<C-n>" || a:key is# "\<C-p>" || a:key is# "\<CR>"
        " only largest zindex window is active.
        cal popup_setoptions(self.rwid, #{zindex: 100})
        cal popup_setoptions(self.ewid, #{zindex: 99})
        cal popup_setoptions(self.pwid, #{zindex: 98})
        cal feedkeys(a:key)
        retu 1
    elseif a:key is# "\<C-d>" || a:key is# "\<C-u>"
        cal popup_setoptions(self.pwid, #{zindex: 100})
        cal popup_setoptions(self.ewid, #{zindex: 99})
        cal popup_setoptions(self.rwid, #{zindex: 98})
        cal feedkeys(a:key)
        retu 1
    elseif a:key is# "\<C-q>"
        cal self.quickfix()
        cal feedkeys("\<Esc>")
        retu 1
    " TODO fzf.vim copy shold D-v only or Shift Insert. C-v want split
    elseif a:key is# "\<C-v>" || a:key is# "\<D-v>"
        for i in range(0, strlen(@+)-1)
            cal add(a:ctx.wd, strpart(@+, i, 1))
        endfor
    elseif a:key is# "\<BS>" && !empty(a:ctx.wd)
        unlet a:ctx.wd[len(a:ctx.wd)-1]
    elseif a:key is# "\<BS>" && len(a:ctx.wd) == 0
        " noop
        retu 1
    elseif a:key is# "\<C-w>"
        let a:ctx.wd = []
    elseif strtrans(a:key) == "<80><fd>`"
        " noop (for polyglot bug adhoc)
        retu 1
    else
        cal add(a:ctx.wd, a:key)
    endif

    let self.wd = join(a:ctx.wd, '')
    cal self.list_upd()
    retu a:key is# "x" || a:key is# "\<Space>" ? 1 : popup_filter_menu(a:wid, a:key)
endf

" choose result
fu! s:fzsearch.jk(_, wid, key) abort
    if a:key is# "\<Esc>"
        cal popup_close(self.bwid)
        cal popup_close(self.pwid)
        cal popup_close(self.ewid)
        cal feedkeys("\<C-c>")
    elseif a:key is# "\<C-n>"
        let self.ridx = self.ridx == len(self.res)-1 ? len(self.res)-1 : self.ridx+1
        cal self.pvupd()
        retu popup_filter_menu(a:wid, a:key)
    elseif a:key is# "\<C-p>"
        let self.ridx = self.ridx ? self.ridx-1 : 0
        cal self.pvupd()
        retu popup_filter_menu(a:wid, a:key)
    elseif a:key is# "\<CR>"
        cal popup_close(self.ewid)
        cal popup_close(self.pwid)
        cal popup_close(self.bwid)
        retu popup_filter_menu(a:wid, empty(self.res) ? "\<C-c>" : a:key)
    elseif a:key is# "\<C-d>" || a:key is# "\<C-u>"
        cal popup_setoptions(self.pwid, #{zindex: 100})
        cal popup_setoptions(self.ewid, #{zindex: 99})
        cal popup_setoptions(self.rwid, #{zindex: 98})
        cal feedkeys(a:key)
    else
        cal popup_setoptions(self.ewid, #{zindex: 100})
        cal popup_setoptions(self.rwid, #{zindex: 99})
        cal popup_setoptions(self.pwid, #{zindex: 98})
        cal feedkeys(a:key)
    endif
    retu 1
endf

" scroll preview
fu! s:fzsearch.pv(_, wid, key) abort
    if a:key is# "\<Esc>"
        cal popup_close(self.bwid)
        cal popup_close(self.pwid)
        cal popup_close(self.ewid)
        cal feedkeys("\<C-c>")
    elseif a:key is# "\<C-d>"
        cal self.scroll(a:wid, 1)
    elseif a:key is# "\<C-u>"
        cal self.scroll(a:wid, 0)
    elseif a:key is# "\<C-n>" || a:key is# "\<C-p>" || a:key is# "\<CR>"
        cal popup_setoptions(self.rwid, #{zindex: 100})
        cal popup_setoptions(self.ewid, #{zindex: 99})
        cal popup_setoptions(self.pwid, #{zindex: 98})
        cal feedkeys(a:key)
    else
        cal popup_setoptions(self.ewid, #{zindex: 100})
        cal popup_setoptions(self.rwid, #{zindex: 99})
        cal popup_setoptions(self.pwid, #{zindex: 98})
        cal feedkeys(a:key)
    endif
    retu 1
endf

" =====================
fu! s:fzf_histories()
    cal s:fzsearch.popup(#{title: 'Histories', list: execute('ol')->split('\n')->map({_,v -> split(v, ': ')[1]}),
        \ type: 'f', eprfx: '['.substitute(getcwd(), $HOME, '~', 'g').']>>'})
endf

fu! s:fzf_buffers()
    cal s:fzsearch.popup(#{title: 'Buffers', list: execute('ls')->split('\n')->map({_,v -> split(v, '"')[1]})
            \ ->filter({_,v -> v != '[No Name]' && v != '[無名]'}),
        \ type: 'f', eprfx: '['.substitute(getcwd(), $HOME, '~', 'g').']>>'})
endf
" =====================

noremap <silent><Plug>(fzf-histories) :<C-u>cal <SID>fzf_histories()<CR>
noremap <silent><Plug>(fzf-buffers) :<C-u>cal <SID>fzf_buffers()<CR>
" }}}

" ===================================================================
" junegunn/fzf
" ===================================================================
" {{{
let s:fzf = #{cache: [], maxdepth: 4, gcache: [],
    \ not_path_arr: [
         \'"*/.**/*"',
         \'"*node_modules/*"', '"*target/*"'
         \'"*Applications/*"', '"*AppData/*"', '"*Library/*"',
         \'"*Music/*"', '"*Pictures/*"', '"*Movies/*"', '"*Videos/*"'
         \'"*OneDrive/*"',
    \ ],
\}

" TODO fzf delete
fu! TestFzfMaxDepth(n) abort
    let s:fzf.maxdepth = a:n
endf
" TODO fzf maxdepth かえるコマンド作るか

let s:fzf.postfix = ' -type f -not -path '.join(s:fzf.not_path_arr, ' -not -path ')
let s:fzf.searched = getcwd()
let s:fzf.get_gitls = {-> system('git ls-files -c')->split('\n')->filter({_,v->!empty(v)}) }
let s:fzf.get_file_d1 = {-> system('find . -mindepth 1 -maxdepth 1'.s:fzf.postfix)->split('\n')->filter({_,v->!empty(v)}) }
let s:fzf.get_file = { v -> 'find . -mindepth '.v.' -maxdepth '.v.s:fzf.postfix }

fu! s:fzf.files() abort
    let pwd = getcwd()
    let chk = system('git status')
    let self.is_git = v:shell_error ? 0 : 1

    " moved or first
    if stridx(pwd, self.searched) == -1
                \ || (self.is_git && empty(self.gcache))
                \ || (!self.is_git && empty(self.cache))
        let self.searched = pwd

        if self.is_git
            let self.gcache = self.get_gitls()
            cal EchoI('cache: git ls-files -c')
        else
            let self.cache = self.get_file_d1()
            cal self.asyncfind()
        endif
    endif

    cal s:fzsearch.popup(#{title: self.is_git ? 'Project Files' : 'Files',
        \ list: self.is_git ? self.gcache : self.cache,
        \ type: 'f', eprfx: '['.substitute(pwd, $HOME, '~', 'g').']>>'})
endf

fu! s:fzf.asyncfind() abort
    cal s:runcat.start()
    let self.notwid = popup_notification('find files in ['.s:fzf.searched.'] and caching ...', #{zindex: 51, line: &lines, col: 5})
    let self.jobcnt = self.maxdepth-1
    let self.endjobcnt = 0
    for depth in range(2, self.maxdepth)
        cal job_start(self.get_file(depth), #{out_cb: self.asyncfind_start, close_cb: self.asyncfind_end})
    endfor
endf

fu! s:fzf.asyncfind_start(ch, msg) abort
    cal add(self.cache, a:msg)
endf

fu! s:fzf.asyncfind_end(ch) abort
    let s:fzsearch.list = self.cache
    cal s:fzsearch.list_upd()

    let self.endjobcnt += 1
    if self.endjobcnt == self.jobcnt
        cal s:runcat.stop()
        cal popup_close(self.notwid)
        cal popup_notification('find files cached !', #{zindex: 51, line: &lines, col: 5})
    endif
endf

fu! s:fzfexe() abort
    cal s:fzf.files()
endf
noremap <silent><Plug>(fzf-smartfiles) :<C-u>cal <SID>fzfexe()<CR>
" }}}

" ===================================================================
" preservim/nerdtree
" ===================================================================
" {{{
" TODO nerdtree リファクタ

" TODO nerdtree
augroup netrw_motion
    autocmd!
    autocmd fileType netrw cal s:netrwMotion()
augroup END

fu! s:netrwMotion()
    nnoremap <buffer><C-l> <C-w>l
    ""autocmd CursorMoved * cal NetrwOpenJudge()
endf

fu! NetrwOpenJudge()
    " XXX windows gitbashだとmapしたら上手く動かない
    " キー入力監視に変えるか？
    nmap <buffer><CR> <Plug>NetrwLocalBrowseCheck
    if getline('.')[len(getline('.'))-1] != '/'
        nmap <buffer><CR> <Plug>NetrwLocalBrowseCheck:cal NetrwOpen()<CR>
    endif
endf

" TODO nerdtree mapじゃなくしたいね
fu! NetrwOpen()
    cal feedkeys("\<C-l>:q\<CR>\<Space>e")
endf

fu! s:create_winid2bufnr_dict() abort
    let winid2bufnr_dict = {}
    for bnr in range(1, bufnr('$'))
        for wid in win_findbuf(bnr)
            let winid2bufnr_dict[wid] = bnr
        endfor
    endfor
    retu winid2bufnr_dict
endf
fu! s:winid2bufnr(wid) abort
    retu s:create_winid2bufnr_dict()[a:wid]
endf

fu! s:NetrwToggle()
    for win_no in range(1, winnr('$'))
        let win_id = win_getid(win_no)
        if bufname(s:winid2bufnr(win_id)) == 'NetrwTreeListing'
            cal win_execute(win_id, 'close')
            retu
        endif
    endfor
    execute('Vex 15')
endf
noremap <silent><Plug>(explorer-toggle) :<C-u>cal <SID>NetrwToggle()<CR>


" }}}

" ===================================================================
" yuttie/comfortable-motion.vim
" ===================================================================
" {{{
" while scroll, deactivate f-scope
let s:scroll = #{tid: 0, curL: '', curC: '', till: 600}

" TODO scroll sometimes so heavy. mainly C-f timer wrong?
fu! s:scroll.exe(vector, delta) abort
    if self.tid
        retu
    endif
    cal timer_stop(self.tid)
    cal self.toggle(0)
    let vec = a:vector ? "\<C-e>" : "\<C-y>"
    let self.tid = timer_start(a:delta, { -> feedkeys(vec) }, #{repeat: -1})
    cal timer_start(self.till, self.stop)
    cal timer_start(self.till, self.toggle)
endf

fu! s:scroll.stop(_) abort
    cal timer_stop(self.tid)
    let self.tid = 0
endf

fu! s:scroll.toggle(tid) abort
    if !a:tid
        let self.curL = execute('set cursorline?')->trim()
        let self.curC = execute('set cursorcolumn?')->trim()
        set nocursorline nocursorcolumn
        cal timer_start(0, { -> s:fmode.deactivate() }) " for coc, async
        retu
    endif
    if self.curL !~'^no'
        set cursorline
    endif
    if self.curC !~'^no'
        set cursorcolumn
    endif
    cal s:fmode.takeover()
endf

fu! s:scroll(v, d) abort
    cal s:scroll.exe(a:v, a:d)
endf
noremap <silent><Plug>(scroll-d) :<C-u>cal <SID>scroll(1, 30)<CR>
noremap <silent><Plug>(scroll-u) :<C-u>cal <SID>scroll(0, 30)<CR>
noremap <silent><Plug>(scroll-f) :<C-u>cal <SID>scroll(1, 10)<CR>
noremap <silent><Plug>(scroll-b) :<C-u>cal <SID>scroll(0, 10)<CR>

fu! Scroll(vec, del) abort " for coc
    cal s:scroll(a:vec, a:del)
    retu "\<Ignore>"
endf
" }}}

" ===================================================================
" easymotion/vim-easymotion
" ===================================================================
" {{{
" m, g read some function doesn't work just as I want
let s:emotion = #{keypos: [], klen: 1, keys: ['s', 'w', 'a', 'd', 'j', 'k', 'h', 'l'], popid: 0}

fu! s:emotion.exe() abort
    " fold all open
    norm zR
    " get target chars in current window without empty line
    " [{'row': row number, 'col': [ col number, ... ]}...]
    let self.keypos = []
    let self.klen = 1
    let wininfo = []
    let tarcnt = 0
    let rn = line('w0')
    let self.cl = line('.')
    let self.cc = col('.')
    let self.sl = line('w0')
    let self.ctx = getline('w0', 'w$')
    for l in self.ctx
        " loop row without 'including MultiByte' and 'empty', get head chars
        " 日本語は1文字でマルチバイト3文字分だが、カーソル幅は2なのでめんどい、日本語を含む行は弾く
        if l !~ '^[ -~|\t]\+$'
            let rn+=1
            continue
        endif
        let chars = []
        let ofst = 0
        while ofst != -1
            let st = matchstrpos(l, '\<.', ofst)
            let ofst = matchstrpos(l, '.\>', ofst)[2]
            if st[0] != ''
                cal add(chars, st[2])
            endif
        endwhile
        if !empty(chars)
            cal add(wininfo, #{row: rn, col: chars})
        endif
        let tarcnt = tarcnt+len(chars)
        let rn+=1
    endfor
    if tarcnt==0
        retu
    endif
    " calc key stroke length, keyOrder is 'ssw' = [0,0,1]
    while tarcnt > pow(len(self.keys), self.klen)
        let self.klen+=1
    endwhile
    let keyOrder = range(1, self.klen)->map({->0})
    " sort near current line, create 'self_keypos' map like this
    " [{'row': 1000, 'col': [{'key': 'ssw', 'pos': 7}, ... ]}, ... ]
    for r in sort(deepcopy(wininfo), { x,y -> abs(x.row-self.cl) - abs(y.row-self.cl) })
        let tmp = []
        for col in r.col
            cal add(tmp, #{key: copy(keyOrder)->map({i,v->self.keys[v]})->join(''), pos: col})
            let keyOrder = self.incrementNOrder(len(self.keys)-1, keyOrder)
        endfor
        cal add(self.keypos, #{row: r.row, col: tmp})
    endfor
    " create preview window
    sil! e 'emotion'
    setl buftype=nofile bufhidden=wipe nobuflisted
    " fill blank
    cal setline(1, range(1, self.sl))
    cal self.previewini()
    " disable diagnostic
    if exists('*CocAction')
        cal CocAction('diagnosticToggle')
    endif
    " draw
    cal matchadd('EmotionBase', '.', 98)
    cal self.draw(self.keypos)
    cal popup_close(self.popid)
    let self.popid = popup_create('e-motion', #{line: &lines, col: &columns*-1, mapping: 0, filter: self.char_enter})
    cal setwinvar(self.popid, '&wincolor', 'DarkBlue')
    echo ''
endf

fu! s:emotion.previewini() abort
    " restore contents
    cal setline(self.sl, self.ctx)
    " restore cursor position
    cal cursor(self.sl+5, self.cc)
    norm! zt
    cal cursor(self.cl, self.cc)
endf

" function: increment N order
" 配列をN進法とみなし、1増やす. 使うキーがssf → sws と繰り上がる仕組み
fu! s:emotion.incrementNOrder(nOrder, keyOrder) abort
    if len(a:keyOrder) == 1
        retu [a:keyOrder[0]+1]
    endif
    let tmp = []
    let overflow = 0
    for idx in reverse(range(0, len(a:keyOrder)-1))
        " 1. increment last digit
        if idx == len(a:keyOrder)-1
            cal insert(tmp, a:keyOrder[idx] == a:nOrder ? 0 : a:keyOrder[idx]+1)
            if tmp[0] == 0
                let overflow = 1
            endif
            continue
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

" draw keystroke
" 日本語は1文字でマルチバイト3文字分だが、カーソル幅は2なのでめんどいから弾いてある
" posの次文字がマルチバイトだと、strokeが2回以上残ってる時、変に文字を書き換えてカラム数変わる
fu! s:emotion.draw(keypos) abort
    cal self.previewini()
    cal self.hl_del(['EmotionFin', 'EmotionWip'])
    let hlpos_wip = []
    let hlpos_fin = []
    for r in a:keypos
        let line = getline(r.row)
        for c in r.col
            let colidx = c.pos-1
            let view_keystroke = c.key[:0]
            let offset = colidx-1
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
    for t in hlpos_fin
        cal matchaddpos('EmotionFin', [t], 99)
    endfor
    for t in hlpos_wip
        cal matchaddpos('EmotionWip', [t], 100)
    endfor
endf

fu! s:emotion.char_enter(winid, key) abort
    " noop (for polyglot bug adhoc)
    if strtrans(a:key) == "<80><fd>`"
        retu 1
    endif
    " only accept defined emotion key
    if self.keys->index(a:key) == -1
        " go out e-motion
        cal popup_close(self.popid)
        let p = getpos('.')
        " close preview
        b #
        cal cursor(p[1],p[2])
        cal self.hl_del(['EmotionFin', 'EmotionWip', 'EmotionBase'])
        " restore diagnostic
        if exists('*CocAction')
            cal CocAction('diagnosticToggle')
        endif
        cal EchoE('e-motion: go out')
        retu 1
    endif
    " upd emotion.keypos
    let tmp = self.keypos->deepcopy()->map({ _,r -> #{row: r.row,
        \ col: r.col->filter({_,v->v.key[0]==a:key})->map({_,v->#{key: v.key[1:], pos: v.pos}})} })
        \ ->filter({_,v->!empty(v.col)})
    " nomatch -> noop
    if empty(tmp)
        retu 1
    else
        let self.keypos = tmp
    endif
    " if last match -> end e-motion
    if len(self.keypos) == 1 && len(self.keypos[0].col) == 1
        cal popup_close(self.popid)
        " close previeew
        b #
        norm! zR
        cal cursor(self.keypos[0].row, self.keypos[0].col[0].pos)
        cal self.hl_del(['EmotionFin', 'EmotionWip', 'EmotionBase'])
        " restore diagnostic
        if exists('*CocAction')
            cal CocAction('diagnosticToggle')
        endif
        cal EchoI('e-motion: finish')
        retu 1
    endif
    " redraw
    cal self.draw(self.keypos)
    retu 1
endf

" about highlight setting
fu! s:emotion.hl_del(group_name_list) abort
    cal getmatches()->filter({ _,v -> match(a:group_name_list, v.group) != -1 })->map({ _,v -> matchdelete(v.id) })
endf

aug emotion_hl
    au!
    au ColorScheme * hi EmotionBase ctermfg=59
    au ColorScheme * hi EmotionWip ctermfg=166 cterm=bold
    au ColorScheme * hi EmotionFin ctermfg=196 cterm=bold
aug END

fu! s:emotion() abort
    cal s:emotion.exe()
endf
noremap <silent><Plug>(emotion) :<C-u>cal <SID>emotion()<CR>
" }}}

" ===================================================================
" unblevable/quick-scope
" ===================================================================
" {{{
let s:fmode = #{flg: 1}

fu! s:fmode.set() abort
    cal getmatches()->filter({ _,v -> v.group =~ 'FScope.*' })->map('execute("cal matchdelete(v:val.id)")')
    let rn = line('.')
    let cn = col('.')
    let rtxt = getline('.')
    let tar = []
    let tar2 = []
    let bak = []
    let bak2 = []
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
                cal add(stridx(ashiato, next_char) == -1 ? bak    : bak2 , [rn, start[2]+1])
            endif
        endif
    endwhile
    if !empty(tar)
        cal matchaddpos('FScopePrimary', tar, 16)
        endif
    if !empty(tar2)
        cal matchaddpos('FScopeSecondary', tar2, 16)
    endif
    if !empty(bak)
        cal matchaddpos('FScopeBackPrimary', bak, 16)
    endif
    if !empty(bak2) 
        cal matchaddpos('FScopeBackSecondary', bak2, 16) 
    endif
endf

fu! s:fmode.activate() abort
    aug f_scope
        au!
        au CursorMoved * cal s:fmode.set()
    aug End
    cal s:fmode.set()
endf

fu! s:fmode.deactivate() abort
    aug f_scope
        au!
    aug End
    let current_win = win_getid()
    windo cal getmatches()->filter({ _,v -> v.group =~ 'FScope.*' })->map('execute("cal matchdelete(v:val.id)")')
    cal win_gotoid(current_win)
endf

fu! s:fmode.toggle() abort
    if s:fmode.flg
        let s:fmode.flg = 0
        cal s:fmode.deactivate()
    else
        let s:fmode.flg = 1
        cal s:fmode.activate()
    endif
endf

fu! s:fmode.takeover() abort
    if s:fmode.flg
        cal s:fmode.activate()
    else
        cal s:fmode.deactivate()
    endif
endf

aug fmode_colors
    au!
    au ColorScheme * hi FScopePrimary ctermfg=196 cterm=underline guifg=#66D9EF guibg=#000000
    au ColorScheme * hi FScopeSecondary ctermfg=219 cterm=underline guifg=#66D9EF guibg=#000000
    au ColorScheme * hi FScopeBackPrimary ctermfg=51 cterm=underline guifg=#66D9EF guibg=#000000
    au ColorScheme * hi FScopeBackSecondary ctermfg=33 cterm=underline guifg=#66D9EF guibg=#000000
aug END

fu! s:fmodetoggle() abort
    cal s:fmode.toggle()
endf
noremap <silent><Plug>(f-scope) :<C-u>cal <SID>fmodetoggle()<CR>
" }}}

" ===================================================================
" t9md/vim-quickhl
" ===================================================================
" {{{
let s:quickhl = #{hlidx: 0, reseted: 0}
let s:quickhl.hl= [
    \ "cterm=bold ctermfg=16 ctermbg=153 gui=bold guifg=#ffffff guibg=#0a7383",
    \ "cterm=bold ctermfg=7 ctermbg=1 gui=bold guibg=#a07040 guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=2 gui=bold guibg=#4070a0 guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=3 gui=bold guibg=#40a070 guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=4 gui=bold guibg=#70a040 guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=5 gui=bold guibg=#0070e0 guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=6 gui=bold guibg=#007020 guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=21 gui=bold guibg=#d4a00d guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=22 gui=bold guibg=#06287e guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=45 gui=bold guibg=#5b3674 guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=16 gui=bold guibg=#4c8f2f guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=50 gui=bold guibg=#1060a0 guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=56 gui=bold guibg=#a0b0c0 guifg=black",
    \ ]

fu! s:quickhl.hlini() abort
    for v in s:quickhl.hl
        exe 'hi UserSearchHi'.index(s:quickhl.hl, v).' '.v
    endfor
endf

fu! s:quickhl.reset(cw) abort
    let s:quickhl.reseted = 0
    let already = getmatches()->filter({ _,v -> has_key(v, 'pattern') ? v.pattern == a:cw : 0 })
    if !empty(already)
        cal matchdelete(already[0].id)
        let s:quickhl.reseted = 1
    endif
endf

fu! s:quickhl.set() abort
    let current_win = winnr()
    let cw = expand('<cword>')
    windo cal s:quickhl.reset(cw)
    if s:quickhl.reseted
        exe current_win.'wincmd w'
        retu
    endif
    windo cal matchadd('UserSearchHi'.s:quickhl.hlidx, cw)
    let s:quickhl.hlidx = s:quickhl.hlidx >= len(s:quickhl.hl)-1 ? 0 : s:quickhl.hlidx + 1
    exe current_win.'wincmd w'
endf

fu! s:quickhl.clear() abort
    let current_win = winnr()
    windo cal getmatches()->filter({ _,v -> v.group =~ 'UserSearchHi.*' })->map('execute("cal matchdelete(v:val.id)")')
    exe current_win.'wincmd w'
endf

aug quickhl
    au!
    au ColorScheme * cal s:quickhl.hlini()
aug END

fu! s:quickhlset() abort
    cal s:quickhl.set()
endf
fu! s:quickhlclear() abort
    cal s:quickhl.clear()
endf
noremap <silent><Plug>(qikhl-toggle) :<C-u>cal <SID>quickhlset()<CR>
noremap <silent><Plug>(qikhl-clear) :<C-u>cal <SID>quickhlclear()<CR>
" }}}

" ===================================================================
" MattesGroeger/vim-bookmarks
" ===================================================================
" {{{
sign define mk text=⚑ texthl=DarkBlue

let s:mk = #{winid: 0, tle: 'marks', allwinid: 0, atle: 'marks-allfiles',
    \ path: $HOME.'/.mk',
    \ list: { -> sign_getplaced(bufname('%'), #{group: 'mkg'})[0].signs },
    \ next: { _,v -> v.lnum > line('.') }, prev: { _,v -> v.lnum < line('.') },
    \ }

fu! s:mk.read() abort
    retu glob(self.path)->empty() ? {} : readfile(self.path)->join('')->js_decode() ?? {}
endf

fu! s:mk.save() abort
    let alldata = self.read()
    let alldata[expand('%:p')] = self.list()
    cal writefile([js_encode(alldata)], self.path)
endf

fu! s:mk.load() abort
    let alldata = self.read()
    if !has_key(alldata, expand('%:p'))
        retu
    endif
    for v in alldata[expand('%:p')]
        cal sign_place(v.id, v.group, v.name, bufname('%'), #{lnum: v.lnum})
    endfor
endf

" TODO mk mark マーク増える問題
fu! s:mk.toggle() abort
    let lmk = sign_getplaced(bufname('%'), #{group: 'mkg', lnum: line('.')})[0].signs
    if empty(lmk)
        cal EchoI('mark')
        cal sign_place(0, 'mkg', 'mk', bufname('%'), #{lnum: line('.')})
    else
        cal EchoI('remove mark')
        cal sign_unplace('mkg', #{buffer: bufname('%'), id: lmk[0].id})
    endif
    cal self.save()
endf

" echo async because jump with scroll need time
fu! s:mk.jump(next) abort
    let list = self.list()
    if empty(list)
        cal EchoE('no marks')
        retu
    endif
    let cnt = len(list)
    let Vector = a:next ? self.next : self.prev
    let can = deepcopy(list)->filter(Vector)->sort({ x, y -> x.lnum - y.lnum })
    if empty(can)
        cal EchoW('no next marks')
        retu
    endif
    cal sign_jump((a:next ? can[0] : can[-1]).id, 'mkg', bufname('%'))
    cal timer_start(100, { -> EchoI(printf('mark jump [%s/%s]', a:next ? cnt - len(can) + 1 : len(can), cnt)) })
endf

fu! s:mk.clthis() abort
    cal sign_unplace('mkg', #{buffer: bufname('%')})
    cal self.save()
    cal EchoI('clear mark in this file')
endf

fu! s:mk.clall() abort
    if confirm('clear mark in all files ?', "&Yes\n&No\n&Cancel") != 1
        cal EchoW('cancel', 0)
        retu
    endif
    cal sign_unplace('mkg')
    cal writefile([], self.path)
    cal EchoI('clear ALL marks', 0)
endf

fu! s:mk.listcb() abort
    let alldata = self.read()
    " { filename: [{lnum id name priority group}] }
    " filename|lnum|msg

    let resource = []
    let pwd = getcwd().'/'
    for fpath in keys(alldata)
        let read = []
        try
            let read = readfile(fpath)
        catch
        endtry
        if !empty(read)
            for d in alldata[fpath]
                let relfpath = substitute(fpath, pwd, '', 'g')
                cal add(resource, relfpath.'|'.d.lnum.'|'.read[d.lnum-1])
            endfor
        endif
    endfor

    if empty(resource)
        cal EchoE('no marks')
        retu
    endif
    cal s:fzsearch.popup(#{title: 'Marks', list: resource, type: 'flm', eprfx: 0})
endf

aug mk_st
    au!
    au BufEnter * cal s:mk.load()
    au BufWritePost * cal s:mk.save()
aug END

fu! s:mktoggle() abort
    cal s:mk.toggle()
endf
fu! s:mknext () abort
    cal s:mk.jump(1)
endf
fu! s:mkprev() abort
    cal s:mk.jump(0)
endf
fu! s:mkclthis () abort
    cal s:mk.clthis()
endf
fu! s:mkclall () abort
    cal s:mk.clall()
endf
fu! s:mklist () abort
    cal s:mk.listcb()
endf

noremap <silent><Plug>(mk-toggle) :<C-u>cal <SID>mktoggle()<CR>
noremap <silent><Plug>(mk-next) :<C-u>cal <SID>mknext()<CR>
noremap <silent><Plug>(mk-prev) :<C-u>cal <SID>mkprev()<CR>
noremap <silent><Plug>(mk-clthis) :<C-u>cal <SID>mkclthis()<CR>
noremap <silent><Plug>(mk-clall) :<C-u>cal <SID>mkclall()<CR>
noremap <silent><Plug>(mk-list) :<C-u>cal <SID>mklist()<CR>
" }}}

" ===================================================================
" junegunn/goyo.vim
" ===================================================================
" {{{
let s:zen_mode = #{flg: 0, vert_split: []}
fu! s:zen_mode.toggle() abort
    if self.flg
        let self.flg = 0
        set number cursorline cursorcolumn laststatus=2 showtabline=2
        tabc
        exe 'hi VertSplit '.join(self.vert_split[2:], ' ')
        retu
    endif
    let self.flg = 1
    tab split
    norm zR
    set nonumber norelativenumber nocursorline nocursorcolumn laststatus=0 showtabline=0
    vert to new
    cal self.silent()
    vert bo new
    cal self.silent()
    "['NonText', 'FoldColumn', 'ColorColumn', 'VertSplit', 'StatusLine', 'StatusLineNC', 'SignColumn']
    let self.vert_split = execute('hi VertSplit')->split(' ')->filter({ _,v -> !empty(v) })
    exe 'hi VertSplit ctermfg=black ctermbg=NONE cterm=NONE'
    setl number relativenumber
endf

fu! s:zen_mode.silent() abort
    setl buftype=nofile bufhidden=wipe nomodifiable nobuflisted nonu noru winfixheight
    vert res 40
    exe winnr('#').'wincmd w'
endf

fu! s:zenModeToggle() abort
    cal s:zen_mode.toggle()
endf
noremap <silent><Plug>(zen-mode) :<C-u>cal <SID>zenModeToggle()<CR>
" }}}

" ===================================================================
" mhinz/vim-startify
" ===================================================================
" {{{
let s:start = #{}

" ぼっちざろっく{{{
let s:start.btr_logo = [
    \'                                                                                                                                              dN',
    \'                                                                                                              ..                             JMF',
    \'                                                                                                         ..gMMMM%                           JMF',
    \'                                                                                                       .MM9^ .MF                           (MF',
    \'                                                                                              .(,      ("   .M#                  .g,      .MF',
    \'                                        .,  dN                                             gg,,M@          .M#                  .M#!      (M>',
    \'                                        JM} M#             .MNgg.                     .g,  ?M[ 7B         .MMg+gg,.           .MM"        ."',
    \'                                ...gNMN,.Mb MN           .gMM9!                      .(MN,  .=           .MMM9=  ?MN,         (WN,      .MM ',
    \'                   jN-      ..gMMN#!     (Mp(M}       .+MMYMF                    ..kMMWM%               ,M#^       dN.          .WNJ,   JM',
    \'                   MM     .MM9^  dN,                 dNB^ (M%                   ?M"!  ,M\        .,               .M#   .&MMMN,    ?"   M#',
    \'                   MN            .MN#^                    dM:  ..(J-,                 ,B         .TM             .M#   ,M@  .MF',
    \'                   MN.       ..MMBMN_                     dN_.MM@"!?MN.   TMm     .a,                           (M@         MM^',
    \'                   MN.     .MM"  JMb....       ..        dMMM=     .Mb            ?HNgJ..,                   .MM^',
    \'                   dM{          -MMM#7"T""   .dN#TMo       ?      .MM^                 ?!                 +gM#=',
    \'                   (M]         .MN(N#       .M@  .MF              .MM^                                      ~',
    \'                   .MN          ?"""             MM!            .MMD',
    \'                    ?N[                                         7"',
    \'                     TMe',
    \'                      ?MN,',
    \'                        TMNg,'
    \]
"}}}

" cheat sheet {{{
let s:start.cheat_sheet_win = [
    \'       ╭── Window ──────────────────────────────────────────╮           ╭── Search ───────────────────────────────────────╮',
    \'       │ C-n / p    | (buffer tab)(next / prev)             │           │ Space e    | (explorer)                         │',
    \'       │ Space x    | (buffer tab)(close)                   │           │ Space f    | (fzf)(files / projectfiles auto)   │',
    \'       │ C-w v / s  | (window split)(vertical / horizontal) │           │ Space h    | (fzf)(histories)                   │',
    \'       │ ←↑↓→       | (window)(resize)                      │           │ Space b    | (fzf)(buffers)                     │',
    \'       │ C-hjkl     | (window)(forcus)                      │           │ Space m    | (marks)                            │',
    \'       │ Space t    | (terminal)                            │           │ Space s    | (fuzzy search in file / quickfix)  │',
    \'       │ Space z    | (Zen Mode)                            │           │ Space*2 s  | (grep current file)                │',
    \'       ╰────────────────────────────────────────────────────╯           │ Space g    | (grep free interactive)            │',
    \'                                                                        │ Space q    | (clear search highlight)           │',
    \'                                                                        ╰─────────────────────────────────────────────────╯',
    \'',
    \'       ╭── Motion ───────────────────────────────────────────╮          ╭── Command ──────────────────────────────────────────╮',
    \'       │ Space v       | (IDE Action Menu)                   │          │ :PlugInstall            | (plugins install)         │',
    \'       │ Space w       | (f-scope toggle)                    │          │ :PlugUnInstall          | (plugins uninstall)       │',
    \'       │ Tab S-Tab     | (jump 5rows)                        │          │ :RunCat [option]        | (running cat)             │',
    \'       │ s             | (easymotion)                        │          │ :RunCatStop             | (running cat stop)        │',
    \'       │ mm            | (mark toggle)                       │          │ :TrainingWheelsProtocol | [option] (training vim)   │',
    \'       │ mn / mp       | (mark next / prev)                  │          ╰─────────────────────────────────────────────────────╯',
    \'       │ mc / mx       | (mark clear file / delete all file) │',
    \'       │ INSERT C-hjkl | (cursor move)                       │',
    \'       │ VISUAL C-jk   | (blok up / down)                    │',
    \'       ╰─────────────────────────────────────────────────────╯',
    \]
" }}}

fu! s:start.exe() abort
    let fopen = execute('ls')->split('\n')->map({_,v -> split(v, '"')[1]})
            \ ->filter({_,v -> v != '[No Name]' && v != '[無名]'})->len()
    if fopen
        cal self.move()
        retu
    endif
    " preview window
    sil! exe 'e _cheat_cheet_'
    setl buftype=nofile bufhidden=wipe nobuflisted modifiable
    setl nonumber norelativenumber nocursorline nocursorcolumn signcolumn=no
    let &filetype = 'Bocchi_The_Rock'
    nmap <buffer>i \<Esc>
    nmap <buffer>I \<Esc>
    nmap <buffer>a \<Esc>
    nmap <buffer>A \<Esc>
    nmap <buffer>s \<Esc>

    " draw
    cal append('$', self.btr_logo)
    cal append('$', ['',''])
    cal append('$', self.cheat_sheet_win)
    hi BTR ctermfg=218 cterm=bold
    cal matchaddpos('BTR', range(2,9)->map({_,v->[v]}), 999)
    cal matchaddpos('BTR', range(10,17)->map({_,v->[v]}), 999)
    cal matchaddpos('BTR', range(18,21)->map({_,v->[v]}), 999)
    cal matchadd('User_greenfg_blackbg', '[─│╰╯╭╮]', 20)
    cal matchadd('DarkOrange', '\(Window\|Search\|Motion\|Command\)')
    cal matchadd('DarkBlue', '│.\{-,25}|', 19)
    cal matchadd('DarkRed', '(.*)', 18)

    " fix
    setl nomodifiable nomodified
endf

fu! s:start.move() abort
    cal clearmatches()
    cal s:fmode.activate()

    " deactivate
    aug start_vim
        au!
    aug END
endf

" only first call
" TODO startify BufLeaveだと、explorer開いた時に、start menu画面でのハイライトが残ったまま。
aug start_vim
    au!
    au VimEnter * cal s:start.exe()
    au BufLeave * cal s:start.move()
aug END
" }}}

" ===================================================================
" markonm/traces.vim
" ===================================================================
" {{{
let s:livereplace = #{flg: 0, matchid: 0}

fu! s:livereplace.enter() abort
    let self.vs = getpos("'<")
    let self.ve = getpos("'>")
endf

fu! s:livereplace.preview() abort
    " memory current buf
    let self.ctx = getline('0', '$')
    let self.p = getpos('.')
    let ff = &filetype
    " create preview
    sil! exe 'e live_replace'
    setl buftype=nofile bufhidden=wipe nobuflisted modifiable
    exe 'setl filetype='.ff
endf

" reset replace
fu! s:livereplace.preview_reset() abort
    cal setline(1, self.ctx)
    cal cursor(self.p[1],self.p[2])
endf

fu! s:livereplace.change() abort
    " only substitute command
    let cmdline = getcmdline()
    if cmdline !~ "^'<,'>s/" && cmdline !~ "^%s/" && cmdline !~ "^.*s/"
        retu
    endif

    " reset replace
    if self.flg
        cal self.preview_reset()
        cal clearmatches()
    endif

    " live replace
    let cmd = split(cmdline, '/')
    if len(cmd) >= 3
        " create preview window
        if !self.flg
            cal popup_notification('live replace preview', #{line: &lines})
            cal self.preview()
            cal self.preview_reset()
            let self.flg = 1
        endif
        let subst = join(cmd[0:2], '/').'/g'
        " visual mode
        if self.vs[1] && self.ve[1]
            let subst = self.vs[1].','.self.ve[1].'s/'.join(cmd[1:2], '/').'/g'
        endif
        " TODO live replace want no move. matchadd is move
        let p = getpos('.')
        exe subst
        let self.matchid = matchadd('User_blackfg_redbg_bold', cmd[2])
        " matchaddposにする？
        cal cursor(p[1],p[2])
    endif
endf

" leave preview window
fu! s:livereplace.leave() abort
    if !self.flg
        retu
    endif
    let self.flg = 0
    b #
    if getmatches()->filter({_,v->get(v, 'id', '') == self.matchid})->len()
        cal matchdelete(self.matchid)
    endif
endf

aug live_replace
    au!
    au CmdlineEnter : cal s:livereplace.enter()
    au CmdlineChanged : cal s:livereplace.change()
    au CmdlineLeave  : cal s:livereplace.leave()
aug END
" }}}

" ===================================================================
" thinca/vim-quickrun
" ===================================================================
" {{{
" TODO quick run リファクタ、試しながら直す
" java11 can execute `java File.java`
let s:quickrun = #{
    \ exe_dict: #{
        \ zsh: 'sh',
        \ sh: 'sh',
        \ python: 'python',
        \ go: 'go run',
        \ java: 'java',
        \ },
    \ svr_dict: #{
        \ python: 'python app.py',
        \ go: 'go run .',
        \ typescript: 'npm run start',
        \ typescriptreact: 'npm run start',
        \ },
    \ }

fu! s:quickrun.exe() abort
    let cmd = get(self.exe_dict, &filetype, '')
    if empty(cmd)
        cal EchoE('unsupported program.')
        retu
    endif
    let cmd = cmd.' '.expand('%')
    " TODO quick run 再実行で開いてたら、閉じる
    sil! exe 'vne result'
    setl buftype=nofile bufhidden=wipe modifiable
    setl nonumber norelativenumber nocursorline nocursorcolumn signcolumn=no
    sil! exe 'r!time '.cmd
endf

fu! s:quickrun.server() abort
    let cmd = get(self.svr_dict, &filetype, '')
    if empty(cmd)
        cal EchoE('unsupported program.')
        retu
    endif
    exe 'bo terminal ++rows=10 ++shell '.cmd
endf
" }}}

" }}}

" ##################      PLUG MANAGE       ################### {{{
" repo
" neoclide/coc.nvim has special args
let s:plug = #{}
let s:plug.repos = [
    \ 'puremourning/vimspector',
    \ 'github/copilot.vim',
    \ 'CoderCookE/vim-chatgpt',
    \ ]

" coc extentions
let s:plug.coc_extentions = [
    \ 'coc-explorer', 'coc-fzf-preview', 'coc-snippets',
    \ 'coc-sh', 'coc-vimlsp', 'coc-json', 'coc-sql', 'coc-html', 'coc-css',
    \ 'coc-tsserver', 'coc-clangd', 'coc-go', 'coc-pyright', 'coc-java',
    \ ]

let s:plug.coc_config = ['{',
    \ '    "snippets.ultisnips.pythonPrompt": false,',
    \ '    "explorer.icon.enableNerdfont": true,',
    \ '    "explorer.file.showHiddenFiles": true,',
    \ '    "python.formatting.provider": "yapf",',
    \ '    "pyright.inlayHints.variableTypes": false',
    \ '}',
    \]

fu! s:plug.install() abort
    let cmd = "mkdir -p ~/.vim/pack/plugins/start && cd ~/.vim/pack/plugins/start && repos=('".join(self.repos,"' '")."') && for v in ${repos[@]};do git clone --depth 1 https://github.com/${v};done"
      \ ." && git clone -b release https://github.com/neoclide/coc.nvim"
    cal s:runcat.start()
    cal job_start(["/bin/zsh","-c",cmd], #{close_cb: self.coc_setup})
    cal EchoI('colors, plugins installing...')
    cal popup_notification('colors, plugins installing...', #{zindex: 999, line: &lines, col: 5})
endf

" coc extentions
fu! s:plug.coc_setup(ch) abort
    cal s:runcat.stop()
    cal EchoE('plugins installed. coc-extentions installing. PLEASE REBOOT VIM after this.')
    cal popup_notification('colors, plugins installed. coc-extentions installing. PLEASE REBOOT VIM after this.', #{zindex: 999, line: &lines, col: 5})
    exe 'source ~/.vim/pack/plugins/start/coc.nvim/plugin/coc.vim'
    exe 'CocInstall '.join(self.coc_extentions, ' ')
    cal writefile(self.coc_config, $HOME.'/.vim/coc-settings.json')
    "cal coc#util#install() if git clone --depth 1, need this statement
endf

" uninstall
fu! s:plug.uninstall() abort
    cal EchoE('delete ~/.vim')
    let w = confirm('Are you sure to delete these folders ?', "&Yes\n&No\n&Cancel")
    if w != 1
        cal EchoI('cancel')
        retu
    endif
    exe "bo terminal ++shell echo 'start' && rm -rf ~/.vim && echo 'end. PLEASE REBOOT VIM'"
endf

com! PlugInstall cal s:plug.install()
com! PlugUnInstall cal s:plug.uninstall()
" }}}

" ##################        TRAINING        ################### {{{
" TODO training リファクタ
" TODO training コマンド引数の補完つくる
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
    " TODO training get practice.md
    " if すでにあるなら開くだけ
    " if vimレポ落としてるならコピー
    let repo = 'https://raw.githubusercontent.com/serna37/vim/master/practice.md'
    let cmd = 'curl '.repo.' > ~/practice.md'
    cal job_start(["/bin/zsh","-c",cmd], {'close_cb': function('TrainingWheelsPracticeFileOpen')})
endf

" open practice file (only tutorial)
fu! TrainingWheelsPracticeFileOpen(ch) abort
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

" fzf run time path(git, homebrew)
set rtp+=~/.vim/pack/plugins/start/fzf
set rtp+=/opt/homebrew/opt/fzf

" chat gpt
let g:chat_gpt_max_tokens=4000

" }}}

" ##################      PLUGIN KEYMAP     ################### {{{
" coc
if !glob('~/.vim/pack/plugins/start/coc.nvim')->empty()
    " explorer
    nnoremap <silent><Leader>e :CocCommand explorer --width 30<CR>

    " cursor highlight
    autocmd CursorHold * silent cal CocActionAsync('highlight')

    " completion @ coc
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
    inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
    inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

    " IDE
    nmap <Leader>d <Plug>(coc-definition)
    nnoremap <Leader>r :CocCommand fzf-preview.CocReferences<CR>
    nnoremap <Leader>o :CocCommand fzf-preview.CocOutline<CR>
    nnoremap <Leader>? :cal CocAction('doHover')<CR>
    nmap <Leader>, <plug>(coc-diagnostic-next)
    nmap <Leader>. <plug>(coc-diagnostic-prev)
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : Scroll(1, 10)
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : Scroll(0, 10)
endif
" }}}
" }}}

" #############################################################
" ##################        STARTING        ###################
" #############################################################
" {{{

aug base_color
    au!
    au ColorScheme * hi Normal ctermbg=235
aug END
colorscheme torte
" ===================================================================
" joshdick/onedark.vim
" ===================================================================
" onedark {{{

" [onedark.vim](https://github.com/joshdick/onedark.vim/)

" settings {{{
let s:overrides = get(g:, "onedark_color_overrides", {})

let s:colors = {
      \ "red": get(s:overrides, "red", { "gui": "#E06C75", "cterm": "204", "cterm16": "1" }),
      \ "dark_red": get(s:overrides, "dark_red", { "gui": "#BE5046", "cterm": "196", "cterm16": "9" }),
      \ "green": get(s:overrides, "green", { "gui": "#98C379", "cterm": "114", "cterm16": "2" }),
      \ "yellow": get(s:overrides, "yellow", { "gui": "#E5C07B", "cterm": "180", "cterm16": "3" }),
      \ "dark_yellow": get(s:overrides, "dark_yellow", { "gui": "#D19A66", "cterm": "173", "cterm16": "11" }),
      \ "blue": get(s:overrides, "blue", { "gui": "#61AFEF", "cterm": "39", "cterm16": "4" }),
      \ "purple": get(s:overrides, "purple", { "gui": "#C678DD", "cterm": "170", "cterm16": "5" }),
      \ "cyan": get(s:overrides, "cyan", { "gui": "#56B6C2", "cterm": "38", "cterm16": "6" }),
      \ "white": get(s:overrides, "white", { "gui": "#ABB2BF", "cterm": "145", "cterm16": "15" }),
      \ "black": get(s:overrides, "black", { "gui": "#282C34", "cterm": "235", "cterm16": "0" }),
      \ "foreground": get(s:overrides, "foreground", { "gui": "#ABB2BF", "cterm": "145", "cterm16": "NONE" }),
      \ "background": get(s:overrides, "background", { "gui": "#282C34", "cterm": "235", "cterm16": "NONE" }),
      \ "comment_grey": get(s:overrides, "comment_grey", { "gui": "#5C6370", "cterm": "59", "cterm16": "7" }),
      \ "gutter_fg_grey": get(s:overrides, "gutter_fg_grey", { "gui": "#4B5263", "cterm": "238", "cterm16": "8" }),
      \ "cursor_grey": get(s:overrides, "cursor_grey", { "gui": "#2C323C", "cterm": "236", "cterm16": "0" }),
      \ "status_grey": get(s:overrides, "status_grey", { "gui": "#2C323C", "cterm": "242", "cterm16": "0" }),
      \ "visual_grey": get(s:overrides, "visual_grey", { "gui": "#3E4452", "cterm": "237", "cterm16": "8" }),
      \ "menu_grey": get(s:overrides, "menu_grey", { "gui": "#3E4452", "cterm": "237", "cterm16": "7" }),
      \ "special_grey": get(s:overrides, "special_grey", { "gui": "#3B4048", "cterm": "238", "cterm16": "7" }),
      \ "vertsplit": get(s:overrides, "vertsplit", { "gui": "#3E4452", "cterm": "59", "cterm16": "7" }),
      \}


function! s:onedark_GetColors()
  return s:colors
endfunction

" }}}

" Initialization {{{

"highlight clear

"if exists("syntax_on")
"  syntax reset
"endif

set t_Co=256

let g:colors_name="onedark"

" Set to "256" for 256-color terminals, or
" set to "16" to use your terminal emulator's native colors
" (a 16-color palette for this color scheme is available; see
" < https://github.com/joshdick/onedark.vim/blob/main/README.md >
" for more information.)
if !exists("g:onedark_termcolors")
  let g:onedark_termcolors = 256
endif

" Not all terminals support italics properly. If yours does, opt-in.
if !exists("g:onedark_terminal_italics")
  let g:onedark_terminal_italics = 0
endif

" This function is based on one from FlatColor: https://github.com/MaxSt/FlatColor/
" Which in turn was based on one found in hemisu: https://github.com/noahfrederick/vim-hemisu/
let s:group_colors = {} " Cache of default highlight group settings, for later reference via `onedark#extend_highlight`
function! s:h(group, style, ...)
  if (a:0 > 0) " Will be true if we got here from onedark#extend_highlight
    let s:highlight = s:group_colors[a:group]
    for style_type in ["fg", "bg", "sp"]
      if (has_key(a:style, style_type))
        let l:default_style = (has_key(s:highlight, style_type) ? copy(s:highlight[style_type]) : { "cterm16": "NONE", "cterm": "NONE", "gui": "NONE" })
        let s:highlight[style_type] = extend(l:default_style, a:style[style_type])
      endif
    endfor
    if (has_key(a:style, "gui"))
      let s:highlight.gui = a:style.gui
    endif
    if (has_key(a:style, "cterm"))
      let s:highlight.cterm = a:style.cterm
    endif
  else
    let s:highlight = a:style
    let s:group_colors[a:group] = s:highlight " Cache default highlight group settings
  endif

  if g:onedark_terminal_italics == 0
    if has_key(s:highlight, "cterm") && s:highlight["cterm"] == "italic"
      unlet s:highlight.cterm
    endif
    if has_key(s:highlight, "gui") && s:highlight["gui"] == "italic"
      unlet s:highlight.gui
    endif
  endif

  if g:onedark_termcolors == 16
    let l:ctermfg = (has_key(s:highlight, "fg") ? s:highlight.fg.cterm16 : "NONE")
    let l:ctermbg = (has_key(s:highlight, "bg") ? s:highlight.bg.cterm16 : "NONE")
  else
    let l:ctermfg = (has_key(s:highlight, "fg") ? s:highlight.fg.cterm : "NONE")
    let l:ctermbg = (has_key(s:highlight, "bg") ? s:highlight.bg.cterm : "NONE")
  endif

  execute "highlight" a:group
    \ "guifg="   (has_key(s:highlight, "fg")    ? s:highlight.fg.gui   : "NONE")
    \ "guibg="   (has_key(s:highlight, "bg")    ? s:highlight.bg.gui   : "NONE")
    \ "guisp="   (has_key(s:highlight, "sp")    ? s:highlight.sp.gui   : "NONE")
    \ "gui="     (has_key(s:highlight, "gui")   ? s:highlight.gui      : "NONE")
    \ "ctermfg=" . l:ctermfg
    \ "ctermbg=" . l:ctermbg
    \ "cterm="   (has_key(s:highlight, "cterm") ? s:highlight.cterm    : "NONE")
endfunction


" Color Variables {{{

"let s:colors = onedark#GetColors()
let s:colors = s:onedark_GetColors()

let s:red = s:colors.red
let s:dark_red = s:colors.dark_red
let s:green = s:colors.green
let s:yellow = s:colors.yellow
let s:dark_yellow = s:colors.dark_yellow
let s:blue = s:colors.blue
let s:purple = s:colors.purple
let s:cyan = s:colors.cyan
let s:white = s:colors.white
let s:black = s:colors.black
let s:foreground = s:colors.foreground
let s:background = s:colors.background
let s:comment_grey = s:colors.comment_grey
let s:gutter_fg_grey = s:colors.gutter_fg_grey
let s:cursor_grey = s:colors.cursor_grey
let s:status_grey = s:colors.status_grey
let s:visual_grey = s:colors.visual_grey
let s:menu_grey = s:colors.menu_grey
let s:special_grey = s:colors.special_grey
let s:vertsplit = s:colors.vertsplit

" }}}

" Syntax Groups (descriptions and ordering from `:h w18`) {{{

call s:h("Comment", { "fg": s:comment_grey, "gui": "italic", "cterm": "italic" }) " any comment
call s:h("Constant", { "fg": s:cyan }) " any constant
call s:h("String", { "fg": s:green }) " a string constant: "this is a string"
call s:h("Character", { "fg": s:green }) " a character constant: 'c', '\n'
call s:h("Number", { "fg": s:dark_yellow }) " a number constant: 234, 0xff
call s:h("Boolean", { "fg": s:dark_yellow }) " a boolean constant: TRUE, false
call s:h("Float", { "fg": s:dark_yellow }) " a floating point constant: 2.3e10
call s:h("Identifier", { "fg": s:red }) " any variable name
call s:h("Function", { "fg": s:blue }) " function name (also: methods for classes)
call s:h("Statement", { "fg": s:purple }) " any statement
call s:h("Conditional", { "fg": s:purple }) " if, then, else, endif, switch, etc.
call s:h("Repeat", { "fg": s:purple }) " for, do, while, etc.
call s:h("Label", { "fg": s:purple }) " case, default, etc.
call s:h("Operator", { "fg": s:purple }) " sizeof", "+", "*", etc.
call s:h("Keyword", { "fg": s:purple }) " any other keyword
call s:h("Exception", { "fg": s:purple }) " try, catch, throw
call s:h("PreProc", { "fg": s:yellow }) " generic Preprocessor
call s:h("Include", { "fg": s:blue }) " preprocessor #include
call s:h("Define", { "fg": s:purple }) " preprocessor #define
call s:h("Macro", { "fg": s:purple }) " same as Define
call s:h("PreCondit", { "fg": s:yellow }) " preprocessor #if, #else, #endif, etc.
call s:h("Type", { "fg": s:yellow }) " int, long, char, etc.
call s:h("StorageClass", { "fg": s:yellow }) " static, register, volatile, etc.
call s:h("Structure", { "fg": s:yellow }) " struct, union, enum, etc.
call s:h("Typedef", { "fg": s:yellow }) " A typedef
call s:h("Special", { "fg": s:blue }) " any special symbol
call s:h("SpecialChar", { "fg": s:dark_yellow }) " special character in a constant
call s:h("Tag", {}) " you can use CTRL-] on this
call s:h("Delimiter", {}) " character that needs attention
call s:h("SpecialComment", { "fg": s:comment_grey }) " special things inside a comment
call s:h("Debug", {}) " debugging statements
call s:h("Underlined", { "gui": "underline", "cterm": "underline" }) " text that stands out, HTML links
call s:h("Ignore", {}) " left blank, hidden
call s:h("Error", { "fg": s:red }) " any erroneous construct
call s:h("Todo", { "fg": s:purple }) " anything that needs extra attention; mostly the keywords TODO FIXME and XXX

" }}}

" Highlighting Groups (descriptions and ordering from `:h highlight-groups`) {{{
call s:h("ColorColumn", { "bg": s:cursor_grey }) " used for the columns set with 'colorcolumn'
call s:h("Conceal", {}) " placeholder characters substituted for concealed text (see 'conceallevel')
call s:h("Cursor", { "fg": s:black, "bg": s:blue }) " the character under the cursor
call s:h("CursorIM", {}) " like Cursor, but used when in IME mode
call s:h("CursorColumn", { "bg": s:cursor_grey }) " the screen column that the cursor is in when 'cursorcolumn' is set
if &diff
  " Don't change the background color in diff mode
  call s:h("CursorLine", { "gui": "underline" }) " the screen line that the cursor is in when 'cursorline' is set
else
  call s:h("CursorLine", { "bg": s:cursor_grey }) " the screen line that the cursor is in when 'cursorline' is set
endif
call s:h("Directory", { "fg": s:blue }) " directory names (and other special names in listings)
call s:h("DiffAdd", { "bg": s:green, "fg": s:black }) " diff mode: Added line
call s:h("DiffChange", { "fg": s:yellow, "gui": "underline", "cterm": "underline" }) " diff mode: Changed line
call s:h("DiffDelete", { "bg": s:red, "fg": s:black }) " diff mode: Deleted line
call s:h("DiffText", { "bg": s:yellow, "fg": s:black }) " diff mode: Changed text within a changed line
if get(g:, 'onedark_hide_endofbuffer', 0)
    " If enabled, will style end-of-buffer filler lines (~) to appear to be hidden.
    call s:h("EndOfBuffer", { "fg": s:black }) " filler lines (~) after the last line in the buffer
endif
call s:h("ErrorMsg", { "fg": s:red }) " error messages on the command line
call s:h("VertSplit", { "fg": s:vertsplit }) " the column separating vertically split windows
call s:h("Folded", { "fg": s:comment_grey }) " line used for closed folds
call s:h("FoldColumn", {}) " 'foldcolumn'
call s:h("SignColumn", {}) " column where signs are displayed
call s:h("IncSearch", { "fg": s:yellow, "bg": s:comment_grey }) " 'incsearch' highlighting; also used for the text replaced with ":s///c"
call s:h("LineNr", { "fg": s:gutter_fg_grey }) " Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
call s:h("CursorLineNr", {}) " Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
call s:h("MatchParen", { "fg": s:blue, "gui": "underline", "cterm": "underline" }) " The character under the cursor or just before it, if it is a paired bracket, and its match.
call s:h("ModeMsg", {}) " 'showmode' message (e.g., "-- INSERT --")
call s:h("MoreMsg", {}) " more-prompt
call s:h("NonText", { "fg": s:special_grey }) " '~' and '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line).
call s:h("Normal", { "fg": s:foreground, "bg": s:background }) " normal text
call s:h("Pmenu", { "fg": s:white, "bg": s:menu_grey }) " Popup menu: normal item.
call s:h("PmenuSel", { "fg": s:cursor_grey, "bg": s:blue }) " Popup menu: selected item.
call s:h("PmenuSbar", { "bg": s:cursor_grey }) " Popup menu: scrollbar.
call s:h("PmenuThumb", { "bg": s:white }) " Popup menu: Thumb of the scrollbar.
call s:h("Question", { "fg": s:purple }) " hit-enter prompt and yes/no questions
call s:h("QuickFixLine", { "fg": s:black, "bg": s:yellow }) " Current quickfix item in the quickfix window.
call s:h("Search", { "fg": s:black, "bg": s:yellow }) " Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
call s:h("SpecialKey", { "fg": s:special_grey }) " Meta and special keys listed with ":map", also for text used to show unprintable characters in the text, 'listchars'. Generally: text that is displayed differently from what it really is.
call s:h("SpellBad", { "fg": s:red, "gui": "underline", "cterm": "underline" }) " Word that is not recognized by the spellchecker. This will be combined with the highlighting used otherwise.
call s:h("SpellCap", { "fg": s:dark_yellow }) " Word that should start with a capital. This will be combined with the highlighting used otherwise.
call s:h("SpellLocal", { "fg": s:dark_yellow }) " Word that is recognized by the spellchecker as one that is used in another region. This will be combined with the highlighting used otherwise.
call s:h("SpellRare", { "fg": s:dark_yellow }) " Word that is recognized by the spellchecker as one that is hardly ever used. spell This will be combined with the highlighting used otherwise.
call s:h("StatusLine", { "fg": s:black, "bg": s:status_grey }) " status line of current window
call s:h("StatusLineNC", { "fg": s:comment_grey }) " status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
call s:h("StatusLineTerm", { "fg": s:white, "bg": s:cursor_grey }) " status line of current :terminal window
call s:h("StatusLineTermNC", { "fg": s:comment_grey }) " status line of non-current :terminal window
call s:h("TabLine", { "fg": s:comment_grey }) " tab pages line, not active tab page label
call s:h("TabLineFill", {}) " tab pages line, where there are no labels
call s:h("TabLineSel", { "fg": s:white }) " tab pages line, active tab page label
call s:h("Terminal", { "fg": s:white, "bg": s:black }) " terminal window (see terminal-size-color)
call s:h("Title", { "fg": s:green }) " titles for output from ":set all", ":autocmd" etc.
call s:h("Visual", { "bg": s:visual_grey }) " Visual mode selection
call s:h("VisualNOS", { "bg": s:visual_grey }) " Visual mode selection when vim is "Not Owning the Selection". Only X11 Gui's gui-x11 and xterm-clipboard supports this.
call s:h("WarningMsg", { "fg": s:yellow }) " warning messages
call s:h("WildMenu", { "fg": s:black, "bg": s:blue }) " current match in 'wildmenu' completion

" }}}

" Termdebug highlighting for Vim 8.1+ {{{

" See `:h hl-debugPC` and `:h hl-debugBreakpoint`.
call s:h("debugPC", { "bg": s:special_grey }) " the current position
call s:h("debugBreakpoint", { "fg": s:black, "bg": s:red }) " a breakpoint

" }}}

" Language-Specific Highlighting {{{

" CSS
call s:h("cssAttrComma", { "fg": s:purple })
call s:h("cssAttributeSelector", { "fg": s:green })
call s:h("cssBraces", { "fg": s:white })
call s:h("cssClassName", { "fg": s:dark_yellow })
call s:h("cssClassNameDot", { "fg": s:dark_yellow })
call s:h("cssDefinition", { "fg": s:purple })
call s:h("cssFontAttr", { "fg": s:dark_yellow })
call s:h("cssFontDescriptor", { "fg": s:purple })
call s:h("cssFunctionName", { "fg": s:blue })
call s:h("cssIdentifier", { "fg": s:blue })
call s:h("cssImportant", { "fg": s:purple })
call s:h("cssInclude", { "fg": s:white })
call s:h("cssIncludeKeyword", { "fg": s:purple })
call s:h("cssMediaType", { "fg": s:dark_yellow })
call s:h("cssProp", { "fg": s:white })
call s:h("cssPseudoClassId", { "fg": s:dark_yellow })
call s:h("cssSelectorOp", { "fg": s:purple })
call s:h("cssSelectorOp2", { "fg": s:purple })
call s:h("cssTagName", { "fg": s:red })

" Fish Shell
call s:h("fishKeyword", { "fg": s:purple })
call s:h("fishConditional", { "fg": s:purple })

" Go
call s:h("goDeclaration", { "fg": s:purple })
call s:h("goBuiltins", { "fg": s:cyan })
call s:h("goFunctionCall", { "fg": s:blue })
call s:h("goVarDefs", { "fg": s:red })
call s:h("goVarAssign", { "fg": s:red })
call s:h("goVar", { "fg": s:purple })
call s:h("goConst", { "fg": s:purple })
call s:h("goType", { "fg": s:yellow })
call s:h("goTypeName", { "fg": s:yellow })
call s:h("goDeclType", { "fg": s:cyan })
call s:h("goTypeDecl", { "fg": s:purple })

" HTML (keep consistent with Markdown, below)
call s:h("htmlArg", { "fg": s:dark_yellow })
call s:h("htmlBold", { "fg": s:dark_yellow, "gui": "bold", "cterm": "bold" })
call s:h("htmlBoldItalic", { "fg": s:green, "gui": "bold,italic", "cterm": "bold,italic" })
call s:h("htmlEndTag", { "fg": s:white })
call s:h("htmlH1", { "fg": s:red })
call s:h("htmlH2", { "fg": s:red })
call s:h("htmlH3", { "fg": s:red })
call s:h("htmlH4", { "fg": s:red })
call s:h("htmlH5", { "fg": s:red })
call s:h("htmlH6", { "fg": s:red })
call s:h("htmlItalic", { "fg": s:purple, "gui": "italic", "cterm": "italic" })
call s:h("htmlLink", { "fg": s:cyan, "gui": "underline", "cterm": "underline" })
call s:h("htmlSpecialChar", { "fg": s:dark_yellow })
call s:h("htmlSpecialTagName", { "fg": s:red })
call s:h("htmlTag", { "fg": s:white })
call s:h("htmlTagN", { "fg": s:red })
call s:h("htmlTagName", { "fg": s:red })
call s:h("htmlTitle", { "fg": s:white })

" JavaScript
call s:h("javaScriptBraces", { "fg": s:white })
call s:h("javaScriptFunction", { "fg": s:purple })
call s:h("javaScriptIdentifier", { "fg": s:purple })
call s:h("javaScriptNull", { "fg": s:dark_yellow })
call s:h("javaScriptNumber", { "fg": s:dark_yellow })
call s:h("javaScriptRequire", { "fg": s:cyan })
call s:h("javaScriptReserved", { "fg": s:purple })
" https://github.com/pangloss/vim-javascript
call s:h("jsArrowFunction", { "fg": s:purple })
call s:h("jsClassKeyword", { "fg": s:purple })
call s:h("jsClassMethodType", { "fg": s:purple })
call s:h("jsDocParam", { "fg": s:blue })
call s:h("jsDocTags", { "fg": s:purple })
call s:h("jsExport", { "fg": s:purple })
call s:h("jsExportDefault", { "fg": s:purple })
call s:h("jsExtendsKeyword", { "fg": s:purple })
call s:h("jsFrom", { "fg": s:purple })
call s:h("jsFuncCall", { "fg": s:blue })
call s:h("jsFunction", { "fg": s:purple })
call s:h("jsGenerator", { "fg": s:yellow })
call s:h("jsGlobalObjects", { "fg": s:yellow })
call s:h("jsImport", { "fg": s:purple })
call s:h("jsModuleAs", { "fg": s:purple })
call s:h("jsModuleWords", { "fg": s:purple })
call s:h("jsModules", { "fg": s:purple })
call s:h("jsNull", { "fg": s:dark_yellow })
call s:h("jsOperator", { "fg": s:purple })
call s:h("jsStorageClass", { "fg": s:purple })
call s:h("jsSuper", { "fg": s:red })
call s:h("jsTemplateBraces", { "fg": s:dark_red })
call s:h("jsTemplateVar", { "fg": s:green })
call s:h("jsThis", { "fg": s:red })
call s:h("jsUndefined", { "fg": s:dark_yellow })
" https://github.com/othree/yajs.vim
call s:h("javascriptArrowFunc", { "fg": s:purple })
call s:h("javascriptClassExtends", { "fg": s:purple })
call s:h("javascriptClassKeyword", { "fg": s:purple })
call s:h("javascriptDocNotation", { "fg": s:purple })
call s:h("javascriptDocParamName", { "fg": s:blue })
call s:h("javascriptDocTags", { "fg": s:purple })
call s:h("javascriptEndColons", { "fg": s:white })
call s:h("javascriptExport", { "fg": s:purple })
call s:h("javascriptFuncArg", { "fg": s:white })
call s:h("javascriptFuncKeyword", { "fg": s:purple })
call s:h("javascriptIdentifier", { "fg": s:red })
call s:h("javascriptImport", { "fg": s:purple })
call s:h("javascriptMethodName", { "fg": s:white })
call s:h("javascriptObjectLabel", { "fg": s:white })
call s:h("javascriptOpSymbol", { "fg": s:cyan })
call s:h("javascriptOpSymbols", { "fg": s:cyan })
call s:h("javascriptPropertyName", { "fg": s:green })
call s:h("javascriptTemplateSB", { "fg": s:dark_red })
call s:h("javascriptVariable", { "fg": s:purple })

" JSON
call s:h("jsonCommentError", { "fg": s:white })
call s:h("jsonKeyword", { "fg": s:red })
call s:h("jsonBoolean", { "fg": s:dark_yellow })
call s:h("jsonNumber", { "fg": s:dark_yellow })
call s:h("jsonQuote", { "fg": s:white })
call s:h("jsonMissingCommaError", { "fg": s:red, "gui": "reverse" })
call s:h("jsonNoQuotesError", { "fg": s:red, "gui": "reverse" })
call s:h("jsonNumError", { "fg": s:red, "gui": "reverse" })
call s:h("jsonString", { "fg": s:green })
call s:h("jsonStringSQError", { "fg": s:red, "gui": "reverse" })
call s:h("jsonSemicolonError", { "fg": s:red, "gui": "reverse" })

" LESS
call s:h("lessVariable", { "fg": s:purple })
call s:h("lessAmpersandChar", { "fg": s:white })
call s:h("lessClass", { "fg": s:dark_yellow })

" Markdown (keep consistent with HTML, above)
call s:h("markdownBlockquote", { "fg": s:comment_grey })
call s:h("markdownBold", { "fg": s:dark_yellow, "gui": "bold", "cterm": "bold" })
call s:h("markdownBoldItalic", { "fg": s:green, "gui": "bold,italic", "cterm": "bold,italic" })
call s:h("markdownCode", { "fg": s:green })
call s:h("markdownCodeBlock", { "fg": s:green })
call s:h("markdownCodeDelimiter", { "fg": s:green })
call s:h("markdownH1", { "fg": s:red })
call s:h("markdownH2", { "fg": s:red })
call s:h("markdownH3", { "fg": s:red })
call s:h("markdownH4", { "fg": s:red })
call s:h("markdownH5", { "fg": s:red })
call s:h("markdownH6", { "fg": s:red })
call s:h("markdownHeadingDelimiter", { "fg": s:red })
call s:h("markdownHeadingRule", { "fg": s:comment_grey })
call s:h("markdownId", { "fg": s:purple })
call s:h("markdownIdDeclaration", { "fg": s:blue })
call s:h("markdownIdDelimiter", { "fg": s:purple })
call s:h("markdownItalic", { "fg": s:purple, "gui": "italic", "cterm": "italic" })
call s:h("markdownLinkDelimiter", { "fg": s:purple })
call s:h("markdownLinkText", { "fg": s:blue })
call s:h("markdownListMarker", { "fg": s:red })
call s:h("markdownOrderedListMarker", { "fg": s:red })
call s:h("markdownRule", { "fg": s:comment_grey })
call s:h("markdownUrl", { "fg": s:cyan, "gui": "underline", "cterm": "underline" })

" Perl
call s:h("perlFiledescRead", { "fg": s:green })
call s:h("perlFunction", { "fg": s:purple })
call s:h("perlMatchStartEnd",{ "fg": s:blue })
call s:h("perlMethod", { "fg": s:purple })
call s:h("perlPOD", { "fg": s:comment_grey })
call s:h("perlSharpBang", { "fg": s:comment_grey })
call s:h("perlSpecialString",{ "fg": s:dark_yellow })
call s:h("perlStatementFiledesc", { "fg": s:red })
call s:h("perlStatementFlow",{ "fg": s:red })
call s:h("perlStatementInclude", { "fg": s:purple })
call s:h("perlStatementScalar",{ "fg": s:purple })
call s:h("perlStatementStorage", { "fg": s:purple })
call s:h("perlSubName",{ "fg": s:yellow })
call s:h("perlVarPlain",{ "fg": s:blue })

" PHP
call s:h("phpVarSelector", { "fg": s:red })
call s:h("phpOperator", { "fg": s:white })
call s:h("phpParent", { "fg": s:white })
call s:h("phpMemberSelector", { "fg": s:white })
call s:h("phpType", { "fg": s:purple })
call s:h("phpKeyword", { "fg": s:purple })
call s:h("phpClass", { "fg": s:yellow })
call s:h("phpUseClass", { "fg": s:white })
call s:h("phpUseAlias", { "fg": s:white })
call s:h("phpInclude", { "fg": s:purple })
call s:h("phpClassExtends", { "fg": s:green })
call s:h("phpDocTags", { "fg": s:white })
call s:h("phpFunction", { "fg": s:blue })
call s:h("phpFunctions", { "fg": s:cyan })
call s:h("phpMethodsVar", { "fg": s:dark_yellow })
call s:h("phpMagicConstants", { "fg": s:dark_yellow })
call s:h("phpSuperglobals", { "fg": s:red })
call s:h("phpConstants", { "fg": s:dark_yellow })

" Ruby
call s:h("rubyBlockParameter", { "fg": s:red})
call s:h("rubyBlockParameterList", { "fg": s:red })
call s:h("rubyClass", { "fg": s:purple})
call s:h("rubyConstant", { "fg": s:yellow})
call s:h("rubyControl", { "fg": s:purple })
call s:h("rubyEscape", { "fg": s:red})
call s:h("rubyFunction", { "fg": s:blue})
call s:h("rubyGlobalVariable", { "fg": s:red})
call s:h("rubyInclude", { "fg": s:blue})
call s:h("rubyIncluderubyGlobalVariable", { "fg": s:red})
call s:h("rubyInstanceVariable", { "fg": s:red})
call s:h("rubyInterpolation", { "fg": s:cyan })
call s:h("rubyInterpolationDelimiter", { "fg": s:red })
call s:h("rubyInterpolationDelimiter", { "fg": s:red})
call s:h("rubyRegexp", { "fg": s:cyan})
call s:h("rubyRegexpDelimiter", { "fg": s:cyan})
call s:h("rubyStringDelimiter", { "fg": s:green})
call s:h("rubySymbol", { "fg": s:cyan})

" Sass
" https://github.com/tpope/vim-haml
call s:h("sassAmpersand", { "fg": s:red })
call s:h("sassClass", { "fg": s:dark_yellow })
call s:h("sassControl", { "fg": s:purple })
call s:h("sassExtend", { "fg": s:purple })
call s:h("sassFor", { "fg": s:white })
call s:h("sassFunction", { "fg": s:cyan })
call s:h("sassId", { "fg": s:blue })
call s:h("sassInclude", { "fg": s:purple })
call s:h("sassMedia", { "fg": s:purple })
call s:h("sassMediaOperators", { "fg": s:white })
call s:h("sassMixin", { "fg": s:purple })
call s:h("sassMixinName", { "fg": s:blue })
call s:h("sassMixing", { "fg": s:purple })
call s:h("sassVariable", { "fg": s:purple })
" https://github.com/cakebaker/scss-syntax.vim
call s:h("scssExtend", { "fg": s:purple })
call s:h("scssImport", { "fg": s:purple })
call s:h("scssInclude", { "fg": s:purple })
call s:h("scssMixin", { "fg": s:purple })
call s:h("scssSelectorName", { "fg": s:dark_yellow })
call s:h("scssVariable", { "fg": s:purple })

" TeX
call s:h("texStatement", { "fg": s:purple })
call s:h("texSubscripts", { "fg": s:dark_yellow })
call s:h("texSuperscripts", { "fg": s:dark_yellow })
call s:h("texTodo", { "fg": s:dark_red })
call s:h("texBeginEnd", { "fg": s:purple })
call s:h("texBeginEndName", { "fg": s:blue })
call s:h("texMathMatcher", { "fg": s:blue })
call s:h("texMathDelim", { "fg": s:blue })
call s:h("texDelimiter", { "fg": s:dark_yellow })
call s:h("texSpecialChar", { "fg": s:dark_yellow })
call s:h("texCite", { "fg": s:blue })
call s:h("texRefZone", { "fg": s:blue })

" TypeScript
call s:h("typescriptReserved", { "fg": s:purple })
call s:h("typescriptEndColons", { "fg": s:white })
call s:h("typescriptBraces", { "fg": s:white })

" XML
call s:h("xmlAttrib", { "fg": s:dark_yellow })
call s:h("xmlEndTag", { "fg": s:red })
call s:h("xmlTag", { "fg": s:red })
call s:h("xmlTagName", { "fg": s:red })

" }}}

" Plugin Highlighting {{{

" airblade/vim-gitgutter
call s:h("GitGutterAdd", { "fg": s:green })
call s:h("GitGutterChange", { "fg": s:yellow })
call s:h("GitGutterDelete", { "fg": s:red })

" dense-analysis/ale
call s:h("ALEError", { "fg": s:red, "gui": "underline", "cterm": "underline" })
call s:h("ALEWarning", { "fg": s:yellow, "gui": "underline", "cterm": "underline" })
call s:h("ALEInfo", { "gui": "underline", "cterm": "underline" })
call s:h("ALEErrorSign", { "fg": s:red })
call s:h("ALEWarningSign", { "fg": s:yellow })
call s:h("ALEInfoSign", { })

" easymotion/vim-easymotion
call s:h("EasyMotionTarget", { "fg": s:red, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionTarget2First", { "fg": s:yellow, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionTarget2Second", { "fg": s:dark_yellow, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionShade",  { "fg": s:comment_grey })

" lewis6991/gitsigns.nvim
hi link GitSignsAdd    GitGutterAdd
hi link GitSignsChange GitGutterChange
hi link GitSignsDelete GitGutterDelete

" mhinz/vim-signify
hi link SignifySignAdd    GitGutterAdd
hi link SignifySignChange GitGutterChange
hi link SignifySignDelete GitGutterDelete

" neoclide/coc.nvim
call s:h("CocErrorSign", { "fg": s:red })
call s:h("CocWarningSign", { "fg": s:yellow })
call s:h("CocInfoSign", { "fg": s:blue })
call s:h("CocHintSign", { "fg": s:cyan })
call s:h("CocFadeOut", { "fg": s:comment_grey })
" https://github.com/joshdick/onedark.vim/issues/313
highlight! link CocMenuSel PmenuSel

" neomake/neomake
call s:h("NeomakeErrorSign", { "fg": s:red })
call s:h("NeomakeWarningSign", { "fg": s:yellow })
call s:h("NeomakeInfoSign", { "fg": s:blue })

" plasticboy/vim-markdown (keep consistent with Markdown, above)
call s:h("mkdDelimiter", { "fg": s:purple })
call s:h("mkdHeading", { "fg": s:red })
call s:h("mkdLink", { "fg": s:blue })
call s:h("mkdURL", { "fg": s:cyan, "gui": "underline", "cterm": "underline" })

" prabirshrestha/vim-lsp
call s:h("LspErrorText", { "fg": s:red })
call s:h("LspWarningText", { "fg": s:yellow })
call s:h("LspInformationText", { "fg":s:blue })
call s:h("LspHintText", { "fg":s:cyan })
call s:h("LspErrorHighlight", { "fg": s:red, "gui": "underline", "cterm": "underline" })
call s:h("LspWarningHighlight", { "fg": s:yellow, "gui": "underline", "cterm": "underline" })
call s:h("LspInformationHighlight", { "fg":s:blue, "gui": "underline", "cterm": "underline" })
call s:h("LspHintHighlight", { "fg":s:cyan, "gui": "underline", "cterm": "underline" })

" tpope/vim-fugitive
call s:h("diffAdded", { "fg": s:green })
call s:h("diffRemoved", { "fg": s:red })

" }}}

" Git Highlighting {{{

call s:h("gitcommitComment", { "fg": s:comment_grey })
call s:h("gitcommitUnmerged", { "fg": s:green })
call s:h("gitcommitOnBranch", {})
call s:h("gitcommitBranch", { "fg": s:purple })
call s:h("gitcommitDiscardedType", { "fg": s:red })
call s:h("gitcommitSelectedType", { "fg": s:green })
call s:h("gitcommitHeader", {})
call s:h("gitcommitUntrackedFile", { "fg": s:cyan })
call s:h("gitcommitDiscardedFile", { "fg": s:red })
call s:h("gitcommitSelectedFile", { "fg": s:green })
call s:h("gitcommitUnmergedFile", { "fg": s:yellow })
call s:h("gitcommitFile", {})
call s:h("gitcommitSummary", { "fg": s:white })
call s:h("gitcommitOverflow", { "fg": s:red })
hi link gitcommitNoBranch gitcommitBranch
hi link gitcommitUntracked gitcommitComment
hi link gitcommitDiscarded gitcommitComment
hi link gitcommitSelected gitcommitComment
hi link gitcommitDiscardedArrow gitcommitDiscardedFile
hi link gitcommitSelectedArrow gitcommitSelectedFile
hi link gitcommitUnmergedArrow gitcommitUnmergedFile

" }}}


" Must appear at the end of the file to work around this oddity:
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
"set background=dark

" }}}


" }}}

" }}}

" alse see [https://github.com/serna37/vim/]
