function pman --description 'Open manpage in Preview.app'
    man -t $argv[1] | open -f -a /Applications/Preview.app
end
