all:
	@echo "Use 'make check PROJECT_NAME' to run tests for a specific project."

ifeq (check,$(firstword $(MAKECMDGOALS)))
  PROJECT_NAME := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))
  # do-nothing
  $(eval $(PROJECT_NAME):;@:)
endif

check:
	@echo "Running tests for project: $(PROJECT_NAME)"
	$(MAKE) -C $(PROJECT_NAME) test