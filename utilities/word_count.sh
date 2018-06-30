#!/bin/bash

INPUT_FILE="dissertation.tex"
OUTPUT_FILE="word_count.csv"

COUNTS="$(texcount -1 -merge -q ${INPUT_FILE})"

WORDS_TEXT="$(awk -F'[+]' '{print $1}' <<< ${COUNTS})"
WORDS_HEADER="$(awk -F'[+]' '{print $2}' <<< ${COUNTS})"
WORDS_CAPTION="$(awk -F'[+|(]' '{print $3}' <<< ${COUNTS})"
NUM_HEADER="$(awk -F'[(|/]' '{print $2}' <<< ${COUNTS})"
NUM_FLOAT="$(awk -F'[/]' '{print $2}' <<< ${COUNTS})"
NUM_MATH_INLINE="$(awk -F'[/]' '{print $3}' <<< ${COUNTS})"
NUM_MATH_DISPLAY="$(awk -F'[/|)]' '{print $4}' <<< ${COUNTS})"

echo "Words in text: ${WORDS_TEXT}"
echo "Words in headers: ${WORDS_HEADER}"
echo "Words in cations: ${WORDS_CAPTION}"
echo "Number of headers: ${NUM_HEADER}"
echo "Number of floats: ${NUM_FLOAT}"
echo "Number of math inline: ${NUM_MATH_INLINE}"
echo "Number of math display: ${NUM_MATH_DISPLAY}"

echo "COMMIT,DATE,WORDS_TEXT,WORDS_HEADER,WORDS_CAPTION,NUM_HEADER,NUM_FLOAT,NUM_MATH_INLINE,NUM_MATH_DISPLAY" > ${OUTPUT_FILE}

echo "${WORDS_TEXT},${WORDS_HEADER},${WORDS_CAPTION// /},${NUM_HEADER},${NUM_FLOAT},${NUM_MATH_INLINE},${NUM_MATH_DISPLAY}" >> ${OUTPUT_FILE}
