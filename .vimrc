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
" KEY MAP
" ========================================
" {{{
let g:mapleader = "\<Space>"

" WINDOW ============================================-
" airline
let g:airline_theme = 'deus'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_highlighting_cache = 1

" tabline motion
fu! CloseBuf()
  let l:now_b = bufnr('%')
  bn
  execute('bd ' . now_b)
endf
nnoremap <silent><C-p> :bn<CR>
nnoremap <silent><C-q> :bp<CR>
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
let g:limelight_conceal_ctermfg = 'gray'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" MOVE ============================================-
" row-move
nnoremap j gj
nnoremap k gk
nnoremap <silent><Tab> 5gj
nnoremap <silent><S-Tab> 5gk

" scroll
nnoremap <silent><C-u> :cal Scroll(0, 25)<CR>
nnoremap <silent><C-d> :cal Scroll(1, 25)<CR>
nnoremap <silent><C-b> :cal Scroll(0, 10)<CR>
nnoremap <silent><C-f> :cal Scroll(1, 10)<CR>

" f-scope
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=196 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END
nnoremap <silent><Leader>w <plug>(QuickScopeToggle)

" easy motion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_keys='swadjkhlnmf'
" only around jump
nnoremap s <Plug>(easymotion-bd-w)

" SEARCH ============================================-
" explorer
nnoremap <silent><Leader>e :CocCommand explorer --width 30<CR>

" fuzzy finder
set rtp+=~/.vim/pack/plugins/start/fzf
"nnoremap <silent><leader>h :History<CR>
"nnoremap <silent><leader>b :Buffers<CR>
nnoremap <silent><leader>h :CocCommand fzf-preview.MruFiles<CR>
nnoremap <silent><leader>b :CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent><leader>f :cal FzfG()<CR>
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
"  execute(!v:shell_error ? 'GFiles' : 'Files')
  execute(!v:shell_error ? 'CocCommand fzf-preview.ProjectFiles' : 'Files')
endf

" word search (highlight)
nnoremap <silent>* *N<Plug>(quickhl-manual-this)
autocmd CursorHold * silent call CocActionAsync('highlight')
nnoremap <silent># *N<Plug>(quickhl-manual-this)
nnoremap <silent><Leader>q <Plug>(quickhl-manual-reset):noh<CR>

" search with incremental greplist
nnoremap <Leader><Leader>s :CocList words<CR>
" search with easy motion
nnoremap <silent><Leader>s <Plug>(easymotion-sn)

"nnoremap <silent><Leader>g :Rg<CR>
nnoremap <silent><Leader>g :cal Grep()<CR>

" marking
nnoremap <silent><Leader>m :CocCommand fzf-preview.Marks<CR>
nnoremap <silent>mm :cal Marking()<CR>

" go line
nnoremap <silent><Leader>l :CocCommand fzf-preview.Lines<CR>

" jump history
nnoremap <silent><Leader>j :CocCommand fzf-preview.Jumps<CR>

" changed row
nnoremap <silent><Leader>c :CocCommand fzf-preview.Changes<CR>

" EDIT ============================================-
" d = delete(no clipboard)
nnoremap d "_d
vnoremap d "_d

" move cursor @ insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>l
inoremap <C-k> <C-o>k
inoremap <C-j> <C-o>j

" block move @ visual mode
vnoremap <C-j> "zx"zp`[V`]
vnoremap <C-k> "zx<Up>"zP`[V`]

" completion @ coc
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" IDE ============================================-
" coc
nnoremap <Leader>d <Plug>(coc-definition)
"nnoremap <Leader>r <plug>(coc-references)
nnoremap <Leader>r :CocCommand fzf-preview.CocReferences<CR>
nnoremap <Leader>o :CocCommand fzf-preview.CocOutline<CR>
nnoremap <Leader>v :cal IDEActions()<CR>
fu! IDEActions()
  echo '==================================================================='
  echo 'r  : [ReName] rename current word recursively'
  echo 'f  : [Format] applay format for this file'
  echo 'def  : [Define] Go to Definition (Space+d)'
  echo 'ref  : [Reference] Reference (Space+r)'
  echo 'o  : [Outline] view outline on popup (Space+o)'
  echo 'q  : [QuickFix-Grep] Open Preview Popup from quickfix - from fzfpreview Ctrl+Q'
  echo 'run: [Run] run current program'
  echo 's  : [Snippet] edit snippets'
  echo 'git  : [GIT] git actions'
  echo 'a  : [ALL PUSH] commit & push all changes'
  echo '==================================================================='
  let cmd = inputdialog(">>")
  if cmd == ''
    retu
  endif
  echo '<<'
  if cmd == 'r'
    cal CocActionAsync('rename')
    echo 'ok'
  elseif cmd == 'f'
    cal CocActionAsync('format')
    echo 'ok'
  elseif cmd == 'o'
    execute("CocCommand fzf-preview.CocOutline")
  elseif cmd == 'q'
    execute("CocCommand fzf-preview.QuickFix")
  elseif cmd == 'run'
    exe "QuickRun -hook/time/enable 1"
    echo 'ok'
  elseif cmd == 's'
    execute("CocCommand snippets.editSnippets")
  elseif cmd == 'git'
    execute("CocCommand fzf-preview.GitActions")
  elseif cmd == 'a'
    cal AllPush()
  endif
endf
nnoremap <Leader>? :cal CocAction('doHover')<CR>
nnoremap <Leader>, <plug>(coc-diagnostic-next)
nnoremap <Leader>. <plug>(coc-diagnostic-prev)

" execute line as shell
"nnoremap <Leader>sh :cal execute('top terminal ++rows=10 ++shell eval ' . getline('.'))<CR>

"}}}

" ========================================
" FUNCTION
" ========================================
" grep -----------{{{
fu! Grep() abort
  let w = inputdialog("word [target]>>")
  if w == ''
    retu
  endif
  echo '<<'
  execute('CocCommand fzf-preview.ProjectGrep -w --ignore-case '.w)
endf
" }}}

" git -----------{{{
fu! AllPush() abort
  let w = inputdialog("commit message>>")
  echo '<<'
  cal execute('top terminal ++rows=10 ++shell git add . && git commit -m "'.w.'" && git push')
endf
" }}}


" mark ----------------------------------------{{{
let g:mark_words = 'abcdefghijklmnopqrstuvwxyz'
fu! s:get_mark(tar) abort
  try
    retu execute('marks ' . a:tar)
  catch
    retu ''
  endtry
endf

fu! Marking() abort " mark auto word, toggle {{{
  let get_marks = s:get_mark(g:mark_words)
  if get_marks == ''
    execute('mark a')
    cal MarkShow()
    echo 'marked'
    retu
  endif
  let l:now_marks = []
  let l:warr = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
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
endf " }}}

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
    exe "sign define " . mchar . " text=" . mchar . " texthl=" . "ErrorMsg"
    exe "sign place " . id . " line=" . mark_dict[mchar] . " name=" . mchar . " file=" . expand("%:p")
  endfor
endf
aug sig_aus
  au!
  au BufEnter,CmdwinEnter * cal MarkShow()
aug END " }}}

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
endf "}}}

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

" }}}

" plugins --------------------------------------------{{{
" color
let s:colors = [
    \ 'hybrid_material.vim',
    \ 'molokai.vim',
    \ 'onedark.vim'
\ ]

" repo
let s:repos = [
    \ 'neoclide/coc.nvim',
    \ 'junegunn/fzf',
    \ 'junegunn/fzf.vim',
    \ 'kyoh86/vim-ripgrep',
    \ 'unblevable/quick-scope',
    \ 'easymotion/vim-easymotion',
    \ 'vim-airline/vim-airline',
    \ 'vim-airline/vim-airline-themes',
    \ 'sheerun/vim-polyglot',
    \ 'uiiaoo/java-syntax.vim',
    \ 'obcat/vim-hitspop',
    \ 't9md/vim-quickhl',
    \ 'tpope/vim-fugitive',
    \ 'airblade/vim-gitgutter',
    \ 'jiangmiao/auto-pairs',
    \ 'thinca/vim-quickrun',
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
    \ 'coc-python',
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
  execute("bo terminal ++shell echo 'start' && rm -rf ~/.vim ~/.config && echo 'end'")
endf
" }}}

" ========================================
" COMMAND
" ========================================
command! PlugInstall cal PlugInstall()
command! PlugInstallCoc cal PlugInstallCoc()
command! PlugUnInstall cal PlugUnInstall()

