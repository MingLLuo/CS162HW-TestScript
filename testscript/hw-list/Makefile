.PHONY: all test clean build_executables

TEST_SOURCES=$(wildcard *.c)
TEST_BINARIES=$(TEST_SOURCES:.c=)
EXECUTABLES=words lwords pwords
CREATE_SCRIPT=./create.sh
TEST_SCRIPT=./run_tests.sh
TEST_SUITE=./test-suite
HW_LIST_DIR=../../hw-list

all: init

init: clean
	$(MAKE) -C $(HW_LIST_DIR) $(EXECUTABLES)
	for exec in $(EXECUTABLES); do \
		cp $(HW_LIST_DIR)/$$exec .; \
	done
	mkdir -p $(TEST_SUITE)
	cp -R $(HW_LIST_DIR)/gutenberg $(TEST_SUITE)
	chmod +x $(CREATE_SCRIPT) $(TEST_SCRIPT)
	$(CREATE_SCRIPT)
	@echo "init finish"

test: init
	$(TEST_SCRIPT)

clean:
	rm -rf $(TEST_BINARIES) $(EXECUTABLES) $(TEST_SUITE)
	$(MAKE) -C $(HW_LIST_DIR) clean
