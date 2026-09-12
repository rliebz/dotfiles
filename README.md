# rliebz's Dotfiles

Don't follow these steps unless you are me.

## System

### Getting Started

Install the xcode-select command-line tools:

```zsh
xcode-select --install
```

Clone the repo over HTTPS:

```zsh
git clone https://github.com/rliebz/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles
```

### macOS System Preferences

To configure macOS defaults:

```zsh
./scripts/macos-defaults
```

Log out and back in for all changes to take effect.

### Fonts

- JetBrains Mono NL: <https://www.jetbrains.com/lp/mono/>
- NerdFontsSymbolsOnly: <https://github.com/ryanoasis/nerd-fonts/releases>

### macOS Dependencies

First, homebrew:

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow the eval instruction in terminal to add it to the path temporarily. It
probably looks like this:

```zsh
eval "$(/opt/homebrew/bin/brew shellenv)"
```

To install all the usual software:

```zsh
brew install -y dotbot fish git gnu-sed gpg mise trash zoxide rliebz/tusk/tusk
brew install -y --cask bitwarden docker firefox keepingyouawake ghostty
rm ~/.config/fish/config.fish
```

Don't swap to Fish or Ghostty yet.

### Installation

First we'll need to set up an SSH key:

```zsh
ssh-keygen -t ed25519 -C "rliebz@gmail.com"
```

[Navigate here][github-ssh] to add a new SSH key, then grab local public key:

```zsh
cat ~/.ssh/id_ed25519.pub | pbcopy
```

Swap the repo to use SSH:

```zsh
git remote set-url origin git@github.com:rliebz/dotfiles.git
```

With that, the dotfiles can be installed:

```zsh
./scripts/install
```

Finally, set up fish:

```zsh
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
