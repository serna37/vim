" vim:set foldmethod=marker:

" ========================================
" SETTING
" ========================================
" {{{

" basic
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
if executable('rg')
  let &grepprg = 'rg --vimgrep --hidden'
  set grepformat=%f:%l:%c:%m
endif

" completion
set wildmenu
set wildmode=full
set complete=.,w,b,u,U,k,kspell,s,i,d,t
set completeopt=menuone,noinsert,preview,popup
"}}}

" ========================================
" Plugin Options
" ========================================
" {{{
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

" ========================================
" KEY MAP
" ========================================
" {{{
let g:mapleader = "\<Space>"

" WINDOW ============================================-
" {{{
" tabline motion
nmap <silent><C-n> <Plug>AirlineSelectPrevTab
nmap <silent><C-p> <Plug>AirlineSelectNextTab
nnoremap <silent><Leader>x :call CloseBuf()<CR>
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
"nnoremap <silent><Leader>tp :call popup_create(term_start([&shell], #{ hidden: 1, term_finish: 'close'}), #{ border: [], minwidth: &columns/2, minheight: &lines/2 })<CR>
" zen
nnoremap <silent><Leader>z :Goyo<CR>
" }}}

" MOTION ============================================-
" {{{
" row-move
nnoremap j gj
nnoremap k gk
nnoremap <Tab> 5gj
nnoremap <S-Tab> 5gk
" scroll
nnoremap <silent><C-u> :cal Scroll(0, 25)<CR>
nnoremap <silent><C-d> :cal Scroll(1, 25)<CR>
nnoremap <silent><C-b> :cal Scroll(0, 10)<CR>
nnoremap <silent><C-f> :cal Scroll(1, 10)<CR>
" f-scope
nnoremap <Leader>w <plug>(QuickScopeToggle)
" }}}

" SEARCH ============================================-
" {{{
" file search
nnoremap <silent><Leader>e :CocCommand explorer --width 30<CR>
nnoremap <silent><leader>f :cal FzfG()<CR>
nnoremap <silent><leader>h :CocCommand fzf-preview.MruFiles<CR>
nnoremap <silent><leader>b :CocCommand fzf-preview.AllBuffers<CR>
" word search (highlight)
nnoremap s <Plug>(easymotion-bd-w)
nnoremap <Leader>s <Plug>(easymotion-sn)
nnoremap <Leader><Leader>s :CocList words<CR>
nnoremap <silent>* *N<Plug>(quickhl-manual-this)
nnoremap <silent># *N<Plug>(quickhl-manual-this)
autocmd CursorHold * silent call CocActionAsync('highlight')
nnoremap <silent><Leader>q <Plug>(quickhl-manual-reset):noh<CR>
nnoremap <silent><Leader>g :cal Grep()<CR>
" jump/mark
nnoremap <silent><Leader>m :CocCommand fzf-preview.Bookmarks<CR>
nnoremap <silent><Leader>l :CocCommand fzf-preview.Lines<CR>
nnoremap <silent><Leader>j :CocCommand fzf-preview.Jumps<CR>
nnoremap <silent><Leader>c :CocCommand fzf-preview.Changes<CR>
" }}}

" EDIT ============================================-
" {{{
" d = delete(no clipboard)
nnoremap d "_d
vnoremap d "_d
" block move @ visual mode
vnoremap <C-j> "zx"zp`[V`]
vnoremap <C-k> "zx<Up>"zP`[V`]
" move cursor @ insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>l
inoremap <C-k> <C-o>k
inoremap <C-j> <C-o>j
" completion @ coc
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
" }}}

" IDE ============================================-
" {{{
nnoremap <silent><Leader>v :cal IDEMenu()<CR>
nnoremap <Leader>d <Plug>(coc-definition)
nnoremap <Leader>r :CocCommand fzf-preview.CocReferences<CR>
nnoremap <Leader>o :CocCommand fzf-preview.CocOutline<CR>
nnoremap <Leader>? :cal CocAction('doHover')<CR>
nnoremap <Leader>, <plug>(coc-diagnostic-next)
nnoremap <Leader>. <plug>(coc-diagnostic-prev)
"nnoremap <Leader>sh :cal execute('top terminal ++rows=10 ++shell eval ' . getline('.'))<CR>
" }}}

"}}}

" ========================================
" FUNCTION
" ========================================
" {{{

" close buffer
" {{{
fu! CloseBuf()
  let l:now_b = bufnr('%')
  bn
  execute('bd ' . now_b)
endf
" }}}
" fzf
" {{{
fu! FzfG() " if git repo, ref .gitignore
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
" }}}
" grep
" {{{
fu! Grep() abort
  let w = inputdialog("word [target]>>")
  if w == ''
    retu
  endif
  echo '<<'
  execute('CocCommand fzf-preview.ProjectGrep -w --ignore-case '.w)
endf
" }}}
" git all push
" {{{
fu! AllPush() abort
  let w = inputdialog("commit message>>")
  if w == ''
    echo 'cancel'
    retu
  endif
  echo '<<'
  cal execute('top terminal ++rows=10 ++shell git add . && git commit -m "'.w.'" && git push')
endf
" }}}
" IDE menu
" {{{
let g:my_ide_menu_items = [
    \'[ReName] rename current word recursively',
    \'[Format] applay format for this file',
    \'[Run] run current program',
    \'[Debug] debug current program',
    \'[Git] git actions',
    \'[ALL PUSH] commit & push all changes',
    \'[QuickFix-Grep] Open Preview Popup from quickfix - from fzfpreview Ctrl+Q',
    \'[Snippet] edit snippets',
    \'=(Space d)[Definition] Go to Definition',
    \'=(Space r)[Reference] Reference',
    \'=(Space o)[Outline] view outline on popup',
    \'=(Space ?)[Document] show document on popup',
    \'=(Space ,)[Next Diagnosis] jump next diagnosis',
    \'=(Space .)[Prev Diagnosis] jump prev diagnosis',
 \]

fu! IDEMenu() abort
  cal popup_menu(g:my_ide_menu_items , #{ title: 'IDE menu (j / k choose)', border: [], zindex: 100, minwidth: &columns/2, maxwidth: &columns/2, minheight: 2, maxheight: &lines/2, filter: function('IDEChoose', [{'idx': 0, 'files': g:my_ide_menu_items }]) })
endf

fu! IDEChoose(ctx, winid, key) abort
  if a:key is# 'j' && a:ctx.idx < len(a:ctx.files)-1
    let a:ctx.idx = a:ctx.idx+1
  elseif a:key is# 'k' && a:ctx.idx > 0
    let a:ctx.idx = a:ctx.idx-1
  elseif a:key is# "\<CR>"
    if a:ctx.idx == 0
      cal CocActionAsync('rename')
    elseif a:ctx.idx == 1
      cal CocActionAsync('format')
    elseif a:ctx.idx == 2
      exe "QuickRun -hook/time/enable 1"
    elseif a:ctx.idx == 3
      cal vimspector#Launch()
    elseif a:ctx.idx == 4
      execute("CocCommand fzf-preview.GitActions")
    elseif a:ctx.idx == 5
      cal AllPush()
    elseif a:ctx.idx == 6
      execute("CocCommand fzf-preview.QuickFix")
    elseif a:ctx.idx == 7
      execute("CocCommand snippets.editSnippets")
    endif
  endif
  retu popup_filter_menu(a:winid, a:key)
endf
" }}}
" scroll
" {{{
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
"}}}
" color
" {{{
let s:colorscheme_arr_default = ['torte']
let s:colorscheme_arr = ['onedark']
" hybrid_material
" molokai
fu! ChangeColor()
  if glob('~/.vim/colors') != ''
    execute('colorscheme ' . s:colorscheme_arr[localtime() % len(s:colorscheme_arr)])
  else
    execute('colorscheme ' . s:colorscheme_arr_default[localtime() % len(s:colorscheme_arr_default)])
  endif
endf
cal ChangeColor()

" }}}
" plugins
" {{{
" color
let s:colors = [
    \ 'hybrid_material.vim',
    \ 'molokai.vim',
    \ 'onedark.vim'
\ ]

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
  echo 'delete ~/.vim ~/.config'
  echo 'are you sure to delete these folder ?'
  let w = inputdialog("YES (Y) / NO (N)")
  if w != 'Y' || w != 'y'
    echo 'cancel'
    retu
  endif
  execute("bo terminal ++shell echo 'start' && rm -rf ~/.vim ~/.config && echo 'end'")
endf
" }}}

" }}}

" ========================================
" COMMAND
" ========================================
command! PlugInstall cal PlugInstall()
command! PlugInstallCoc cal PlugInstallCoc()
command! PlugUnInstall cal PlugUnInstall()

