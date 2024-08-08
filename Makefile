link:
	@echo "Setting symlinks"
	@stow src

unlink:
	@echo "Removing symlinks"
	@stow -D src

list:
	@tree -a -I ".git|plugins"
