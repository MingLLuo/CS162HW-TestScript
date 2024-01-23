.PHONY: all test clean

CC?=gcc
CFLAGS?=-Wall -Werror -g3
TEST_SOURCES=$(wildcard *.c)
TEST_BINARIES=$(TEST_SOURCES:.c=)
WORDS_BINARY=word
CREATE_SCRIPT=./create.sh
TEST_SCRIPT=./run_tests.sh

all: test

$(WORDS_BINARY):
	$(MAKE) -C ../../hw-intro/words
	mv ../../hw-intro/words/words word

test: $(WORDS_BINARY)

	chmod +x $(CREATE_SCRIPT) $(TEST_SCRIPT)
	$(CREATE_SCRIPT)
	$(TEST_SCRIPT)

clean:
	rm -f $(TEST_BINARIES)
	rm -f word
	$(MAKE) -C ../../hw-intro/words clean
