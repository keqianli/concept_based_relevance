export LABELS_FILE=../input/arxiv_cs_small_labels_num.txt

source conf.d/autoPhrase.conf

export OUTPUT_DIR=../output/$MODEL
export SEGGED_TEXT_TFIDF=$OUTPUT_DIR/tfidf
export FINAL_RELEVANCE=$SEGGED_TEXT_TFIDF.relevance
# $OUTPUT_DIR/relevance.txt

python evaluate.py $FINAL_RELEVANCE $LABELS_FILE
