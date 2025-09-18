# rliebz's Dotfiles

Don't follow these steps unless you are me.

## System

### macOS System Preferences

The usual steps are:

1. Trackpad > Tracking Speed: Set to the second notch from the right
1. Keyboard > Keyboard > Key Repeat: Farthest notch on the right
1. Keyboard > Keyboard > Delay Until Repeat: Second notch from the right
1. Keyboard > Text Input: Turn basically everything off
1. Accessibility > Pointer Control > Trackpad Options: Enable dragging with
   three finger drag
1. Control Center > Bluetooth: Show in Menu Bar
1. Desktop & Dock > Dock: Turn off Show suggested and recent apps in Dock
1. Desktop & Dock > Mission Control: Turn off Automatically rearrange Spaces
   based on most recent use
1. Appearance > Appearance: Dark
1. Sound > Sound Effects > Alert volume: Set to the middle notch

### Fonts

- JetBrains Mono NL: <https://www.jetbrains.com/lp/mono/>
- NerdFontsSymbolsOnly: <https://github.com/ryanoasis/nerd-fonts/releases>

### macOS Dependencies

First, homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow the eval instruction in terminal to add it to the path temporarily. It
probably looks like this:

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

To install all the usual software:

```bash
brew install dotbot fish git gnu-sed gpg mise trash zoxide rliebz/tusk/tusk
brew install --cask bitwarden docker firefox keepingyouawake ghostty
```

Don't swap to Fish or Ghostty yet.

### Installation

First we'll need to set up an SSH key:

```bash
ssh-keygen -t ed25519 -C "rliebz@gmail.com"
```

[Navigate here][github-ssh] to add a new SSH key, then grab local public key:

```bash
cat ~/.ssh/id_ed25519.pub | pbcopy
```

Clone this repo into the appropriate directory:

```bash
git clone git@github.com:rliebz/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles
```

With that, the dotfiles can be installed:

```bash
./scripts/install
```

Finally, set up fish:

```bash
echo "$(which fish)" | sudo tee -a /etc/shells
chsh -s "$(which fish)"
```

Swap to Ghostty now.

## Making Changes

After making any changes:

```fish
./scripts/install
```

To add a new file:

1. Create a new file in this directory
1. Create an entry in install.conf.yaml

## Local Customizations

Fish will autoload files placed in the appropriate location. For everything
else, the following local dotfiles files are read automatically:

- `~/.gitconfig.local`
- `~/.vimrc.lua`

[github-ssh]: https://github.com/settings/ssh/new
