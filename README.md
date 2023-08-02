# Dependencies
- vim 8.2~
- git

# Recommendation commands / packages
|command / package|purpose|use in vim if include|
|--|--|--|
|[lazygit](https://github.com/jesseduffield/lazygit)|GUI git operations<br>※please use on termianl window|<ul><li>[ ] </ul>|
|[ripgrep](https://github.com/BurntSushi/ripgrep)|fast grep by Rust|<ul><li>[x] </ul>|
|[bat](https://github.com/sharkdp/bat)|fzf preview syntax highlight|<ul><li>[x] </ul>|
|[powerline/fonts](https://github.com/powerline/fonts)|font|<ul><li>[x] </ul>|
|[ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts)|font|<ul><li>[x] </ul>|
|[ryanoasis/vim-devicons](https://github.com/ryanoasis/vim-devicons)|icon|<ul><li>[x] </ul>|

# Plugin's dependencies
|plugins|dependencies|
|--|--|
|[coc.nvim](https://github.com/neoclide/coc.nvim)|<ul><li>[node.js](https://github.com/nodejs/node)<li>yarn: `npm install -g yarn`|
|language server with coc|see [here](https://github.com/neoclide/coc.nvim/wiki/Language-servers)|
|[vimspector](https://github.com/puremourning/vimspector)|Vim 8.2 Huge build compiled with Python 3.10 or later<br>※also see [here](https://github.com/puremourning/vimspector#dependencies)|

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
see wiki
TODO
