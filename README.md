# dotfiles

## Setting up

Install vim
```
apt install vim
```

Install node

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
```

```
nvm install node
```

Install package manager:
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Copy `.vimrc` file to your home directory

```
cp .vimrc ~/
```

### Install preconfigured packages

Inside vim, type this in command:

```
:PlugInstall
```

### Vim C lang support

Inside vim, type this in command mode (press `/`):

```
:CocInstall coc-clangd
```

## (optional)

```
stow -S .
```

```
stow -R .
```
