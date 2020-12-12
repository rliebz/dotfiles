rliebz's Dotfiles
=================

Don't follow these steps unless you want your commits to be signed with my
email address.

Install
-------

Requires `fish`, `git`, `python3`, and `curl`.

Start by running `fish`. If it's not already the default shell, run the
following and open a new terminal window:

    chsh -s $(which fish)

Clone into the appropriate directory:

    git clone https://github.com/rliebz/dotfiles.git $HOME/.dotfiles
    cd $HOME/.dotfiles

Run the installation script:

    ./install


Making Changes
--------------

After making any changes, or to update submodules:

    ./install

To add a new file:

1. Create a new file in this directory
2. Create an entry in install.conf.yaml


Local Customizations
--------------------

Fish will autoload files placed in the appropriate location. For everything
else, the following local dotfiles files are read automatically:

- `~/.gitconfig.local`
- `~/.vimrc.local`
