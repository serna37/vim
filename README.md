# demo
[放置popup](./放置popup.mov)
# dependency
- vim 9.0~ +python Huge (should get from [repo](https://github.com/vim/vim) and complie)
- git
- node
- yarn
- ripgrep
- bat (option: fzf-preview color)
- [powerline/fonts](https://github.com/powerline/fonts) (option: font)
- [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts) (option: font)
- [ryanoasis/vim-devicons](https://github.com/ryanoasis/vim-devicons) (option: icon)

# installation
0. get vim
```sh
git clone --depth 1 https://github.com/vim/vim.git \
&& cd vim \
./configure --with-features=huge --enable-python3interp=dynamic \
&& sudo make && sudo make install \
&& vim --version
```
1. get this vimrc
```sh
curl https://raw.githubusercontent.com/serna37/vim/master/.vimrc > ~/.vimrc
```
or
```sh
git clone --depth 1 https://github.com/serna37/vim
ln -s vim/.vimrc ~/.vimrc
```
2. execute command on vim
```
:PlugInstall
```
3. after reboot vim, execute command
```
:PlugInstallCoc
```
4. open 'coc-setting.json' by this command, and edit
```
:CocConfig
```
```json
{
  "snippets.ultisnips.pythonPrompt": false,
  "explorer.icon.enableNerdfont": true,
  "explorer.file.showHiddenFiles": true,
  "python.formatting.provider": "yapf",
  "pyright.inlayHints.variableTypes": false
}
```
※ I chose yapf for python formatter, so need `python -m pip install yapf`

5. setup [copilot](https://github.com/github/copilot.vim)
```
:Copilot setup
```

<details>
<summary>(old) monolithic version</summary>
# monolithic version
[feature] no plugin, all function is on this vimrc.
or (exclude plugin mode)
curl https://raw.githubusercontent.com/serna37/vim/master/monolithic.vim > ~/.vimrc

```monolithic initiation.vim
<Space>n Azathoth<CR>
```

# snippet(for v-snip)
for vsnip, this is "create snippet" snippet

```vsnip.json
{
    "sni": {
        "prefix": ["sni"],
        "body": [
            ",\"${1}\": {"
            ,"  \"prefix\": [\"${2}\"],"
            ,"  \"body\": [\"${3}\"]"
            ,"}"
        ]
    }

}
```

</details>

# My action cheat sheet
## Basic
- normal vim
- fzf popup window

## WINDOW
- Ctrl + q/n : prev / next buffer
- Space x : close buffer
- Ctrl + hjkl : move window forcus
- ↑↓←→ : resize window
- Space t : terminal (bottom)
- Space z : zen mode

## MOTION
- tab / Shift-tab : 5row jump
- Ctrl + udfb : comfortable scroll
- Space w : f-scope toggle

## SEARCH
### file search
- Space e : explorer
- Space f : fuzzy finder files / git files
- Space h : fuzzy finder history
- Space b : fuzzy finder buffer

### word serch
- s : jump word with easy-motion
- Space s : incremental search word with easy-motion
- Space Space s : grep interactive from current buffer (coc-lists)
- \* : search word (original vim but dont move cursor)
- \# : search word (original vim but dont move cursor)
- Space q : quit search highlight
- Space g : grep interactive Recursive (ripgrep)

### jump/mark
- mm : marking toggle
- m p/n : prev/next mark
- mc : clear mark
- Space m : show mark list (coc fzf-preview)
- Space l : line (= NUM+G, but preview window)
- Space j : jumped history
- Space c : changed line

## EDIT
- (visual mode) Ctrl jk : move line
- (insert mode) Ctrl hljk : move cursor

## IDE
- Space v : IDE functions menu
(explain shortcut on popup window)

## on popup (default keymap)
- Ctrl + n/p : chose down/up
- Ctrl + d/u : preview down/up
- Tab : select
- Ctrl + q : selections -> quickfix
(with quickfix -> fzf-preview.QuickFix)

# plugins
- junegunn/fzf
- junegunn/fzf.vim
- neoclide/coc.nvim
- unblevable/quick-scope
- easymotion/vim-easymotion
- obcat/vim-hitspop
- t9md/vim-quickhl
- MattesGroeger/vim-bookmarks
- jiangmiao/auto-pairs
- markonm/traces.vim
- tpope/vim-fugitive
- airblade/vim-gitgutter
- mhinz/vim-startify
- vim-airline/vim-airline
- vim-airline/vim-airline-themes
- sheerun/vim-polyglot
- uiiaoo/java-syntax.vim
- thinca/vim-quickrun
- puremourning/vimspector
- junegunn/goyo.vim
- junegunn/limelight.vim

# plugins from CocInstall
- coc-explorer
- coc-lists
- coc-fzf-preview
- coc-snippets
- coc-sh
- coc-vimlsp
- coc-json
- coc-sql
- coc-html
- coc-css
- coc-tsserver
- coc-clangd
- coc-go
- coc-pyright
- coc-java

# debug
1. custom DAP adaptors on vimrc. all list is [here](https://github.com/puremourning/vimspector#supported-languages)
```.vimrc
let g:vimspector_install_gadgets = [ 'debugpy', 'CodeLLDB', 'delve', 'vscode-js-debug' ]
```
2. install gadget by vim command
```
:VimspectorInstall
```
3. create .vimspector.json on project root
```sh
curl https://raw.githubusercontent.com/serna37/vim/master/.vimspector.json > .vimspector.json
```
4. keymap is [here](https://github.com/puremourning/vimspector#visual-studio--vscode)

※ kind of Server hosting program cannot debug... only java can with `request: attach` [ref](https://zenn.dev/urawa72/articles/d942c96241200fd9adda#%E3%83%87%E3%83%90%E3%83%83%E3%82%B0)
