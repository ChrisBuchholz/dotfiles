function dim
    if hash mvim 2>/dev/null
        mvim -v $argv
    else
        vim $argv
    end
end
