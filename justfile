
format:
	alejandra . 1> /dev/null

rebuild: format
	./rebuild

update: format
	nix flake update
	./rebuild

commit: format
	printf "Curent generation: %s\n" $(nixos-rebuild list-generations | grep True)  
	git commit -am '$(nixos-rebuild list-generations | grep True)'
