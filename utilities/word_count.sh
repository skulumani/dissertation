#!/bin/bash

INPUT_FILE="dissertation.tex"
OUTPUT_FILE="word_count.csv"
BRANCH="system_model"
INDEX=0

echo "INDEX,COMMIT,DATE,WORDS_TEXT,WORDS_HEADER,WORDS_CAPTION,NUM_HEADER,NUM_FLOAT,NUM_MATH_INLINE,NUM_MATH_DISPLAY" > ${OUTPUT_FILE}

for COMMIT in $(git rev-list -n 10 --reverse ${BRANCH})
do
    COUNTS="$(git show $COMMIT:$INPUT_FILE 2>/dev/null | texcount -1 -merge -q -)"
    
    DATE="$(git log -1 --date=iso --pretty=format:%ad $COMMIT)"
    WORDS_TEXT="$(awk -F'[+]' '{print $1}' <<< ${COUNTS})"
    WORDS_HEADER="$(awk -F'[+]' '{print $2}' <<< ${COUNTS})"
    WORDS_CAPTION="$(awk -F'[+|(]' '{print $3}' <<< ${COUNTS})"
    NUM_HEADER="$(awk -F'[(|/]' '{print $2}' <<< ${COUNTS})"
    NUM_FLOAT="$(awk -F'[/]' '{print $2}' <<< ${COUNTS})"
    NUM_MATH_INLINE="$(awk -F'[/]' '{print $3}' <<< ${COUNTS})"
    NUM_MATH_DISPLAY="$(awk -F'[/|)]' '{print $4}' <<< ${COUNTS})"
    echo "${INDEX},${COMMIT},${DATE},${WORDS_TEXT},${WORDS_HEADER},${WORDS_CAPTION// /},${NUM_HEADER},${NUM_FLOAT},${NUM_MATH_INLINE},${NUM_MATH_DISPLAY}" >> ${OUTPUT_FILE}
    INDEX=$[$INDEX + 1]
done

mv $OUTPUT_FILE ./utilities/
