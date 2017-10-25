# DebOps Makefile

.PHONY: all
all:

.PHONY: help
help:
	@printf "%s\n" "Useful targets:"
	@egrep '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  make %-20s\033[0m %s\n", $$1, $$2}'

.PHONY: clean
clean:          ## Clean up project directory
clean: clean-tests

.PHONY: tests
tests:          ## Test code in the repository
tests: test-debops-tools

.PHONY: clean-tests
clean-tests:    ## Clean up test artifacts
	@rm -vrf .coverage

.PHONY: test-debops-tools
test-debops-tools:
	@printf "%s\n" "Testing debops-tools using pycodestyle..."
	@pycodestyle --show-source --statistics lib/debops-tools
	@printf "%s\n" "Testing debops-tools using nose2..."
	@nose2 --start-dir=lib/debops-tools --with-coverage