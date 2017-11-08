CATEGORY_SEEDCONCEPTS=${CATEGORY_SEEDCONCEPTS:-../input/query_arxiv_cs_small.txt}

source conf.d/autoPhrase.conf

export OUTPUT_DIR=../output/$MODEL
export SEGGED_TEXT_TFIDF=$OUTPUT_DIR/tfidf
export LABELS_FILE=../input/arxiv_cs_small_labels_num.txt

python baseline.py $SEGGED_TEXT_TFIDF $CATEGORY_SEEDCONCEPTS $LABELS_FILE