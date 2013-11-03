# not working
#function extract --description easy extraction
#    if [ -f $argv[1] ] ; then
#        case $argv[1] in
#            *.tar.bz2)   tar xvjf $argv[1]    ;;
#            *.tar.gz)    tar xvzf $argv[1]    ;;
#            *.bz2)       bunzip2 $argv[1]     ;;
#            *.rar)       unrar x $argv[1]     ;;
#            *.gz)        gunzip $argv[1]      ;;
#            *.tar)       tar xvf $argv[1]     ;;
#            *.tbz2)      tar xvjf $argv[1]    ;;
#            *.tgz)       tar xvzf $argv[1]    ;;
#            *.zip)       unzip $argv[1]       ;;
#            *.Z)         uncompress $argv[1]  ;;
#            *.7z)        7z x $argv[1]        ;;
#            *)           echo "don't know how to extract '$argv[1]'..." ;;
#        esac
#    else
#        echo "'$argv[1]' is not a valid file!"
#    fi
#end
