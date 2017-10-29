rliebz's Dotfiles
=================

Install
-------

Clone onto your machine:

    git clone https://gitlab.com/rliebz/dotfiles.git $HOME/.dotfiles
    cd $HOME/.dotfiles

Run the installation script:

    ./install

You may also want to change your default shell:

    chsh -s $(which zsh)


Making Changes
--------------

After making any changes, or to update submodules:

    ./install

To add a new file to your dotfiles:

1. Create a new file in the `~/.dotfiles` directory.
    - New `zsh` files should go in one of the subdirectories under `zsh/`
    - Do not include a leading period in the file name
2. Create an entry in install.conf.yaml

To add a new Vim package:

    cd vim/bundle
    git submodule add <git-repo-url>


Local Customizations
--------------------

For overriding dotfiles, place a newer version in `~/.dotfiles-local`. This
can be version controlled separately or excluded from version control. Then,
follow the instructions at https://github.com/anishathalye/dotbot to link any
desired files to your home directory.

To utilize a local dotfile without overriding existing configuration, place it
in your home directory as a dotfile with the suffix `.local`. These can either
go directly in your home directory or in `~/.dotfiles-local`.

The following local dotfiles files are supported:

- `~/.gitconfig.local`
- `~/.vimrc.local`
- `~/.zshrc.local`
- `~/.secrets.local`
- `~/.zsh/configs/*`
