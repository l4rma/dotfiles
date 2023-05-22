# dotfiles
My dotfiles  
and a script to place them in $HOME/.config/

### tl;dr
run `./dotfile -s` to add all the dotfiles included.

## Dotfiles Script

```
Dotfiles version 0.4
A perl script placing symlinks of dotfiles in their respective .config/ directories.

Usage: dotfiles [OPTION]

Options:
	-l, --list:		Lists existing symlinks
	-s, --sync:		Syncs dotfiles, creating symlinks in .config/
	-f file:		Create symlink for file
	-h, --help:		Print this message
	-v, --version:	Print version
```

## Add path
To be able to use the script from anywhere add bin to path.  
In .zshrc or .bashrc (or other) add: ``$PATH=$PATH:$HOME/dotfiles/bin`` or create a symlink of the binary somewhere like "/usr/local/bin".




