#!/bin/bash

LWORDS_BINARY="./lwords"
PWORDS_BINARY="./pwords"
WORDS_BINARY="./words"
INPUT_DIR="./test-suite/inputs"
OUTPUT_DIR="./test-suite/outputs"

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

pass_count=0
fail_count=0

echo "Tested with redundant symbols removed for comparison"

format_output() {
  echo "$1" | sed -E 's/^[[:space:]]+|[[:space:]]+$//g' | tr -s ' ' | sort
}

run_and_compare() {
  binary=$1
  test_case=$2
  type=$3
  input_file="$INPUT_DIR/${test_case}.txt"
  expected_output_file="$OUTPUT_DIR/${test_case}_output.txt"

  TIMEFORMAT=%R
  exec_time=$({ time $binary <"$input_file" >/dev/null; } 2>&1)
  actual_output=$(cat "$input_file" | $binary)
  actual_output_formatted=$(format_output "$actual_output")

  expected_output=$(cat "$expected_output_file")
  expected_output_formatted=$(format_output "$expected_output")

  if diff <(echo "$actual_output_formatted") <(echo "$expected_output_formatted") >/dev/null; then
    echo -e "${GREEN}PASS${NC} $type: $(printf "%-35s" "$test_case") Time: ${exec_time}s"
    ((pass_count++))
  else
    echo -e "${RED}FAIL${NC} $type: $test_case"
    # should not output, or else may fill up the screen
    # echo "Expected:"
    # echo "$expected_output_formatted"
    # echo "Got:"
    # echo "$actual_output_formatted"
    ((fail_count++))
  fi
}

declare -a test_cases=(
  "read_from_stdin"
  "simple"
  "sorted_output"
  "single_character_words"
  "word_followed_by_EOF"
  "capitalization_and_punctuation"
  "punctuation_galore"
  "yelling_test"
  "a_little_more_comprehensive"
  "even_more_comprehensive"
  "repeated_words"
  "mixed_case_punctuation"
  "identical_repeated"
  "identical_unique"
  "unique"
  "gutenberg_stories"
)

for test_case in "${test_cases[@]}"; do
  run_and_compare "$LWORDS_BINARY" "$test_case" "lwords"
done
echo "----"
for test_case in "${test_cases[@]}"; do
  run_and_compare "$PWORDS_BINARY" "$test_case" "pwords"
done

echo -e "\n${GREEN}Passed tests: $pass_count${NC}"
echo -e "${RED}Failed tests: $fail_count${NC}"

if [ "$fail_count" -eq "0" ]; then
  echo "All tests passed."
else
  exit $fail_count
fi
