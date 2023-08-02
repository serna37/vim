# Demo (only vimrc)
WIP

# Demo (plugin mode)
WIP

# Dependencies
- vim 8.2~

# Plugin's dependencies
if install plugins by `:PlugInstall` command, need here.<br>
also see [wiki-plugins-list](https://github.com/serna37/vim/wiki/Plugins)

|plugins|dependencies|
|--|--|
|[coc.nvim](https://github.com/neoclide/coc.nvim)|<ul><li>[node.js](https://github.com/nodejs/node)<li>yarn: `npm install -g yarn`|
|language server with coc|see [here](https://github.com/neoclide/coc.nvim/wiki/Language-servers)|
|[vimspector](https://github.com/puremourning/vimspector)|Vim 8.2 Huge build compiled with Python 3.10 or later<br>※also see [here](https://github.com/puremourning/vimspector#dependencies)|

# Recommendation commands / packages
|command / package|purpose|use in vim if include|
|--|--|--|
|[lazygit](https://github.com/jesseduffield/lazygit)|GUI git operations<br>※please use on termianl window|<ul><li>[ ] </ul>|
|[ripgrep](https://github.com/BurntSushi/ripgrep)|fast grep by Rust|<ul><li>[x] </ul>|
|[bat](https://github.com/sharkdp/bat)|fzf preview syntax highlight|<ul><li>[x] </ul>|
|[powerline/fonts](https://github.com/powerline/fonts)|font|<ul><li>[x] </ul>|
|[ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts)|font|<ul><li>[x] </ul>|
|[ryanoasis/vim-devicons](https://github.com/ryanoasis/vim-devicons)|icon|<ul><li>[x] </ul>|

# Installation
## 1. get vim 8.2~
```sh
brew install vim
```
or
```sh
git clone --depth 1 https://github.com/vim/vim.git \
&& cd vim \
&& ./configure --with-features=huge --enable-python3interp=dynamic \
&& sudo make && sudo make install \
&& vim --version
```
## 2. get this vimrc
```sh
git clone --depth 1 https://github.com/serna37/vim && ln -s vim/.vimrc ~/.vimrc
echo '[optional] colorscheme' && mkdir -p ~/.vim/colors && cp -f vim/onedark.vim ~/.vim/colors
```
or
```sh
curl https://raw.githubusercontent.com/serna37/vim/master/.vimrc > ~/.vimrc

```
## 3. [optional] execute command on vim
```
:PlugInstall
```
other commands / keymaps details are in cheat sheet.<br>
※ I chose yapf for python formatter, so need `python -m pip install yapf`

## 4. [optional] setup [copilot](https://github.com/github/copilot.vim)
```
:Copilot setup
```

# How to use
see [wiki-cheat-sheet](https://github.com/serna37/vim/wiki/Cheat-Sheet)<br>
also see [wiki-debug](https://github.com/serna37/vim/wiki/Debug)

# Inspired plugins
- [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim)
- [vim-airline](https://github.com/vim-airline/vim-airline)
- [simeji/winresizer](https://github.com/simeji/winresizer)
- [yuttie/comfortable-motion.vim](https://github.com/yuttie/comfortable-motion.vim)
- [MattesGroeger/vim-bookmarks](https://github.com/MattesGroeger/vim-bookmarks)
- [preservim/nerdtree](https://github.com/preservim/nerdtree)
- [unblevable/quick-scope](https://github.com/unblevable/quick-scope)
- [t9md/vim-quickhl](https://github.com/t9md/vim-quickhl)
- [jiangmiao/auto-pairs](https://github.com/jiangmiao/auto-pairs)
- [mhinz/vim-startify](https://github.com/mhinz/vim-startify)
- [easymotion/vim-easymotion](https://github.com/easymotion/vim-easymotion)
- [junegunn/goyo.vim](https://github.com/junegunn/goyo.vim)
- [junegunn/limelight.vim](https://github.com/junegunn/limelight.vim)

# Original
- cheat sheet
- TrainingWheelsProtocol
- PlugInstall / PlugUnInstall
- IDE menu
- interactive grep
- popup terminal


