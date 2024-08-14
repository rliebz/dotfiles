# rliebz's Dotfiles

Don't follow these steps unless you are me.

## System

### MacOS System Preferences

The usual steps are:

1. Trackpad > Tracking Speed: Set to the second notch from the right
1. Keyboard > Keyboard > Key Repeat: Farthest notch on the right
1. Keyboard > Keyboard > Delay Until Repeat: Second notch from the right
1. Keyboard > Text: Turn basically everything off
1. Accessibility > Pointer Control > Trackpad Options: Enable dragging with
   three finger drag
1. Dock & Menu Bar > Bluetooth: Show in Menu Bar
1. Dock & Menu Bar > Dock & Menu Bar: Turn off Show recent applications in dock

### Fonts

- JetBrains Mono NL: <https://www.jetbrains.com/lp/mono/>
- NerdFontsSymbolsOnly: <https://github.com/ryanoasis/nerd-fonts/releases>

## Command-Line

### Dependencies

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

```fish
brew install curl fzf git gnu-sed go gpg neovim python ripgrep selene trash rliebz/tusk/tusk
brew install --HEAD neovim
brew install --cask bitwarden docker firefox keepingyouawake kitty
```

Next install the JetBrains Mono Nerd Font here:
<https://www.nerdfonts.com/font-downloads>

Don't swap to Fish or Kitty yet.

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

```fish
git clone git@github.com:rliebz/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles
```

With that, the dotfiles can be installed:

```fish
./scripts/install
```

Finally, set up fish:

```bash
echo "$(which fish)" | sudo tee -a /etc/shells
chsh -s "$(which fish)"
```

Swap to kitty now.

[github-ssh]: https://github.com/settings/ssh/new

## Making Changes

After making any changes, or to update submodules:

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
