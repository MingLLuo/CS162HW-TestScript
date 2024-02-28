.PHONY: all test clean build_executables init

TEST_SOURCES=$(wildcard *.c)
TEST_BINARIES=$(TEST_SOURCES:.c=)
EXECUTABLES=shell
TEST_SCRIPT=./run_tests.sh
TEST_SUITE=./test-suite
HW_SHELL_DIR=../../hw-shell
HW_LIST_DIR=../../hw-list

all: init

init: clean build_executables
	mkdir -p $(TEST_SUITE)
	cp -R $(HW_LIST_DIR)/gutenberg $(TEST_SUITE)
	chmod +x  $(TEST_SCRIPT)
	@echo "Initialization finished."

build_executables:
	$(MAKE) -C $(HW_SHELL_DIR) $(EXECUTABLES)
	for exec in $(EXECUTABLES); do \
		cp $(HW_SHELL_DIR)/$$exec .; \
	done

test: init
	$(TEST_SCRIPT)

clean:
	rm -rf $(TEST_BINARIES) $(EXECUTABLES) $(TEST_SUITE)
	$(MAKE) -C $(HW_SHELL_DIR) clean
	@echo "Cleanup completed."
