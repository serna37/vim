" vim:set foldmethod=marker:
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
let mapleader = "\<SPACE>"
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
nnoremap <silent><C-n> <Plug>(buf-prev)
nnoremap <silent><C-p> <Plug>(buf-next)
" close buffer
nnoremap <silent><Leader>x <Plug>(buf-close)

" terminal
"nnoremap <silent><Leader>t :bo terminal ++rows=10<CR>
nnoremap <silent><Leader>t :cal popup_create(term_start([&shell],#{hidden:1,term_finish:'close'}),#{border:[],minwidth:&columns*3/4,minheight:&lines*3/4})<CR>
" terminal read only mode (i to return terminal mode)
tnoremap <Esc> <C-w>N

" zen
nnoremap <silent><Leader>z <Plug>(zen-mode)
" }}}

" ##################         MOTION         ################### {{{
" row move
nnoremap j gj
nnoremap k gk
vnoremap <Tab> 5gj
vnoremap <S-Tab> 5gk
nnoremap <silent><Tab> 5j<Plug>(anchor)
nnoremap <silent><S-Tab> 5k<Plug>(anchor)

" comfortable scroll
nnoremap <silent><C-u> <Plug>(scroll-u)
nnoremap <silent><C-d> <Plug>(scroll-d)
nnoremap <silent><C-b> <Plug>(scroll-b)
nnoremap <silent><C-f> <Plug>(scroll-f)

" f-scope toggle
nnoremap <silent><Leader>w <Plug>(f-scope)

" mark
nnoremap <silent>mm <Plug>(mk-toggle)
nnoremap <silent>mp <Plug>(mk-prev)
nnoremap <silent>mn <Plug>(mk-next)
nnoremap <silent>mc <Plug>(mk-clthis)
nnoremap <silent>mx <Plug>(mk-clall)
nnoremap <silent><Leader>m <Plug>(mk-list)
" TODO mark全体リスト
" TODO mi で annotation

" IDE action menu
nnoremap <silent><Leader>v <Plug>(ide-menu)
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
nnoremap <silent>* *N<Plug>(qikhl-toggle)
nnoremap <silent># *N<Plug>(qikhl-toggle)
nnoremap <silent><Leader>q <Plug>(qikhl-clear):noh<CR>

" incremental search
nnoremap <silent>s <Plug>(emotion)
nnoremap <Leader>s /
" TODO wip easymotion incremental search
" TODO ファイル内部全体をfzfにするのもあり

" =====================
" TODO fzf current file test
" TODO 割と良かった
fu! TestFzf()
    cal s:fzsearch.popup(#{list: getline(1, line('$')),
        \ title: 'Current Buffer',
        \ enter_prefix: '>>',
        \ enter_title: 'Choose: <C-n/p> <CR> | ClearText: <C-w>',
        \ func_confirm: 'XXXXcallbak',
        \ func_tab: { -> execute('echom "Tab"') },
        \ })
endf
fu! XXXXcallbak(wid, idx)
     if a:idx == -1 || empty(s:fzsearch.res)
         retu
     endif
     echom s:fzsearch.res[a:idx-1]
endf
" =====================

" grep result -> quickfix
au QuickFixCmdPost *grep* cwindow

" explorer
filetype plugin on
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 70
nnoremap <silent><Leader>e <Plug>(explorer-toggle)

" fzf || fzf-imitation
nnoremap <silent><leader>f <Plug>(smartfzf-fzf)
nnoremap <silent><leader>h <Plug>(smartfzf-his)
nnoremap <silent><leader>b <Plug>(smartfzf-buf)

" ripgrep || grep
nnoremap <silent><Leader>g <Plug>(grep)
" vimgrep current file
nnoremap <silent><Leader><Leader>s <Plug>(grep-current)
" }}}

" ##################         OTHERS         ################### {{{
" basic
scriptencoding utf-8 " this file's charset
set ttyfast " fast terminal connection
set regexpengine=0 " chose regexp engin

" fold
set foldmethod=marker " fold marker
set foldlevel=0 " fold max depth
set foldlevelstart=1 " fold depth on start view
set foldcolumn=1 " fold preview
" }}}
" }}}

" #############################################################
" ##################       FUNCTIONS        ###################
" #############################################################
" {{{
" ##################       ORIGINALS        ################### {{{

" TODO リファクタ順番 dict functions aug Plug その他にしよう
" TODO executeの使い方を直そう

" TODO echo色をこれ使うように統一
" color echo/echon, input {{{
au ColorScheme * hi DarkRed ctermfg=204
au ColorScheme * hi DarkOrange ctermfg=180
au ColorScheme * hi DarkBlue ctermfg=39

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
" }}}

" tab 5row anchor {{{
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

let s:anchor = s:anchor.set
noremap <Plug>(anchor) :<C-u>cal <SID>anchor()<CR>
" }}}

" switch fzf {{{
" no plugin -> call imitated fzf
" plugin coc.nvim enable -> switch ProjectFiles / Files
" plugin coc.nvim enable -> switch ProjectFiles / imitated fzf
" TODO Filesをimitationに置き換えたいね！
" TODO fzf mode フラグ管理変えるfz->fzf
fu! s:smartFzf(mode) abort
    if !exists(':Coc')
        retu s:fzf.exe(a:mode)
    endif
    let pwd = getcwd()
    cal expand('%:h')->chdir()
    let gitroot = system('git rev-parse --show-superproject-working-tree --show-toplevel')
      cal chdir(pwd)
    execute(!v:shell_error ? 'CocCommand fzf-preview.ProjectFiles' : 'Files')
endf

" TODO fzfの検索候補はもう1ページのみにして、hisからls除いたやつ + ls + fzf にするか
" それとも、検索前から選択肢が少ない方が精神的に良いか？
" 上の方にls結果が出てるなら、lsのみの代用になるのでは？
" キーをわざわざfhb選ぶより、脳死でfってできるほうがいいんか？
noremap <Plug>(smartfzf-fzf) :<C-u>cal <SID>smartFzf('fz')<CR>
noremap <Plug>(smartfzf-his) :<C-u>cal <SID>smartFzf('his')<CR>
noremap <Plug>(smartfzf-buf) :<C-u>cal <SID>smartFzf('buf')<CR>
" }}}

" grep {{{
fu! s:grep() abort
    " plugin mode
    " TODO いらんかも... 通常grepつよいぜ
"    if exists(':Coc') && executable('rg')
"        let w = InputI('ripgrep [word] >>', expand('<cword>'))
"        cal EchoI('<<', 0)
"        if empty(w)
"            cal EchoE('cancel')
"            retu
"        endif
"        execute('CocCommand fzf-preview.ProjectGrep -w --ignore-case '.w)
"        retu
"    endif
    " no plugin
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

    let target = InputW('[target] TabCompletion>>', './*', 'file')
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
    cal EchoW(' target['.target.']')
    echon ' ...'
    echo ''
    cgetexpr system('grep -rin --include="*.'.ext.'" "'.word.'" '.target)
    cw
    cal EchoI('grep complete!')
endf

" TODO 結果ないとき無言、なんか知らせたいね
noremap <Plug>(grep) :<C-u>cal <SID>grep()<CR>
" }}}

" grep from current file {{{
fu! s:grepCurrent() abort
" TODO 結果ないときエラー
    cal EchoI('grep from this file. (empty to cancel)')
    let word = InputI('[word]>>', expand('<cword>'))
    cal EchoI('<<', 0)
    if empty(word)
        cal EchoE('cancel')
        retu
    endif
    cal EchoW(printf('grep word[%s] processing in [%s] ...', word, expand('%:t')))
    exe 'vimgrep /'.word.'/gj %'
    cw
    cal EchoI('grep complete!')
endf

noremap <Plug>(grep-current) :<C-u>cal <SID>grepCurrent()<CR>
" }}}

" IDE menu {{{
let s:idemenu = #{
    \ menuid: 0, menutitle: ' IDE MENU (j / k) Enter choose | * require plugin ',
    \ menu: [
        \ '[Format]         applay format for this file',
        \ '[ReName*]        rename current word recursively',
        \ '[ALL PUSH]       commit & push all changes',
        \ '[QuickFix-Grep*] Open Preview Popup from quickfix - from fzfpreview Ctrl+Q',
        \ '[Snippet*]       edit snippets',
        \ '[Run*]           run current program',
        \ '[Debug*]         debug current program',
        \ '[Run as Shell]   run current row as shell command',
        \ '[Color random]   change colorscheme at random',
    \ ],
    \ menupos_red1: [[1,1,17],[2,1,17],[3,1,17],[4,1,17],[5,1,17],[6,1,17]],
    \ menupos_red2: [[7,1,17],[8,1,17],[9,1,17]],
    \ cheatid: 0, cheattitle: ' LSP KeyMaps ',
    \ cheat: [
        \ ' (Space d) [Definition]     Go to Definition ',
        \ ' (Space r) [Reference]      Reference ',
        \ ' (Space o) [Outline]        view outline on popup ',
        \ ' (Space ?) [Document]       show document on popup scroll C-f/b ',
        \ ' (Space ,) [Next Diagnosis] jump next diagnosis ',
        \ ' (Space .) [Prev Diagnosis] jump prev diagnosis ',
    \ ],
    \ cheatpos_red: [[1,1,28],[2,1,28],[3,1,28],[4,1,28],[5,1,28],[6,1,28]],
    \ cheatpos_blue: [[1,1,10],[2,1,10],[3,1,10],[4,1,10],[5,1,10],[6,1,10]],
    \ colors: ['torte', 'elflord', 'pablo'],
    \ colors_plug: ['onedark', 'hybrid_material', 'molokai']
    \ }

" TODO OneDark statuslineでの緑をidemenuで使ってる
fu! s:idemenu.open() abort
    let self.menuid = popup_menu(self.menu, #{title: self.menutitle,
        \ border: [], borderchars: ['─','│','─','│','╭','╮','╯','╰'],
        \ filter: function(self.choose, [{'idx': 0, 'files': self.menu }])})
    cal setwinvar(self.menuid, '&wincolor', 'OneDarkGreenChar')
    cal matchaddpos('DarkRed', self.menupos_red1, 16, -1, #{window: self.menuid})
    cal matchaddpos('DarkRed', self.menupos_red2, 16, -1, #{window: self.menuid})
    let self.cheatid = popup_create(self.cheat, #{title: self.cheattitle, line: &columns/4})
    cal setwinvar(self.cheatid, '&wincolor', 'OneDarkGreenChar')
    cal matchaddpos('DarkRed', self.cheatpos_red, 16, -1, #{window: self.cheatid})
    cal matchaddpos('DarkBlue', self.cheatpos_blue, 16, -1, #{window: self.cheatid})
endf

" TODO callbackを使えばindex管理をしなくて良い
" TODO ここから下、パイプなくすとこから
fu! s:idemenu.choose(ctx, winid, key) abort
    if a:key is# 'j' && a:ctx.idx < len(a:ctx.files)-1
        let a:ctx.idx += 1
    elseif a:key is# 'k' && a:ctx.idx > 0
        let a:ctx.idx -= 1
    elseif a:key is# "\<Esc>" || a:key is# "\<Space>"
        cal popup_close(self.cheatid)
    elseif a:key is# "\<CR>"
        if !self.exe(a:ctx.idx)
            cal popup_close(self.cheatid)
        else
            retu 1
        endif
    endif
    retu popup_filter_menu(a:winid, a:key)
endf

" return err flg
fu! s:idemenu.exe(idx) abort
    if a:idx == 0
        if exists(':Coc')
            cal CocActionAsync('format')
        else
            execute('norm gg=G'.line('.').'G')
        endif
    elseif a:idx == 1
        if exists(':Coc')
            cal CocActionAsync('rename')
        else
            cal EchoE('Sorry, [ReName*] needs coc.nvim.')
            retu 1
        endif
    elseif a:idx == 2
        let w = EchoI('commit message>>')
        if empty(w)
            cal EchoE('cancel')
            retu 1
        endif
        exe 'top terminal ++rows=10 ++shell git add .&&git commit -m "'.w.'"&&git push'
    elseif a:idx == 3
        if exists(':CocCommand')
            exe 'CocCommand fzf-preview.QuickFix'
        else
            " TODO getqflist() 結果をfzsearch使えばいけるぞ"
            cal EchoE('Sorry, [QuickFix-Grep*] needs coc.nvim.')
            retu 1
        endif
    elseif a:idx == 4
        if exists(':CocCommand')
            exe 'CocCommand snippets.editSnippets'
        else
            cal EchoE('Sorry, [Snippet*] needs coc.nvim.')
            retu 1
        endif
    elseif a:idx == 5
        " TODO quickrun 再現予定
        if exists(':QuickRun')
            exe 'QuickRun -hook/time/enable 1'
        else
            cal EchoE('Sorry, [Run*] needs vim-quickrun.')
            retu 1
        endif
    elseif a:idx == 6
        if exists(':Vimspector')
            cal vimspector#Launch()
        else
            cal EchoE('Sorry, [Debug*] needs vimspector.')
            retu 1
        endif
    elseif a:idx == 7
        exe 'top terminal ++rows=10 ++shell eval '.getline('.')
    elseif a:idx == 8
        let self.tobecolor = glob('~/.vim/colors') != '' ? self.colors_plug[localtime() % len(self.colors_plug)] : self.colors[localtime() % len(self.colors)]
        exe 'echo "change [".execute("colorscheme")[1:]."] -> [".self.tobecolor."]"'
        cal timer_start(500, { -> execute('colorscheme '.self.tobecolor) })
     " TODO runcatいれる？
    endif
    retu 0
endf

let s:idemenuopen = s:idemenu.open
noremap <Plug>(ide-menu) :<C-u>cal <SID>idemenuopen()<CR>
" }}}

" running cat (loading animation) {{{
" TODO runcat delay もっと緩急
let s:runcat = #{frame: 0, winid: 0, tid: 0, delay: 300}
fu! s:runcat.animation(_) abort
    cal setbufline(winbufnr(self.winid), 1, self.cat[self.frame])
    let self.frame = self.frame == 4 ? 0 : self.frame + 1
    let self.tid = timer_start(self.delay, self.animation)
endf
fu! s:runcat.stop() abort
    cal popup_close(self.winid)
    cal timer_stop(self.tid)
endf
fu! s:runcat.start(...) abort
    cal self.stop()
    " TODO run cat animation maskいじくりたい
    " TODO OneDarkGreenChar statuslineでの color
    let self.winid = popup_create(self.cat[0], #{line: 1, border: [0,0,0,0], mask: [[1,-1,1,1]], zindex: 1})
    cal setwinvar(self.winid, '&wincolor', 'OneDarkGreenChar')
    ""cal matchaddpos('DarkRed', self.cheatpos_red, 16, -1, #{window: self.cheatid})
    ""cal matchaddpos('DarkBlue', self.cheatpos_blue, 16, -1, #{window: self.cheatid})
    if a:0
        let self.delay = 500-(a:1-1)*100
    endif
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

" TODO cheat sheet startifyのあとでリファクタ
" IDE menuにある程度キーマップ入れても良いかもね
" PlugInstallとか、使わんものはコマンド
" 通常vim操作は書かない
" その他の割り当ててる関数とかをまとめる
" ただのキーマップで住んでるものは書かない
" INSERT C-h とかはかかんで良い
" Tabもいらん
" ページ切り替えとかもいらん、その辺はstartifyに書く
" window系もいらん
"
" IDE menuで書くもの -> いや多いな,,, 整理しよう
" emotion
" emotion search
" current grep
" full grep
" fzf his buffer
" explorer line jumped changed
" mark
" ハイライト消す
" visualでのブロック移動
"

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

" TODO startifyとかにあわせ、いろいろ変える
nnoremap <silent><Leader><Leader><Leader> :cal <SID>PopupFever()<CR>:cal <SID>ToggleCheatHover()<CR>
let s:show_cheat_sheet_flg = 0
fu! s:CheatAlert(tid)
    execute("echohl WarningMsg | echo '[INFO] Space * 3 to enable cheat sheet !!' | echohl None")
endf
if has('vim_starting')
    cal timer_start(200, function("s:CheatAlert"))
endif
let s:recheatwinid = 0
fu! s:PopupFever()
    cal s:runcat.start()
    let s:recheatwinid = popup_create(s:my_vim_cheet_sheet, #{ title: ' Action Cheet Sheet ', border: [], line: &columns/4 })
    let s:logowinid = popup_create(g:btr_logo, #{ border: [] })
endf
fu! s:PopupFeverStop()
    cal s:runcat.stop()
    cal popup_close(s:recheatwinid )
    cal popup_close(s:logowinid)
endf
fu! s:ToggleCheatHover()
    let msg = 'Disable Cheat Sheet Hover'
    if s:show_cheat_sheet_flg == 1
        let s:show_cheat_sheet_flg = 0
    else
        let msg = 'Enable Cheat Sheet Hover'
        let s:show_cheat_sheet_flg = 1
    endif
    let s:checkwinid = popup_notification(msg, #{ border: [], line: &columns/4-&columns/37, close: "button" })
    cal timer_start(3000, { -> s:PopupFeverStop()})
endf

" }}}

" TODO リファクタ
" completion {{{

" TODO ~の後ろで正規表現やりに行っちゃう。=は大丈夫
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

" TODO <BS>のあとに補完だしたくない
if glob('~/.vim/pack/plugins/start/coc.nvim') == ''
    au TextChangedI,TextChangedP * cal s:completion.exe()
    au CompleteDone * cal s:completion.done()
endif
" }}}

" }}}

" ##################       IMITATIONS       ################### {{{

" ===================================================================
" junegunn/fzf.vim
" ===================================================================
" {{{
" usage
" let arguments_def = #{
"     \ list: search targets as List,
"     \ title: choose popup title as String,
"     \ enter_prefix: enter zone prefix text as String,
"     \ enter_title: enter zone title as String,
"     \ func_confirm: confirm function name as String,
"     TODO fzsearch tab mode change
"     \ func_tab: { -> execute('echom "Tab"') },
"     \ }
" and call like this.
" cal s:fzsearch.popup(arguments_def)
"
" callback function sample
" fu! s:simple_echo(wid, idx)
"     if a:idx == -1 || empty(s:fzsearch.res)
"         retu
"     endif
"     echom s:fzsearch.res[a:idx-1]
" endf

let s:fzsearch = #{ewid: 0, rwid: 0, res: [], tid: 0}

fu! s:fzsearch.popup(v) abort
    ""let self.max = &lines/2-1
    let self.max = 100
    let self.pr = a:v.enter_prefix
    let self.res = a:v.list[0:self.max]

    " TODO fzf fzsearch util popup border font color ...
    " TODO fzf preview window catで作る、syntax highlightも
    let fff = system('cat README.md')->split('\n') " 本当はファイルフルパス
    " TODO fzf preview いけそうww
    " TODO キーに応じてzindex変えながらスクロールで複数行下に。
    let aa = popup_menu(fff, #{title: a:v.title,
        \ zindex: 98, mapping: 0, scrollbar: 1,
        \ border: [], borderchars: ['─','│','─','│','╭','╮','╯','╰'],
        \ minwidth: &columns/3, maxwidth: &columns/3,
        \ minheight: &lines/2, maxheight: &lines/2,
        \ filter: function(self.pv, [0])
        \ })
    call setbufvar(winbufnr(aa), '&filetype', 'markdown')


    let self.rwid = popup_menu(self.res, #{title: a:v.title,
        \ zindex: 99, mapping: 0, scrollbar: 1,
        \ border: [], borderchars: ['─','│','─','│','╭','╮','╯','╰'],
        \ minwidth: &columns/2, maxwidth: &columns/2,
        \ minheight: &lines/2, maxheight: &lines/2,
        \ callback: a:v.func_confirm,
        \ filter: function(self.jk, [0])
        \ })

    " TODO fzf tabだと選択、C-qでquickfixlistに、だけど モード切り替えどうするか
    " TODO fzf tab選択時の描画どうする？
    " TODO fzf 選択解除めんどいなぁ
    " TODO fzf 全量いっきにquickfixじゃだめか
    " TODO fzf tab選択機能つけるならC-a欲しい
    let self.ewid = popup_create(a:v.enter_prefix, #{title: a:v.enter_title,
        \ zindex: 100, mapping: 0,
        \ border: [], borderchars: ['─','│','─','│','╭','╮','╯','╰'],
        \ minwidth: &columns/2, maxwidth: &columns/2,
        \ minheight: 1, maxheight: 1, line: &lines*3/4+2,
        \ filter: function(self.fil, [#{lst: a:v.list, wd: [], ft: a:v.func_tab}]),
        \ })
endf

fu! s:fzsearch.pv(_, wid, key) abort
    if a:key is# "\<Esc>"
        ""cal feedkeys("\<C-c>")
        ""cal feedkeys("\<C-c>")
    elseif a:key is# "\<C-d>"
        cal self.scroll(1)
        retu 1
    elseif a:key is# "\<C-u>"
        cal self.scroll(0)
        retu 1
    endif
    retu popup_filter_menu(a:wid, a:key)
endf

fu! s:fzsearch.scroll(vector) abort
    if self.tid
        retu
    endif
    cal timer_stop(self.tid)
    let vec = a:vector ? "\<C-n>" : "\<C-p>"
    let self.tid = timer_start(10, { -> feedkeys(vec) }, #{repeat: -1})
    cal timer_start(600, self.scstop)
endf

fu! s:fzsearch.scstop(_) abort
    cal timer_stop(self.tid)
    let self.tid = 0
endf


fu! s:fzsearch.jk(_, wid, key) abort
    if a:key is# "\<Esc>"
        cal feedkeys("\<C-c>")
        cal feedkeys("\<C-c>")
    elseif a:key is# "\<C-n>" || a:key is# "\<C-p>"
        retu popup_filter_menu(a:wid, a:key)
    elseif a:key is# "\<CR>"
        cal popup_close(self.ewid)
        retu popup_filter_menu(a:wid, a:key)
    else
        cal popup_setoptions(a:wid, #{zindex: 99})
        cal popup_setoptions(self.ewid, #{zindex: 100})
        cal feedkeys(a:key)
    endif
    retu 1
endf

fu! s:fzsearch.fil(ctx, wid, key) abort
    if a:key is# "\<Esc>"
        cal feedkeys("\<C-c>")
        cal feedkeys("\<C-c>")
        retu 1
    elseif a:key is# "\<C-n>" || a:key is# "\<C-p>" || a:key is# "\<CR>"
        cal popup_setoptions(a:wid, #{zindex: 99})
        cal popup_setoptions(self.rwid, #{zindex: 100})
        cal feedkeys(a:key)
        retu 1
    elseif a:key is# "\<Tab>"
        " TODO うけつけねぇ
        cal a:ctx.ft()
        " TODO 文字列で関数名を入力さておき、ここではfunctionとかで実行しよう
        " たぶんfuncredが悪い"
        echom 'asdasdasdas'
        retu 1
    " TODO fzf copy shold D-v only or Shift Insert. C-v want split
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

    let wd = join(a:ctx.wd, '')
    let filterd = empty(wd) ? a:ctx.lst : matchfuzzy(a:ctx.lst, wd)
    let self.res = filterd[0:self.max]
    cal setbufline(winbufnr(a:wid), 1, self.pr.wd)
    cal deletebufline(winbufnr(self.rwid), 1, self.max)
    cal setbufline(winbufnr(self.rwid), 1, self.res)
    retu a:key is# "x" || a:key is# "\<Space>" ? 1 : popup_filter_menu(a:wid, a:key)
endf
" }}}

" ===================================================================
" jiangmiao/auto-pairs
" ===================================================================
" TODO リファクタ
" {{{
fu! AutoPairsDelete()
    let pairs_start = ["(", "[", "{", "<", "'", '"', "`"]
    let pairs_end = [")", "]", "}", ">", "'", '"', "`"]
    let pre_cursor_char = getline('.')[col('.')-2]
    let on_cursor_char = getline('.')[col('.')-1]
    let pre_chk = match(pairs_start, pre_cursor_char)
    let on_chk = match(pairs_end, on_cursor_char)
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
" TODO ~の後ろで正規表現やりに行っちゃう。=は大丈夫
inoremap <silent><expr><BS> AutoPairsDelete()
""inoremap <silent><BS> <C-r>=AutoPairsDelete()

" TODO 直前に押したキーが(なら、()と入力しても良いってしたい
" }}}

" ===================================================================
" preservim/nerdtree
" ===================================================================
" TODO リファクタ
" {{{

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
    nnoremap <buffer><CR> <Plug>NetrwLocalBrowseCheck
    if getline('.')[len(getline('.'))-1] != '/'
        nnoremap <buffer><CR> <Plug>NetrwLocalBrowseCheck:cal NetrwOpen()<CR>
    endif
endf

" TODO mapじゃなくしたいね
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
noremap <Plug>(explorer-toggle) :<C-u>cal <SID>NetrwToggle()<CR>


" }}}

" ===================================================================
" vim-airline/vim-airline
" ===================================================================
" TODO リファクタ
" {{{

" status line with git info
let g:right_arrow = ''
let g:left_arrow = ''
let powerline_chk_mac = trim(system('fc-list | grep powerline | wc -l'))
let powerline_chk_win = trim(system('cd /C/Windows/Fonts&&ls | grep powerline | wc -l'))
if !powerline_chk_mac+0 && !powerline_chk_win+0
    let g:right_arrow = '▶︎'
    let g:left_arrow = '◀︎'
endif
let g:modes = {'i': ['#OneDarkBule#', '#OneDarkBlueChar#', 'INSERT'], 'n': ['#OneDarkGreen#', '#OneDarkGreenChar#', 'NORMAL'], 'R': ['#OneDarkRed#', '#OneDarkRedChar#', 'REPLACE'], 'c': ['#OneDarkGreen#', '#OneDarkGreenChar#', 'COMMAND'], 't': ['#OneDarkRed#', '#OneDarkRedChar#', 'TERMIAL'], 'v': ['#OneDarkPink#', '#OneDarkPinkChar#', 'VISUAL'], 'V': ['#OneDarkPink#', '#OneDarkPinkChar#', 'VISUAL'], "\<C-v>": ['#OneDarkPink#', '#OneDarkPinkChar#', 'VISUAL']}

let g:ff_table = {'dos' : 'CRLF', 'unix' : 'LF', 'mac' : 'CR'}
let g:gitinf = 'no git '
fu! s:gitinfo() abort
    try
        cal system('git status')
    catch
        retu
    endtry
    if trim(system('cd '.expand('%:h').' && git status')) =~ "^fatal:"
        let g:gitinf = 'no repo '
        retu
    endif
    " TODO gitstatus結果を使いまわした方が早い？
    " TODO
    " いまどのwindow みてるか分かりにくい、forcus window のstatus colorを抑えたい
    let cmd = "cd ".expand('%:h')." && git status --short | awk -F ' ' '{print($1)}' | grep -c "
    let a = trim(system(cmd."'A'"))
    let aa = a !='0'?'+'.a :''
    let m = trim(system(cmd."-e 'M' -e 'D'"))
    let mm = m !='0'?'!'.m :''
    let nw = trim(system(cmd."'??'"))
    let nwnw = nw !='0'?'?'.nw :''
    let er = trim(system(cmd."'U'"))
    let ee = er !='0'?'✗'.er :''
    let g:gitinf = trim(system("cd ".expand('%:h')."&&git branch | awk -F '*' '{print($2)}'")).join([aa,mm,nwnw,ee],' ')
endf

" TODO onedark系ハイライトを1箇所にまとめたいね -> どこで使う予定かリストアップ
" TODO airline, popup
" TODO onedarkカラースキームimitationとは別のはず。
aug statusLine
    au!
    au BufWinEnter,BufWritePost * cal s:gitinfo()
    au ColorScheme * hi OneDarkGreen cterm=bold ctermfg=235 ctermbg=114
    au ColorScheme * hi OneDarkGreenChar ctermfg=114 ctermbg=235
    au ColorScheme * hi OneDarkBule cterm=bold ctermfg=235 ctermbg=39
    au ColorScheme * hi OneDarkBlueChar ctermfg=39 ctermbg=235
    au ColorScheme * hi OneDarkPink cterm=bold ctermfg=235 ctermbg=170
    au ColorScheme * hi OneDarkPinkChar ctermfg=170 ctermbg=235
    au ColorScheme * hi OneDarkRed cterm=bold ctermfg=235 ctermbg=204
    au ColorScheme * hi OneDarkRedChar ctermfg=204 ctermbg=235
    au ColorScheme * hi OneDarkBlackArrow ctermfg=235 ctermbg=238
    au ColorScheme * hi OneDarkChar ctermfg=114 ctermbg=238
    au ColorScheme * hi OneDarkGrayArrow ctermfg=238 ctermbg=235
    au ColorScheme * hi StatusLine ctermfg=114 ctermbg=238
aug END

fu! g:SetStatusLine() abort
    let filetype_tmp = split(execute('set filetype?'), '=')
    let filetype = len(filetype_tmp) >= 2 ? filetype_tmp[1] : ''
    let mode = match(keys(g:modes), mode()) != -1 ? g:modes[mode()] : ['#OneDarkRed#', '#OneDarkRedChar#', 'SP']
    retu '%'.mode[0].' '.mode[2].' '.'%'.mode[1].g:right_arrow.'%#OneDarkBlackArrow#'.g:right_arrow.'%#OneDarkChar# %<%f%m%r%h%w %#OneDarkGrayArrow#'.g:right_arrow.'%#OneDarkGreenChar# %{g:gitinf}%#OneDarkBlackArrow#'.g:right_arrow.'%#StatusLine# %=%#OneDarkBlackArrow#'.g:left_arrow.'%#OneDarkGreenChar# '.filetype.' %#OneDarkGrayArrow#'.g:left_arrow.'%#OneDarkChar# %p%% %l/%L %02v%#OneDarkBlackArrow#'.g:left_arrow.'%'.mode[1].g:left_arrow.'%'.mode[0].' [%{&fenc!=""?&fenc:&enc}][%{g:ff_table[&ff]}] %*'
endf
set stl=%!g:SetStatusLine()

" tabline
aug tabLine
    au ColorScheme * hi OneDarkGreenThin ctermfg=235 ctermbg=114
    au ColorScheme * hi OneDarkBlueThin ctermfg=235 ctermbg=39
    au ColorScheme * hi OneDarkGreenArrowBottom ctermfg=235 ctermbg=114
    au ColorScheme * hi TabLineFill ctermfg=235 ctermbg=238
aug END
fu! s:buffers_label() abort
    let b = ''
    for v in split(execute('ls'), '\n')->map({ _,v -> split(v, ' ')})
        let x = copy(v)->filter({ _,v -> !empty(v) })
        if stridx(x[1], 'F') == -1 && stridx(x[1], 'R') == -1
            let hi = stridx(x[1], '%') != -1 ? '%#OneDarkGreenThin#' : '%#OneDarkChar#'
            let hiar = stridx(x[1], '%') != -1 ? '%#OneDarkGreenChar#' : '%#OneDarkGrayArrow#'
            let hiarb = stridx(x[1], '%') != -1 ? '%#OneDarkGreenArrowBottom#' : '%#OneDarkBlackArrow#'
            if x[2] == '+'
                let hi = '%#OneDarkBlueThin#'
                let hiar = '%#OneDarkBlueChar#'
                let hiarb = '%#OneDarkBlueThin#'
            endif
"[^/]*$
            let f = x[2] == '+' ? '✗'.matchstr(join(split(x[3],'"'),''),'[^/]*$') : matchstr(join(split(x[2],'"'),''),'[^/]*$')
            let b = b.'%'.x[0].'T'.hiarb.g:right_arrow.hi.f.hiar.g:right_arrow
        endif
    endfor
    retu b
endf
fu! s:tabpage_label(n) abort
    let hi = a:n is tabpagenr() ? '%#OneDarkGreenThin#' : '%#OneDarkChar#'
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

noremap <Plug>(buf-prev) :<C-u>cal <SID>moveBuf('prev')<CR>
noremap <Plug>(buf-next) :<C-u>cal <SID>moveBuf('next')<CR>
noremap <Plug>(buf-close) :<C-u>cal <SID>closeBuf()<CR>
" }}}

" ===================================================================
" yuttie/comfortable-motion.vim
" ===================================================================
" {{{
" while scroll, deactivate f-scope
let s:scroll = #{tid: 0, curL: '', curC: '', till: 600}

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

let s:scroll = s:scroll.exe
noremap <Plug>(scroll-d) :<C-u>cal <SID>scroll(1, 30)<CR>
noremap <Plug>(scroll-u) :<C-u>cal <SID>scroll(0, 30)<CR>
noremap <Plug>(scroll-f) :<C-u>cal <SID>scroll(1, 10)<CR>
noremap <Plug>(scroll-b) :<C-u>cal <SID>scroll(0, 10)<CR>

fu! Scroll(vec, del) abort " for coc
    cal s:scroll(a:vec, a:del)
    retu "\<Ignore>"
endf
" }}}

" ===================================================================
" junegunn/fzf
" ===================================================================
" TODO リファクタ
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

" TODO modeの管理下手なので直そうな
fu! s:fzf.exe(fz) abort " open window
    if stridx(execute('pwd')[1:], s:fzf.searched) == -1 || empty(s:fzf.chache)
        cal s:fzf.refind()
    endif
    let s:fzf.start_fz = a:fz
    let s:fzf.mode = s:fzf.start_fz == 'fz' ? 'fzf' : 'his'
    let aaaaaaaaaaaaaaaaaa = substitute(getcwd(), $HOME, '~', 'g')
    let s:fzf.mode_title = s:fzf.mode == 'his' ? '(*^-^)/ BUF & MRU' : '(*"@w@)/ FZF ['.(empty(matchstr(s:fzf.searched, '[^'.$HOME.'].*$')) ? s:fzf.searched : '~/'.matchstr(s:fzf.searched, '[^'.$HOME.'].*$')).']'
    let pwd = execute('pwd')[1:]
    let s:fzf.pwd_prefix = 'pwd:['.(empty(matchstr(pwd, '[^'.$HOME.'].*$')) ? pwd : '~/'.matchstr(pwd, '[^'.$HOME.'].*$')).']>>'
    let s:fzf.enter_keyword = []
    let s:fzf.his_result = split(execute('ls'), '\n')->map({ _,v -> split(v, '"')[1] })->filter({ _,v -> v != '[No Name]' && v != '[無名]' })
     \+split(execute('oldfiles'), '\n')->map({ _,v -> split(v, ': ')[1] })
    let s:fzf.filterd = s:fzf.mode == 'his' ? s:fzf.his_result[0:29] : s:fzf.chache[0:29]
    let s:fzf.winid_enter = popup_create(s:fzf.pwd_prefix, #{title: 'MRU<>FZF:<Tab>/choose:<CR>/end:<Esc>/chache refresh:<C-f>',    border: [], zindex: 99, minwidth: &columns/2, maxwidth: &columns/2, maxheight: 1, line: &columns/4-&columns/36, mapping: 0, filter: s:fzf.refresh_result})
    cal s:fzf.open_result_win()
endf
fu! s:fzf.open_result_win() abort
    let s:fzf.cidx = 0
    let s:fzf.winid_result = popup_menu(s:fzf.filterd, #{title: s:fzf.mode_title, border: [], zindex: 98, minwidth: &columns/2, maxwidth: &columns/2, minheight: 2, maxheight: &lines/2, filter: s:fzf.choose})
endf

fu! s:fzf.refind() abort " async find command
    cal s:runcat.start()
    let s:fzf.chache = []
    let s:fzf.searched = execute('pwd')[1:]
    cal EchoW('find files in ['.s:fzf.searched.'] and chache ...')
    cal job_start(s:fzf.find_cmd, #{out_cb: s:fzf.find_start, close_cb: s:fzf.find_end})
endf
fu! s:fzf.find_start(ch, msg) abort
    cal add(s:fzf.chache, a:msg)
endf
fu! s:fzf.find_end(ch) abort
    cal EchoI('find files in ['.s:fzf.searched.'] and chache is complete!!')
    cal s:runcat.stop()
    " after init, see fzf if specified
    " TODO fzf find mode ... 
    if s:fzf.start_fz == 'fz' && s:fzf.mode == 'his'
        cal win_execute(s:fzf.winid_enter, 'cal feedkeys("\<Tab>")')
    elseif s:fzf.start_fz == 'fz' && s:fzf.mode == 'fzf'
        cal win_execute(s:fzf.winid_enter, 'cal feedkeys("\<Tab>\<Tab>")')
    endif
endf

fu! s:fzf.refresh_result(winid, key) abort " event to draw search result
    if a:key is# "\<Esc>"
        cal popup_close(s:fzf.winid_enter)
        cal popup_close(s:fzf.winid_result)
        retu 1
    elseif a:key is# "\<CR>"
        cal popup_close(s:fzf.winid_enter)
        retu 1
    elseif a:key is# "\<C-f>"
        cal s:fzf.refind()
    elseif a:key is# "\<C-v>"
        for i in range(0,strlen(@")-1)
            cal add(s:fzf.enter_keyword, strpart(@",i,1))
        endfor
    elseif a:key is# "\<Tab>"
        let s:fzf.mode = s:fzf.mode == 'his' ? 'fzf' : 'his'
    let s:fzf.mode_title = s:fzf.mode == 'his' ? '(*^-^)/ BUF & MRU' : '(*"@w@)/ FZF ['.(empty(matchstr(s:fzf.searched, '[^'.$HOME.'].*$')) ? s:fzf.searched : '~/'.matchstr(s:fzf.searched, '[^'.$HOME.'].*$')).']'
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
    if a:key is# 'j'
        let s:fzf.cidx = s:fzf.cidx == len(s:fzf.filterd)-1 ? len(s:fzf.filterd)-1 : s:fzf.cidx + 1
    elseif a:key is# 'k'
    let s:fzf.cidx = s:fzf.cidx == 0 ? 0 : s:fzf.cidx - 1
    elseif a:key is# "\<CR>"
    retu s:fzf.open(a:winid, 'e', s:fzf.filterd[s:fzf.cidx])
    elseif a:key is# "\<C-v>"
    retu s:fzf.open(a:winid, 'vnew', s:fzf.filterd[s:fzf.cidx])
    elseif a:key is# "\<C-t>"
    retu s:fzf.open(a:winid, 'tabnew', s:fzf.filterd[s:fzf.cidx])
    endif
    retu popup_filter_menu(a:winid, a:key)
endf
fu! s:fzf.open(winid, op, f) abort
    cal popup_close(a:winid)
    cal s:runcat.stop()
    exe a:op a:f
    retu 1
endf

" }}}

" ===================================================================
" MattesGroeger/vim-bookmarks
" ===================================================================
" TODO リファクタ
" {{{
sign define mk text=⚑ texthl=DarkBlue

let s:mk = #{winid: 0, tle: 'marks', allwinid: 0, atle: 'marks-allfiles',
    \ path: $HOME.'/.vim/.mk',
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
    let list = self.list()
    if empty(list)
        cal EchoE('no marks')
        retu
    endif
    let resources = deepcopy(list)->sort({ x,y -> x.lnum - y.lnum })
        \ ->map({ _,v -> v.lnum.' '.getline(v.lnum) })
    cal s:fzsearch.popup(#{list: resources,
        \ title: 'Marks in Current Buffer',
        \ enter_prefix: '>>',
        \ enter_title: 'Choose: <C-n/p> <CR> | ClearText: <C-w>',
        \ func_confirm: 's:mkchoose',
        \ func_tab: { -> execute('echom "Tab"') },
        \ })
endf

" TODO mk 全体検索
" TODO mk signを全て取得
" sign_getplaced()
" これをgroupでfilterして表示
" ファイルから検索か?
" TODO signを現在のバッファから取得 → タブで切り替える？

fu! s:mk.listall() abort
endf

" choose callback
fu! s:mkchoose(wid, idx)
    if a:idx == -1 || empty(s:fzsearch.res)
        cal EchoE('cancel')
        retu
    endif
    let row = s:fzsearch.res[a:idx-1]
    let line = split(row, ' ')[0]
    cal cursor(line, 1)
    cal EchoI('jump to mark')
endf

aug mk_st
    au!
    au BufEnter * cal s:mk.load()
    au BufWritePost * cal s:mk.save()
aug END

let s:mktoggle = s:mk.toggle
let s:mknext = function(s:mk.jump, [1])
let s:mkprev = function(s:mk.jump, [0])
let s:mkclthis = s:mk.clthis
let s:mkclall = s:mk.clall
let s:mklist = s:mk.listcb

noremap <Plug>(mk-toggle) :<C-u>cal <SID>mktoggle()<CR>
noremap <Plug>(mk-next) :<C-u>cal <SID>mknext()<CR>
noremap <Plug>(mk-prev) :<C-u>cal <SID>mkprev()<CR>
noremap <Plug>(mk-clthis) :<C-u>cal <SID>mkclthis()<CR>
noremap <Plug>(mk-clall) :<C-u>cal <SID>mkclall()<CR>
noremap <Plug>(mk-list) :<C-u>cal <SID>mklist()<CR>
" }}}

" ===================================================================
" t9md/vim-quickhl
" ===================================================================
" TODO リファクタ
" {{{
" TODO 整理
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
    au! ColorScheme * cal s:quickhl.hlini()
aug END

let s:quickhlset = s:quickhl.set
let s:quickhlclear = s:quickhl.clear
noremap <Plug>(qikhl-toggle) :<C-u>cal <SID>quickhlset()<CR>
noremap <Plug>(qikhl-clear) :<C-u>cal <SID>quickhlclear()<CR>
" }}}

" ===================================================================
" unblevable/quick-scope
" ===================================================================
" TODO リファクタ
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

let s:fmodetoggle = s:fmode.toggle
noremap <Plug>(f-scope) :<C-u>cal <SID>fmodetoggle()<CR>
" }}}

" ===================================================================
" junegunn/goyo.vim
" ===================================================================
" TODO リファクタ
" {{{
let s:zen_mode = #{flg: 0, vert_split: []}
fu! s:zenModeToggle() abort
    if s:zen_mode.flg
        let s:zen_mode.flg = 0
        set number cursorline cursorcolumn laststatus=2 showtabline=2
        tabc
        exe 'hi VertSplit '.join(s:zen_mode.vert_split[2:], ' ')
        retu
    endif
    let s:zen_mode.flg = 1
    tab split
    norm zR
    set nonumber norelativenumber nocursorline nocursorcolumn laststatus=0 showtabline=0
    vert to new
    setl buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nonu noru winfixheight
    vert res 40
    exe winnr('#').'wincmd w'
    vert bo new
    setl buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nonu noru winfixheight
    vert res 40
    exe winnr('#').'wincmd w'
    "['NonText', 'FoldColumn', 'ColorColumn', 'VertSplit', 'StatusLine', 'StatusLineNC', 'SignColumn']
    let s:zen_mode.vert_split = split(execute('hi VertSplit'),' ')->filter({ _,v -> !empty(v) })
    exe 'hi VertSplit ctermfg=black ctermbg=NONE cterm=NONE'
    setl number relativenumber
endf

noremap <Plug>(zen-mode) :<C-u>cal <SID>zenModeToggle()<CR>
" }}}

" ===================================================================
" easymotion/vim-easymotion
" ===================================================================
" TODO リファクタ
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
    let crn = line('.')
    for l in getline('w0', 'w$')
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
    for r in sort(deepcopy(wininfo), { x,y -> abs(x.row-crn) - abs(y.row-crn) })
        let tmp = []
        for col in r.col
            cal add(tmp, #{key: copy(keyOrder)->map({i,v->self.keys[v]})->join(''), pos: col})
            let keyOrder = self.incrementNOrder(len(self.keys)-1, keyOrder)
        endfor
        cal add(self.keypos, #{row: r.row, col: tmp})
    endfor
    " draw , disable syntax diagnostic if exists
    if exists('*CocAction')
        cal CocAction('diagnosticToggle')
    endif
    cal range(line('w0'), line('w$'))->map({ _,v -> matchaddpos('EmotionBase', [v], 98) })
    cal self.draw(self.keypos)
    cal popup_close(self.popid)
    " TODO emotion popup color
    let self.popid = popup_create('e-motion', #{line: &lines, col: &columns*-1, mapping: 0, filter: self.char_enter})
    echo ''
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

" about highlight setting
aug emotion_hl
    au!
    au ColorScheme * hi EmotionBase ctermfg=59
    au ColorScheme * hi EmotionWip ctermfg=166 cterm=bold
    au ColorScheme * hi EmotionFin ctermfg=196 cterm=bold
aug END
fu! s:emotion.hl_del(group_name_list) abort
    cal getmatches()->filter({ _,v -> match(a:group_name_list, v.group) != -1 })->map({ _,v -> matchdelete(v.id) })
endf

" draw keystroke
" 日本語は1文字でマルチバイト3文字分だが、カーソル幅は2なのでめんどいから弾いてある
" posの次文字がマルチバイトだと、strokeが2回以上残ってる時、変に文字を書き換えてカラム数変わる
fu! s:emotion.draw(keypos) abort
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
        u
        cal cursor(p[1],p[2])
        cal self.hl_del(['EmotionFin', 'EmotionWip', 'EmotionBase'])
        " TODO ハイライトの優先度でよくね？
        " restore f-scope
        if exists('*CocAction')
            cal CocAction('diagnosticToggle')
        endif
        ""cal s:fmode.takeover()
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
        u
        cal cursor(self.keypos[0].row, self.keypos[0].col[0].pos)
        cal self.hl_del(['EmotionFin', 'EmotionWip', 'EmotionBase'])
        " restore f-scope
        " TODO ハイライトの優先度でよくね？
        if exists('*CocAction')
            cal CocAction('diagnosticToggle')
        endif
        ""cal s:fmode.takeover()
        cal EchoI('e-motion: finish')
        retu 1
    endif
    " redraw
    let p = getpos('.')
    u
    cal cursor(p[1],p[2])
    echo ''
    cal self.draw(self.keypos)
    retu 1
endf

let s:emotion = s:emotion.exe
noremap <Plug>(emotion) :<C-u>cal <SID>emotion()<CR>
" }}}

" ===================================================================
" mhinz/vim-startify
" ===================================================================
" TODO 作成
" {{{

" TODO startify






" }}}

" }}}

" TODO リファクタ
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
let s:plug.repos = [
    \ 'mhinz/vim-startify',
    \ 'github/copilot.vim', 'puremourning/vimspector',
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

    let cmd = "mkdir -p ~/.vim/pack/plugins/start&&cd ~/.vim/pack/plugins/start"
        \ ."&&git clone -b release https://github.com/neoclide/coc.nvim"
    ""cal s:runcat.start() | cal job_start(["/bin/zsh","-c",color_cmd]) | cal job_start(["/bin/zsh","-c",cmd], #{close_cb: s:plug.coc_setup})
    cal s:runcat.start()
    cal job_start(["/bin/zsh","-c",cmd], #{close_cb: s:plug.coc_setup})
    echo 'colors, plugins installing...'
    cal popup_notification('colors, plugins installing...', #{border: [], line: &columns/4-&columns/37, close: 'button'})
endf

" TODO onedark use
" coc extentions
fu! s:plug.coc_setup(ch) abort
    cal s:runcat.stop()
    cal EchoE('colors, plugins installed. coc-extentions installing. PLEASE REBOOT VIM after this.')
    " TODO 色とか綺麗に zindex9999
    cal popup_notification('colors, plugins installed. coc-extentions installing. PLEASE REBOOT VIM after this.', #{ border: [], line: &columns/4-&columns/37, close: "button" })
    exe 'source ~/.vim/pack/plugins/start/coc.nvim/plugin/coc.vim'
    exe 'CocInstall '.join(s:plug.coc_extentions,' ')
    let cocconfig = ['{',
        \ '    \"snippets.ultisnips.pythonPrompt\": false,',
        \ '    \"explorer.icon.enableNerdfont\": true,',
        \ '    \"explorer.file.showHiddenFiles\": true,',
        \ '    \"python.formatting.provider\": \"yapf\",',
        \ '    \"pyright.inlayHints.variableTypes\": false',
        \ '}',
        \]
    for v in cocconfig
        cal system('echo "'.v.'" >> ~/.vim/coc-settings.json')
    endfor
    "cal coc#util#install() if git clone --depth 1, need this statement
endf

" uninstall
fu! s:plug.uninstall() abort
    cal EchoE('delete ~/.vim')
    cal EchoE('Are you sure to delete these folders ?')
    let w = confirm("Save changes?", "&Yes\n&No\n&Cancel")
    if w != 1
        cal EchoI('cancel')
        retu
    endif
    exe "bo terminal ++shell echo 'start'&&rm -rf ~/.vim&&echo 'end. PLEASE REBOOT VIM'"
endf

com! ColorInstall cal s:plug.color_install()
com! PlugInstall cal s:plug.install()
com! PlugUnInstall cal s:plug.uninstall()
" }}}

" TODO リファクタ
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

" fzf run time path(git, homebrew)
set rtp+=~/.vim/pack/plugins/start/fzf
set rtp+=/opt/homebrew/opt/fzf
" TODO batいるっけ？
set rtp+=/opt/homebrew/opt/bat

" TODO delete
" easy motion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_keys='swadjkhlnmf'

" TODO delete
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
let g:btr_logo = [
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

" TODO delete
let g:startify_custom_header = g:btr_logo

" }}}

" ##################      PLUGIN KEYMAP     ################### {{{

" for no override default motion, if glob( plugin path ) is need
" TODO existsになおす？

" TODO delete
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

    " cursor highlight
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
    " TODO comfortable scrollと競合
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : Scroll(1, 10)
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : Scroll(0, 10)
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
" TODO つくったりなおしたり
" {{{



colorscheme torte
hi Normal ctermbg=235
if glob('~/.vim/colors/') != ''
    colorscheme onedark
endif

cal s:fmode.activate()




" }}}

" alse see [https://github.com/serna37/vim/]
