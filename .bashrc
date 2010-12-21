# Check for an interactive session
[ -z "$PS1" ] && return

PATH=/home/cb/bin:$PATH

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Set $TERM for libvte terminals that set $TERM wrong (like gnome-terminal) 
{ 
    [ "_$TERM" = "_xterm" ] && type ldd && type grep && type tput && [ -L "/proc/$PPID/exe" ] && { 
        if ldd /proc/$PPID/exe | grep libvte; then 
            if [ "`tput -Tgnome-256color colors`" = "256" ]; then 
                TERM=gnome-256color 
            elif [ "`tput -Txterm-256color colors`" = "256" ]; then 
                TERM=xterm-256color 
            elif tput -T gnome; then 
                TERM=gnome 
            fi 
        fi 
    } 
} >/dev/null 2>/dev/null
