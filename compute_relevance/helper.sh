source conf.d/autoPhrase.conf

export OUTPUT_DIR=../output/$MODEL
export SEGGED_TEXT_WORDVEC=$OUTPUT_DIR/wordvec

python helper/query_concept_dictionary.py $SEGGED_TEXT_WORDVEC