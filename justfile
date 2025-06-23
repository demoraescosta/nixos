
format:
	alejandra . 

rebuild: format
	./rebuild

update: format
	nix flake update
	./rebuild

commit: format
	current=$(nixos-rebuild list-generations | grep True)
	printf "Curent generation: %s\n" "$current"
	git commit -am "$current"
