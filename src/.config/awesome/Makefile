.PHONY: dev format

dev:
	@bin/awdebug

format:
	@stylua .
	@git diff --color . | cat
