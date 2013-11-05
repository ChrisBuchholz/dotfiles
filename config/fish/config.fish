# Set up paths ----------------------------------------------------------------

set -gx PATH $HOME/.local/bin /usr/local/sbin /usr/local/bin /usr/local/share/python3 /usr/local/share/python /usr/local/share/npm/bin $PATH
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH $HOME/.gem/ruby/*/bin $PATH
set -gx PATH /usr/local/Cellar/ruby/2.0.0-p247/bin $PATH
set -gx PATH $HOME/.cabal/bin $PATH
set -gx PATH /usr/local/Cellar/python/*/bin $PATH
set -gx PATH /usr/local/Cellar/python3/*/bin $PATH
set -gx PATH $HOME/.go/bin $HOME/Gophings/bin $PATH

set -gx MANPATH $HOMEBREWDIR/share/man $MANPATH

set -gx GOPATH $HOME/.go $HOME/Gophings $GOPATH

set -gx NODE_PATH "/usr/local/lib/node_modules"

set -gx LESS -RFX

# Configure fish --------------------------------------------------------------

set -gx EDITOR vim
set -gx VISUAL vim
set -gx GPGKEY 7EA01D78
set -gx GREP_OPTIONS '--color=auto'

set fish_greeting ""

# oh-my-fish ------------------------------------------------------------------

# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme jacanotsomuch

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler
set fish_plugins brew

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

# Aliases ---------------------------------------------------------------------

alias ips "ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias httpdump "sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias server 'open http://localhost:8080/ & python -m SimpleHTTPServer 8080'
alias sniff "sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias sshtnnl 'ssh -D 8080 -f -C -q -N -p 443' # ssh tunnel on port 8080
alias ip 'dig +short myip.opendns.com @resolver1.opendns.com'
alias localip 'ipconfig getifaddr en0'
alias flush 'dscacheutil -flushcache'
alias tmux 'tmux -2'
alias ltop 'top -F -R -o cpu'
alias ql 'qlmanage -p 2>/dev/null' # quicklook
hash mvim 2>/dev/null & alias vim 'mvim -v' # alias vim to terminal mvim if mvim is available
