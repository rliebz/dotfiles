rliebz's Dotfiles
=================

Install
-------

Clone onto your laptop:

    $ git clone https://gitlab.com/rliebz/dotfiles.git

Install [rcm](https://github.com/thoughtbot/rcm):

    $ brew tap thoughtbot/formulae
    $ brew install rcm

Run the installation script:

    $ ./dotfiles/install

You should run `rcup` after pulling a new version of the repository to symlink
any new files in the repository.

    $ rcup


Making Changes
--------------

To add a new file to your dotfiles:

1. Create a new file in the `~/.dotfiles` directory.
    - New `zsh` files should go in one of the subdirectories under `zsh/`,
      depending on its purpose.
    - Do not include a leading period in the file name.
2. Run `rcup`.

To add a new Vim package:

    $ cd vim/bundle
    $ git submodule add <git-repo-url>
    $ rcup

To update to the latest submodules:

    $ git submodule update --recursive --remote


Local Customizations
--------------------

For overriding dotfiles, place a newer version in `~/.dotfiles-local`. This
won't be version controlled.

To utilize a local dotfile without overriding existing configuration, place it
in your home directory as a dotfile with the suffix `.local`. Note that these
go directly in your home directory and **not** in `~/.dotfiles`. The following
local dotfiles files are supported:

- `~/.gitconfig.local`
- `~/.vimrc.local`
- `~/.zshrc.local`
- `~/.zsh/configs/*`

After finishing, run:

    $ rcup
