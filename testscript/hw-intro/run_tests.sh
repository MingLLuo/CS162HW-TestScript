#!/bin/bash

# Path to the words binary
WORDS_BINARY=./word
TEST_SUITE_DIR=./test-suite

# Setup color variables
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Initialize counters
pass_count=0
fail_count=0

test_count() {
  echo "Testing total_count"
  run_total_count_test() {
    test_name=$1
    test_file="${TEST_SUITE_DIR}/${test_name}.txt"
    expected_count="The total number of words is: $2"

    # echo "Running total_count test: $test_name"
    count=$($WORDS_BINARY --count <"$test_file")
    if [ "$count" = "$expected_count" ]; then
      echo -e "${GREEN}PASS${NC}: $test_name is as expected."
      ((pass_count++))
    else
      echo -e "${RED}FAIL${NC}: $test_name is not as expected."
      # diff <(printf '%s\n' "$count") <(printf '%s\n' "$expected_count")
      echo "Expected:"
      echo "$expected_count"
      echo "Got:"
      echo "$count"
      ((fail_count++))
    fi
  }

  # Run the tests
  run_total_count_test "simple_test" 2
  run_total_count_test "single_char_word" 1
  run_total_count_test "really_long_word" 1
  run_total_count_test "punctuation" 0
  run_total_count_test "comprehensive" 7

}

test_frequency() {
  echo "Testing freq_count..."
  run_freq_count_test() {
    test_name=$1
    expected_output_file="${TEST_SUITE_DIR}/${test_name}_output.txt"
    test_input_file="${TEST_SUITE_DIR}/${test_name}.txt"

    # echo "Running freq_count test: $test_name"
    output=$($WORDS_BINARY --frequency <"$test_input_file")
    expected_output=$(echo -e "The frequencies of each word are: \n$(cat "$expected_output_file")")

    if [ "$output" = "$expected_output" ]; then
      echo -e "${GREEN}PASS${NC}: $test_name is as expected."
      ((pass_count++))
    else
      echo -e "${RED}FAIL${NC}: $test_name is not as expected."
      echo "Expected:"
      echo "$expected_output"
      echo "Got:"
      echo "$output"
      ((fail_count++))
    fi
  }

  run_freq_count_test "simple_freq"
  run_freq_count_test "sorted_freq"
  run_freq_count_test "single_char_freq"
  run_freq_count_test "eof_freq"
  run_freq_count_test "caps_punct_freq"
  run_freq_count_test "punct_galore_freq"
  run_freq_count_test "yelling_freq"
  run_freq_count_test "comprehensive_freq"
}

test_error() {
  echo "Testing error_handling..."

  # output = Error: Counld not open file non
  output=$($WORDS_BINARY -f Makefile non_existent_file.txt 2>&1)
  expected_output="Error: Counld not open file non_existent_file.txt"
  # Test for not existent file with one exist
  if [ "$output" = "$expected_output" ]; then
    echo -e "${GREEN}PASS${NC}: Handled missing file correctly."
    ((pass_count++))
  else
    echo -e "${RED}FAIL${NC}: Failed to handle missing file."
    ((fail_count++))
  fi

  # Test for out of memory handling
  output=$($WORDS_BINARY -f ${TEST_SUITE_DIR}/long_word_test.txt 2>&1)
  if [ "$output" = "" ]; then
    echo -e "${GREEN}PASS${NC}: Handled out of memory situation correctly."
    ((pass_count++))
  else
    echo -e "${RED}FAIL${NC}: The program did not fail as expected in out of memory situation."
    ((fail_count++))
  fi
}

# Run the tests
echo -e "\n${GREEN}Testing Start!!!${NC}"

test_count
test_frequency
test_error

# Print summary
echo -e "${GREEN}Passed tests: $pass_count${NC}"
echo -e "${RED}Failed tests: $fail_count${NC}"

if [ "$fail_count" -eq "0" ]; then
  echo "All tests passed."
else
  exit $fail_count
fi
