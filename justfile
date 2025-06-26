
format:
    alejandra . 1> /dev/null

rebuild:
    ./rebuild

update: format
    nix flake update
    sudo ./rebuild

commit: format
    ./commit
    
