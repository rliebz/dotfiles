rliebz's Dotfiles
=================

Don't follow these steps unless you are me.

Dependencies
------------

First, homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow the eval instruction in terminal to add it to the path temporarily. It
probably looks like this:

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Next, set up fish:

```bash
brew install fish
echo "$(which fish)" | sudo tee -a /etc/shells
chsh -s "$(which fish)"
```

Open a new shell to use fish. A restart will eventually be necessary for Kitty.

Next, add homebrew to the path:

```fish
fish_add_path -g /opt/homebrew/bin
```


Installation
------------

Clone into the appropriate directory:

```fish
git clone git@github.com:rliebz/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles
```

With that, the dotfiles can be installed:

```fish
./install
```


Recommended Software
--------------------

To install all the normal CLI tools:

```fish
brew tap rliebz/tusk
brew install bat curl fzf git gnu-sed neovim ripgrep trash tusk
```

And the desktop applications:

```fish
brew install --cask bitwarden docker firefox keepingyouawake kitty
```


MacOS System Preferences
------------------------

The usual steps are:
1. Trackpad > Tracking Speed: Set to the second notch from the right
1. Keyboard > Keyboard > Key Repeat: Farthest notch ont he right
1. Keyboard > Keyboard > Delay Until Repeat: Second notch from the right
1. Keyboard > Text: Turn basically everything off
1. Accessibility > Pointer Control > Trackpad Options: Enable dragging with
   three finger drag
1. Dock & Menu Bar > Bluetooth: Show in Menu Bar
1. Dock & Menu Bar > Dock & Menu Bar: Turn off Show recent applications in dock


Making Changes
--------------

After making any changes, or to update submodules:

```fish
./install
```

To add a new file:

1. Create a new file in this directory
1. Create an entry in install.conf.yaml


Local Customizations
--------------------

Fish will autoload files placed in the appropriate location. For everything
else, the following local dotfiles files are read automatically:

- `~/.gitconfig.local`
- `~/.vimrc.lua`
