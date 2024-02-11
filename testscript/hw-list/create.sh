#!/bin/bash

INPUT_DIR="./test-suite/inputs"
OUTPUT_DIR="./test-suite/outputs"
GUTENBERG_DIR="./test-suite/gutenberg"
WORDS_BINARY="./words"

mkdir -p "$INPUT_DIR"
mkdir -p "$OUTPUT_DIR"

declare -A test_cases=(
    ["read_from_stdin"]="This is a simple test input from stdin."
    ["simple"]="Simple test input."
    ["sorted_output"]="This should be sorted output from test input."
    ["single_character_words"]="S i n g l e."
    ["word_followed_by_EOF"]="Word followed by EOF."
    ["capitalization_and_punctuation"]="Capitalization, and punctuation!"
    ["punctuation_galore"]="!@#$%^&*()"
    ["yelling_test"]="YELLING TEST INPUT!"
    ["a_little_more_comprehensive"]="A little more comprehensive test input."
    ["even_more_comprehensive"]="Even more comprehensive test input, with various characters and cases."
    ["repeated_words"]="Word word WORD word. Word, word! 'word'? word"
    ["mixed_case_punctuation"]="Test, test. TEST! 'Test'? test: test;"
)

for test_case in "${!test_cases[@]}"; do
    input_text="${test_cases[$test_case]}"
    input_file="$INPUT_DIR/${test_case}.txt"
    output_file="$OUTPUT_DIR/${test_case}_output.txt"

    echo "$input_text" > "$input_file"
    cat "$input_file" | $WORDS_BINARY > "$output_file"
done

concatenate_files() {
    output_file="$1"
    shift
    cat "$@" > "$output_file"
}

base_file="$INPUT_DIR/identical_repeated.txt"
concatenate_files "$base_file" "$GUTENBERG_DIR/alice.txt"
concatenate_files "$base_file" "$GUTENBERG_DIR/alice.txt"

cp "$GUTENBERG_DIR/time.txt" "$INPUT_DIR/identical_unique.txt"

# Single long file full of unique words - create a unique version
sed "s/ / unique /g" "$GUTENBERG_DIR/time.txt" > "$INPUT_DIR/unique.txt"

# Concatenate Gutenberg stories into one big file for a massive test
concatenate_files "$INPUT_DIR/gutenberg_stories.txt" "$GUTENBERG_DIR/"*.txt

# Generate output files for the large test cases
for input_file in "$INPUT_DIR/"*.txt; do
    test_case=$(basename "$input_file" .txt)
    output_file="$OUTPUT_DIR/${test_case}_output.txt"
    cat "$input_file" | $WORDS_BINARY > "$output_file"
done