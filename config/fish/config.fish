# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme robbyrussell

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

set -x PATH /usr/local/bin $PATH
set -x PATH $HOME/.local/bin $PATH
set -x PATH $HOME/Gophings/bin $PATH
set -x PATH $HOME/.gem/ruby/*/bin $PATH
set -x PATH $HOME/.rvm/bin $PATH # Add RVM to PATH for scripting
set -x PATH $HOME/.cabal/bin: $PATH

set -x GOPATH $HOME/Gophings $GOPATH
set -x MANPATH $HOMEBREWDIR/share/man $MANPATH

set -x VISUAL vim
set -x EDITOR vim
set -x LANG "da_DK.UTF-8"
set -x LC_ALL "da_DK.UTF-8"
set -x CLICOLOR 1
set -x GPGKEY 7EA01D78
set -x GREP_OPTIONS '--color=auto'
set -x TERM xterm-256color
