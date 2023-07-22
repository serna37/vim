" vim:set foldmethod=marker:

" TODO fix content doc

" ==============================================================================
"    CONTENTS
"
"     # basic vim setting
"       ## FILE ........................ | file encoding, charset, vim specific setting.
"       ## VISUALIZATION ......... | enhanced visual information.
"       ## OPERATION ......... | cursor move, and so on.
"       ## COMPLETION ......... | indent, word
"       ## SEARCH ......... | search, explorer
"       ## OTHERS ......... | fast terminal, reg engin, fold
"
"     # plugins setting
"       ## GLOBAL VARIABLE ......... | overrite global variable
"
"     # functions
"       ## FUNCTIONS ......... | adhoc functions
"       ## IMITATION ......... | imitation plugins as functions
"
" ==============================================================================

let mapleader = "\<SPACE>"

" #############################################################
" ##################       CheatSheet       ###################
" #############################################################

" cursor hold
" motion cheat sheet on popup

augroup cheat_sheet_hover
  au!
  autocmd CursorHold * silent call CheatSheet()
  autocmd CursorMoved * silent call CheatSheetClose()
augroup END

let g:my_vim_cheet_sheet = [
      \' (Space v)    [IDE Action Menu] ',
      \' (Tab S-Tab)  [5 row jump] ',
      \' (mm/mn/mp)   [mark/next/prev] ',
      \' (s)          [EasyMotion] ',
      \' (Space s)    [EasyMotion incremental] ',
      \' (Space*2 s)  [Buffer Grep incrementa] ',
      \' (Space fhbm) [FZF files/buffers/histories/marks] ',
      \' (Space jcl)  [FZF jumped/changed/line] ',
      \' (Space w)    [F-Scope Toggle] ',
      \' (Space z)    [Zen Mode] ',
      \' (Space*3)    [ON/OFF Cheat Sheet] ',
      \]

" no plugin version
if glob('~/.vim/pack/plugins/start') == ''
  let g:my_vim_cheet_sheet = [
        \' (Space v)    [IDE Action Menu] some are dosabled ',
        \' (Tab S-Tab)  [5 row jump] ',
        \' (mm/mn/mp)   [mark/next/prev] ',
        \' (Space f)    [FZF files/buffers/histories] ',
        \' (Space m)    [Marks] ',
        \' (Space w)    [F-Scope Toggle] ',
        \' (Space*3)    [ON/OFF Cheat Sheet] ',
        \]
endif

let g:cheat_sheet_open_flg = 0
let g:cheatwinid = 0
let g:cheat_sheet_timer_id = 0
fu! CheatSheetPopup(timer)
  let g:cheatwinid = popup_create(g:my_vim_cheet_sheet, #{ title: ' Action Cheet Sheet ', border: [], zindex: 1, line: "cursor+1", col: "cursor" })
endf

fu! CheatSheet()
  if g:show_cheat_sheet_flg == 0
    return
  endif
  if g:cheat_sheet_open_flg == 0
    let g:cheat_sheet_open_flg = 1
    let g:cheat_sheet_timer_id = timer_start(5000, function("CheatSheetPopup"))
  endif
endf
fu! CheatSheetClose()
  if g:show_cheat_sheet_flg == 0
    return
  endif
  let g:cheat_sheet_open_flg = 0
  call popup_close(g:cheatwinid)
  call timer_stop(g:cheat_sheet_timer_id)
endf

nnoremap <silent><Leader><Leader><Leader> :call PopupFever()<CR>:call ToggleCheatHover()<CR>
let g:show_cheat_sheet_flg = 1
let g:recheatwinid = 0
fu! PopupFever()
  call RunCat()
  let g:recheatwinid = popup_create(g:my_vim_cheet_sheet, #{ title: ' Action Cheet Sheet ', border: [], line: &columns/4-&columns/36 })
  let g:logowinid = popup_create(g:startify_custom_header, #{ border: [] })
endf
fu! PopupFeverStop()
  call RunCatStop()
  call popup_close(g:recheatwinid )
  call popup_close(g:logowinid)
endf
fu! ToggleCheatHover()
  let msg = 'Disable Cheat Sheet Hover'
  if g:show_cheat_sheet_flg == 1
    let g:show_cheat_sheet_flg = 0
  else
    let msg = 'Enable Cheat Sheet Hover'
    let g:show_cheat_sheet_flg = 1
  endif
  let g:checkwinid = popup_notification(msg, #{ border: [], line: &columns/4-&columns/37, close: "button" })
  call timer_start(3000, { -> PopupFeverStop()})
endf



" #############################################################
" ##################          FILE          ###################
" #############################################################

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
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END


" #############################################################
" ##################     VISUALIZATION      ###################
" #############################################################

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
" cannot recognized this by win32
if has('macunix') || has('unix')
  au ModeChanged [vV\x16]*:* let &l:rnu = mode() =~# '^[vV\x16]'
  au ModeChanged *:[vV\x16]* let &l:rnu = mode() =~# '^[vV\x16]'
  au WinEnter,WinLeave * let &l:rnu = mode() =~# '^[vV\x16]'
endif

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


" #############################################################
" ##################         WINDOW        ###################
" #############################################################

" just like
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

" terminal
nnoremap <silent><Leader>t :bo terminal ++rows=10<CR>


" #############################################################
" ##################          MOVE          ###################
" #############################################################

" row move
nnoremap j gj
nnoremap k gk
nnoremap <Tab> 5gj
nnoremap <S-Tab> 5gk
vnoremap <Tab> 5gj
vnoremap <S-Tab> 5gk

" comfortable scroll
nnoremap <silent><C-u> :cal Scroll(0, 25)<CR>
nnoremap <silent><C-d> :cal Scroll(1, 25)<CR>
nnoremap <silent><C-b> :cal Scroll(0, 10)<CR>
nnoremap <silent><C-f> :cal Scroll(1, 10)<CR>

" custom scroll just like
" yuttie/comfortable-motion.vim
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
endf

" mark
if glob('~/.vim/pack/plugins/start/vim-bookmarks') == ''
  " vim-bookmarks can read all buffer's marks by fzf-preview marks
  " this vimscript function can only call inner buffer
  nnoremap mm :call Marking()<CR>
  nnoremap mn :call MarkHank("down")<CR>
  nnoremap mp :call MarkHank("up")<CR>
  nnoremap <silent><Leader>m :call MarkMenu()<CR>
endif


" #############################################################
" ##################         EDIT           ###################
" #############################################################

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

" block move at visual mode
vnoremap <C-j> "zx"zp`[V`]
vnoremap <C-k> "zx<Up>"zP`[V`]

" #############################################################
" ##################       COMPLETION       ###################
" #############################################################

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


" #############################################################
" ##################         SEARCH         ###################
" #############################################################

" search
set incsearch " incremental search
set hlsearch " highlight match words
set ignorecase " ignore case search
set smartcase " don't ignore case when enterd UPPER CASE"
set shortmess-=S " show hit word's number at right bottom

" no move search word
nnoremap <silent>* *N:call HiSet()<CR>
nnoremap <silent># #N:call HiSet()<CR>

" disable highlight
nnoremap <silent><Leader>q :noh<CR>:cal clearmatches()<CR>

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
nnoremap <silent><Leader>e :Vex 30<CR>


" #############################################################
" ##################         OTHERS         ###################
" #############################################################

" basic
scriptencoding utf-8 " this file's charset
set ttyfast " fast terminal connection
set regexpengine=0 " chose regexp engin

" fold
set foldmethod=marker " fold marker
set foldlevel=0 " fold max depth
set foldlevelstart=0 " fold depth on start view
set foldcolumn=1 " fold preview


" #############################################################
" ##################    PLUGIN VARIABLES    ###################
" #############################################################

if glob('~/.vim/colors/') != ''
  colorscheme onedark
endif

" coc
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" vimspector
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

" fzf
set rtp+=~/.vim/pack/plugins/start/fzf

" f-scope
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=196 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

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

" gitgutter
let g:gitgutter_map_keys = 0

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


" #############################################################
" ##################      PLUGIN KEYMAP     ###################
" #############################################################

" for no override default motion, if glob( plugin path ) is need

" tabline motion
nmap <silent><C-n> <Plug>AirlineSelectPrevTab
nmap <silent><C-p> <Plug>AirlineSelectNextTab
nnoremap <silent><Leader>x :call CloseBuf()<CR>

" file search
if glob('~/.vim/pack/plugins/start/coc.nvim') != ''
  nnoremap <silent><Leader>e :CocCommand explorer --width 30<CR>
endif
nnoremap <silent><leader>f :cal FzfG()<CR>
nnoremap <silent><leader>h :CocCommand fzf-preview.MruFiles<CR>
nnoremap <silent><leader>b :CocCommand fzf-preview.AllBuffers<CR>

" search highlight
if glob('~/.vim/pack/plugins/start/vim-quickhl') != ''
  nnoremap <silent>* *N<Plug>(quickhl-manual-this)
  nnoremap <silent># #N<Plug>(quickhl-manual-this)
  nnoremap <silent><Leader>q <Plug>(quickhl-manual-reset):noh<CR>
endif
if glob('~/.vim/pack/plugins/start/coc.nvim') != ''
  autocmd CursorHold * silent call CocActionAsync('highlight')
endif

" f-scope
nnoremap <Leader>w <plug>(QuickScopeToggle)

" easy motion
if glob('~/.vim/pack/plugins/start/vim-easymotion') != ''
  nnoremap s <Plug>(easymotion-bd-w)
  nnoremap <Leader>s <Plug>(easymotion-sn)
endif

" grep
nnoremap <Leader><Leader>s :CocList words<CR>
nnoremap <silent><Leader>g :cal Grep()<CR>

" jump/mark
if glob('~/.vim/pack/plugins/start/coc.nvim') != ''
  nnoremap <silent><Leader>m :CocCommand fzf-preview.Bookmarks<CR>
endif
nnoremap <silent><Leader>l :CocCommand fzf-preview.Lines<CR>
nnoremap <silent><Leader>j :CocCommand fzf-preview.Jumps<CR>
nnoremap <silent><Leader>c :CocCommand fzf-preview.Changes<CR>

" completion @ coc
if glob('~/.vim/pack/plugins/start/coc.nvim') != ''
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
  inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
  inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
endif

" IDE
nnoremap <silent><Leader>v :cal IDEMenu()<CR>
nnoremap <Leader>d <Plug>(coc-definition)
nnoremap <Leader>r :CocCommand fzf-preview.CocReferences<CR>
nnoremap <Leader>o :CocCommand fzf-preview.CocOutline<CR>
nnoremap <Leader>? :cal CocAction('doHover')<CR>
nnoremap <Leader>, <plug>(coc-diagnostic-next)
nnoremap <Leader>. <plug>(coc-diagnostic-prev)
if glob('~/.vim/pack/plugins/start/coc.nvim') != ''
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) :  Scroll(1, 10)
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) :  Scroll(0, 10)
endif

" zen mode
nnoremap <silent><Leader>z :Goyo<CR>


" #############################################################
" ##################       FUNCTIONS        ###################
" #############################################################

fu! CloseBuf()
  let l:now_b = bufnr('%')
  execute("normal \<C-n>")
  execute('bd ' . now_b)
endf

fu! FzfG() " if git repo, ref .gitignore. || no plugin
  if glob('~/.vim/pack/plugins/start/coc.nvim') == ''
    cal FzfStart()
    return
  endif
  let pwd = system('pwd')
  try
    exe 'lcd %:h'
  catch
  endtry
  let gitroot = system('git rev-parse --show-superproject-working-tree --show-toplevel')
  try
    exe 'lcd ' . pwd
  catch
  endtry
  execute(!v:shell_error ? 'CocCommand fzf-preview.ProjectFiles' : 'Files')
endf

fu! Grep() abort
  let w = inputdialog("word [target]>>")
  if w == ''
    retu
  endif
  echo '<<'
  execute('CocCommand fzf-preview.ProjectGrep -w --ignore-case '.w)
endf

let g:my_ide_menu_items = [
      \'[Format]        applay format for this file',
      \'[ReName]        rename current word recursively',
      \'[Git]           git actions',
      \'[ALL PUSH]      commit & push all changes',
      \'[QuickFix-Grep] Open Preview Popup from quickfix - from fzfpreview Ctrl+Q',
      \'[Snippet]       edit snippets',
      \'[Run]           run current program',
      \'[Debug]         debug current program',
      \'[Run as Shell]  run current row as shell command',
      \'[Term popup]    open terminal on popup window',
      \'[Color random]  change colorscheme at random',
      \]

let g:my_ide_action_cheet_sheet = [
      \' (Space d) [Definition]     Go to Definition ',
      \' (Space r) [Reference]      Reference ',
      \' (Space o) [Outline]        view outline on popup ',
      \' (Space ?) [Document]       show document on popup scroll C-f/b ',
      \' (Space ,) [Next Diagnosis] jump next diagnosis ',
      \' (Space .) [Prev Diagnosis] jump prev diagnosis ',
      \]

let s:colorscheme_arr_default = ['torte']
let s:colorscheme_arr = ['onedark', 'hybrid_material', 'molokai']

let s:popid = 0
fu! IDEMenu() abort
  let s:popid = popup_create(g:my_ide_action_cheet_sheet, #{ title: ' Other KeyMaps ', border: [], line: &columns/4-&columns/36 })
  cal popup_menu(g:my_ide_menu_items, #{ title: ' IDE MENU (j / k choose) ', border: [], filter: function('IDEChoose', [{'idx': 0, 'files': g:my_ide_menu_items }]) })
endf

fu! IDEChoose(ctx, winid, key) abort
  if a:key is# 'j' && a:ctx.idx < len(a:ctx.files)-1
    let a:ctx.idx = a:ctx.idx+1
  elseif a:key is# 'k' && a:ctx.idx > 0
    let a:ctx.idx = a:ctx.idx-1
  elseif a:key is# "\<Esc>"
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
      execute("CocCommand fzf-preview.GitActions")
    elseif a:ctx.idx == 3
      let w = inputdialog("commit message>>")
      if w == ''
        echo 'cancel'
        retu
      endif
      cal execute('top terminal ++rows=10 ++shell git add . && git commit -m "'.w.'" && git push')
    elseif a:ctx.idx == 4
      execute("CocCommand fzf-preview.QuickFix")
    elseif a:ctx.idx == 5
      execute("CocCommand snippets.editSnippets")
    elseif a:ctx.idx == 6
      exe "QuickRun -hook/time/enable 1"
    elseif a:ctx.idx == 7
      cal vimspector#Launch()
    elseif a:ctx.idx == 8
      execute('top terminal ++rows=10 ++shell eval ' . getline('.'))
    elseif a:ctx.idx == 9
      call popup_create(term_start([&shell], #{ hidden: 1, term_finish: 'close'}), #{ border: [], minwidth: &columns/2, minheight: &lines/2 })
    elseif a:ctx.idx == 10
      if glob('~/.vim/colors') != ''
        execute('colorscheme ' . s:colorscheme_arr[localtime() % len(s:colorscheme_arr)])
      else
        execute('colorscheme ' . s:colorscheme_arr_default[localtime() % len(s:colorscheme_arr_default)])
      endif
    endif
  call popup_close(s:popid)
  endif
  retu popup_filter_menu(a:winid, a:key)
endf



" #############################################################
" ##################       IMITATION        ###################
" #############################################################

" ===================================================================
" junegunn/fzf.vim
" ===================================================================
let g:not_path_arr = [
      \'"*.vim/*"',
      \'"*.git/*"',
      \'"*.npm/*"',
      \'"*.yarn/*"',
      \'"*.m2/*"',
      \'"*.class"',
      \'"*.vscode/*"',
      \'"*.config/*"',
      \'"*Applications/*"',
      \'"*Library/*"',
      \'"*Music/*"',
      \'"*Pictures/*"',
      \'"*Movies/*"',
      \'"*AppData/*"',
      \'"*OneDrive/*"',
      \'"*Videos/*"'
      \]
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
endf

" run cat (load animation)
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

" ===================================================================
" MattesGroeger/vim-bookmarks
" ===================================================================

let g:mark_words = 'abcdefghijklmnopqrstuvwxyz'
fu! s:get_mark(tar) abort
  try
    retu execute('marks ' . a:tar)
  catch
    retu ''
  endtry
endf

fu! MarkMenu() abort
  let get_marks = s:get_mark(g:mark_words)
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
endf

fu! Marking() abort
  let get_marks = s:get_mark(g:mark_words)
  if get_marks == ''
    execute('mark a')
    cal MarkShow()
    echo 'marked'
    retu
  endif
  let l:now_marks = []
  let l:warr = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
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
endf

fu! MarkSignDel()
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
endf

fu! MarkShow() abort
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
  let get_marks = s:get_mark(g:mark_words)
  if get_marks == ''
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


" ===================================================================
" t9md/vim-quickhl
" ===================================================================

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


" ===================================================================
" unblevable/quick-scope
" ===================================================================

" TODO something went wrong...

aug qs_colors_mimic
  au!
  au ColorScheme * highlight FSCopePrimary cterm=bold ctermfg=196 ctermbg=16 guifg=#66D9EF guibg=#000000
  au ColorScheme * highlight FSCodeSecondary ctermfg=161 ctermbg=16 guifg=#66D9EF guibg=#000000
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

fu! HiReset(group_name)
  let already = filter(getmatches(), {i, v -> v['group'] == a:group_name})
  if len(already) > 0
    cal matchdelete(already[0]['id'])
  endif
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

  if len(target_arr) != 0
    cal matchaddpos("FSCopePrimary", target_arr, 16)
  endif
  if len(target_arr_second) != 0
    cal matchaddpos("FSCodeSecondary", target_arr_second, 16)
  endif
  if len(target_arr_back) != 0
    cal matchaddpos("QuickScopeBack", target_arr_back, 16)
  endif
  if len(target_arr_back_second) != 0
    cal matchaddpos("QuickScopeBackSecond", target_arr_back_second, 16)
  endif
endf


" #############################################################
" ##################         PLUGINS        ###################
" #############################################################


" my colorscheme
let s:colors = [ 'onedark.vim', 'hybrid_material.vim', 'molokai.vim' ]

" repo
let s:repos = [
    \ 'junegunn/fzf',
    \ 'junegunn/fzf.vim',
    \ 'neoclide/coc.nvim',
    \ 'unblevable/quick-scope',
    \ 'easymotion/vim-easymotion',
    \ 'obcat/vim-hitspop',
    \ 't9md/vim-quickhl',
    \ 'MattesGroeger/vim-bookmarks',
    \ 'jiangmiao/auto-pairs',
    \ 'markonm/traces.vim',
    \ 'tpope/vim-fugitive',
    \ 'airblade/vim-gitgutter',
    \ 'mhinz/vim-startify',
    \ 'vim-airline/vim-airline',
    \ 'vim-airline/vim-airline-themes',
    \ 'sheerun/vim-polyglot',
    \ 'uiiaoo/java-syntax.vim',
    \ 'thinca/vim-quickrun',
    \ 'puremourning/vimspector',
    \ 'github/copilot.vim',
    \ 'junegunn/goyo.vim',
    \ 'junegunn/limelight.vim',
    \ ]

" extentions
let s:coc_extentions = [
    \ 'coc-explorer',
    \ 'coc-lists',
    \ 'coc-fzf-preview',
    \ 'coc-snippets',
    \ 'coc-sh',
    \ 'coc-vimlsp',
    \ 'coc-json',
    \ 'coc-sql',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-tsserver',
    \ 'coc-clangd',
    \ 'coc-go',
    \ 'coc-pyright',
    \ 'coc-java',
    \ ]

fu! PlugInstall(...)
  " color
  let repo = 'https://raw.githubusercontent.com/serna37/vim-color/master/'
  let cmd = "mkdir -p ~/.vim/colors && cd ~/.vim/colors "
  for scheme in s:colors
    let cmd = cmd . ' && curl ' . repo . scheme . ' > ' . scheme
  endfor
  " plugins
  let cmd = cmd . " && repos=('".join(s:repos,"' '")."') && mkdir -p ~/.vim/pack/plugins/start && cd ~/.vim/pack/plugins/start"
    \ . " && for v in ${repos[@]};do git clone --depth 1 https://github.com/${v} ;done"
    \ . " && fzf/install --no-key-bindings --completion --no-bash --no-zsh --no-fish"
  cal job_start(["/bin/zsh","-c",cmd], {'close_cb': function('s:coc_setup')})
  echo 'plug install processing...'
endf
fu! s:coc_setup(ch) abort
  echo 'coc install. please reboot vim, and call "PlugInstallCoc"'
  cal coc#util#install()
endf

" coc extentions
fu! PlugInstallCoc()
  execute("CocInstall " . join(s:coc_extentions," "))
endf

" uninstall
fu! PlugUnInstall(...)
  echo 'delete ~/.vim'
  echo 'are you sure to delete these folder ?'
  let w = inputdialog("YES (Y) / NO (N)")
  if w != 'Y' || w != 'y'
    echo 'cancel'
    retu
  endif
  execute("bo terminal ++shell echo 'start' && rm -rf ~/.vim && echo 'end'")
endf

command! PlugInstall cal PlugInstall()
command! PlugInstallCoc cal PlugInstallCoc()
command! PlugUnInstall cal PlugUnInstall()

