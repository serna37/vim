# dependency
- git
- node
- yarn
- ripgrep
- bat (option: fzf-preview color)
- [powerline/fonts](https://github.com/powerline/fonts) (option: font)
- [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts) (option: font)
- [ryanoasis/vim-devicons](https://github.com/ryanoasis/vim-devicons) (option: icon)

# installation
1. get this vimrc
```sh
curl https://raw.githubusercontent.com/serna37/vim/master/.vimrc > ~/.vimrc
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
  "explorer.file.showHiddenFiles": true
}
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
# Basic
- normal vim
- fzf popup window

# WINDOW
- Ctrl + q/n : prev / next buffer
- Space x : close buffer
- Ctrl + hjkl : move window forcus
- ↑↓←→ : resize window
- Space t : terminal (bottom)
- Space z : zen mode

# MOTION
- tab / Shift-tab : 5row jump
- Ctrl + udfb : comfortable scroll
- Space w : f-scope toggle

# SEARCH
## file search
- Space e : explorer
- Space f : fuzzy finder files / git files
- Space h : fuzzy finder history
- Space b : fuzzy finder buffer

## word serch
- s : jump word with easy-motion
- Space s : incremental search word with easy-motion
- Space Space s : grep interactive from current buffer (coc-lists)
- \* : search word (original vim but dont move cursor)
- \# : search word (original vim but dont move cursor)
- Space q : quit search highlight
- Space g : grep interactive Recursive (ripgrep)

## jump/mark
- mm : marking toggle
- m p/n : prev/next mark
- mc : clear mark
- Space m : show mark list (coc fzf-preview)
- Space l : line (= NUM+G, but preview window)
- Space j : jumped history
- Space c : changed line

# EDIT
- (visual mode) Ctrl jk : move line
- (insert mode) Ctrl hljk : move cursor

# IDE
- Space v : IDE functions menu
- Space d : go to definition
- Space r : (popup) find references
- Space o : (popup) outline
- Space ? : hover document
- Space , : prev diagnostic
- Space . : next diagnostic

# on popup (default keymap)
- Ctrl + n/p : chose down/up
- Ctrl + d/u : preview down/up
- Tab : select
- Ctrl + q : selections -> quickfix
(with quickfix -> fzf-preview.QuickFix)
