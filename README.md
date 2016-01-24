rliebz's Dotfiles
=================

Install
-------

Clone onto your laptop:

    git clone git://github.com/thoughtbot/dotfiles.git

Install [rcm](https://github.com/thoughtbot/rcm):

    brew tap thoughtbot/formulae
    brew install rcm

Run the installation script:

    ./dotfiles/install

You should run `rcup` after pulling a new version of the repository to symlink
any new files in the repository.

    rcup


Local Customizations
--------------------

For overriding dotfiles, place a newer version in `~/.dotfiles/local`. This
won't be version controlled.

To utilize a local dotfile without overriding existing configuration, place it
in your home directory as a dotfile with the suffix `.local`. The following
local dotfiles files are supported:

- ~/.gitconfig.local
- ~/.vimrc.local
- ~/.zshrc.local
- ~/.zsh/configs/*
