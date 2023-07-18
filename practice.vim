colorscheme torte
mapc

" to practice, allow only primitive keymap

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

" row-move
nnoremap j gj
nnoremap k gk
nnoremap <Tab> 5gj
nnoremap <S-Tab> 5gk
vnoremap <Tab> 5gj
vnoremap <S-Tab> 5gk
" scroll
nnoremap <silent><C-u> :cal Scroll(0, 25)<CR>
nnoremap <silent><C-d> :cal Scroll(1, 25)<CR>
nnoremap <silent><C-b> :cal Scroll(0, 10)<CR>
nnoremap <silent><C-f> :cal Scroll(1, 10)<CR>

" search
nnoremap <silent><Leader>q :noh<CR>

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

