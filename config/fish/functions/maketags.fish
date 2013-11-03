function maketags --description 'Generate tags file with ctags for current directory'
    ctags -f .tags -R *
end
