
format:
    alejandra . 1> /dev/null

rebuild:
    ./rebuild

update:
    nix flake update
    sudo ./rebuild

commit:
    ./commit
    
