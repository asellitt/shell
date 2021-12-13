# Dotfiles

What happens when you're tired of copying/pasting the same stuff into every bashrc file?

You make a repo!

What happens when a friend of yours talks up GitHub?

You make github repo!

## Installation

### Ensure the machine's SSH Key is known to github

#### Create SSH Key

```bash
ssh-keygen -t rsa -b 4096 -C "asellitt@newmachine.com"
eval "$(ssh-agent -s)"
ssh-add -K ~/.ssh/id_rsa
pbcopy < ~/.ssh/id_rsa.pub
```

#### Add SSH Key

```
Profile Pic
    > Settings
        > SSH and GPG keys
            > Add SSH key
                > Name key/Pate Key
                    > Add
```

### Fetch `shell` and run

```bash
git clone https://github.com/asellitt/shell.git
shell/install.sh -u -l -i
```

## Usage

```bash
dotfiles -h

asellitt's dotfiles install script

usage: dotfiles [-b|--banner bannerFile]
                [-h|--help]
                [-u|--update]
                [-l|--license]
```

## Manual Installs

* [Sublime Text 3 (Dev)](https://www.sublimetext.com/3dev) No cask for this, license required.
* [XChode](https://itunes.apple.com/au/app/xcode/id497799835?mt=12) Version 8 or higher (required for `mas`)
