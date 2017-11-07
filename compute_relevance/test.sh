TEXT=../input/DBLP_small.txt
CATEGORY_SEEDCONCEPTS=query_DBLP.txt


source conf.d/autoPhrase.sh

# export TEXT_TO_SEG=$TEXT
# cd ../AutoPhrase/
# ./phrasal_segmentation.sh
# cd -

export OUTPUT_DIR=../output/$MODEL
export SEGGED_TEXT=$OUTPUT_DIR/segmentation.txt
export SEGGED_TEXT_phrase_as_word=$SEGGED_TEXT.phrase_as_word
export SEGGED_TEXT_phrase_as_word_retain_alphanumeric=$SEGGED_TEXT_phrase_as_word.retain_alphanumeric
export SEGGED_TEXT_WORDVEC=$OUTPUT_DIR/wordvec
export SEGGED_TEXT_TFIDF=$OUTPUT_DIR/tfidf
export FINAL_RELEVANCE=../output/relevance.txt

mkdir -p $OUTPUT_DIR

cp ../AutoPhrase/$MODEL/segmentation.txt $SEGGED_TEXT
python segmented2phrase_as_word.py $SEGGED_TEXT $SEGGED_TEXT_phrase_as_word
python retain_alphanumeric.py $SEGGED_TEXT_phrase_as_word $SEGGED_TEXT_phrase_as_word_retain_alphanumeric
python conceptGraphPPR.py $SEGGED_TEXT_phrase_as_word_retain_alphanumeric $CATEGORY_SEEDCONCEPTS $FINAL_RELEVANCE $SEGGED_TEXT_WORDVEC $SEGGED_TEXT_TFIDF
