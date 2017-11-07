TEXT=${TEXT:-../input/arxiv_cs_small.txt}
CATEGORY_SEEDCONCEPTS=${CATEGORY_SEEDCONCEPTS:-../input/query_arxiv_cs_small.txt}

source conf.d/autoPhrase.conf

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
export FINAL_RELEVANCE=$OUTPUT_DIR/relevance.txt

mkdir -p $OUTPUT_DIR

# uncomment below to help select seed concepts
python helper/query_concept_dictionary.py $SEGGED_TEXT_WORDVEC

cp ../AutoPhrase/$MODEL/segmentation.txt $SEGGED_TEXT
python segmented2phrase_as_word.py $SEGGED_TEXT $SEGGED_TEXT_phrase_as_word
python retain_alphanumeric.py $SEGGED_TEXT_phrase_as_word $SEGGED_TEXT_phrase_as_word_retain_alphanumeric
python conceptGraphPPR.py $SEGGED_TEXT_phrase_as_word_retain_alphanumeric $CATEGORY_SEEDCONCEPTS $FINAL_RELEVANCE $SEGGED_TEXT_WORDVEC $SEGGED_TEXT_TFIDF