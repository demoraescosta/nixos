
format:
    alejandra . 1> /dev/null

rebuild:
    ./rebuild

update:
    sudo nix flake update
    ./rebuild

commit:
    ./commit
    
