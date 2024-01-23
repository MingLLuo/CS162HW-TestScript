#!/bin/bash


# Ensure test-suite directory exists and enter it
mkdir -p test-suite
cd test-suite


echo "simple test" > simple_test.txt
echo "a" > single_char_word.txt
echo "longwordlongwordlongwordlongwordlongwordlongword" > really_long_word.txt
echo ".,!?" > punctuation.txt
echo "Comprehensive test. With, punctuation; and other stuff!" > comprehensive.txt

# Define function to create a file with content
create_file() {
    echo "$2" > "$1"
}


# Define function to create expected output file
create_expected_output() {
    filename="$1"
    content="$2"
    expected_filename="${filename%.*}_output.txt"
    echo -e "$content" > "$expected_filename"
}

# Create test input files and their expected output files
create_file "simple_freq.txt" "word simple simple test"
create_expected_output "simple_freq.txt" "1\ttest\n1\tword\n2\tsimple"

create_file "sorted_freq.txt" "apple banana apple fruit banana fruit"
create_expected_output "sorted_freq.txt" "2\tapple\n2\tbanana\n2\tfruit"

create_file "single_char_freq.txt" "a b a c b a"
create_expected_output "single_char_freq.txt" "1\tc\n2\tb\n3\ta"

create_file "eof_freq.txt" "end end file file eof eof EOF"
create_expected_output "eof_freq.txt" "2\tend\n2\tfile\n3\teof"

create_file "caps_punct_freq.txt" "Example, example, EXAMPLE. Test; test; TEST?"
create_expected_output "caps_punct_freq.txt" "3\texample\n3\ttest"

create_file "punct_galore_freq.txt" ".,!,.,!,.,!,,,a"
create_expected_output "punct_galore_freq.txt" "1\ta"

create_file "yelling_freq.txt" "LOUD NOISES! LOUDER NOISES! LOUDEST NOISES!"
create_expected_output "yelling_freq.txt" "1\tloud\n1\tlouder\n1\tloudest\n3\tnoises\n"

create_file "comprehensive_freq.txt" "Comprehensive tests are thorough. Comprehensive and thorough tests."
create_expected_output "comprehensive_freq.txt" "1\tand\n1\tare\n2\tcomprehensive\n2\ttests\n2\tthorough"


long_word=$(printf 'a%.0s' {1..65}) # generates a 65-character long word
echo "$long_word" >"long_word_test.txt"


echo "Test files and expected output files created."
