
format:
	alejandra . 1> /dev/null

rebuild: format
	./rebuild

update: format
	nix flake update
	./rebuild

commit: format
    ./commit
    
