# Concept-based Document Retrieval


## Notes

This software requires [AutoPhrase](https://github.com/shangjingbo1226/AutoPhrase) to extract domain keyphrases. Please refer to AutoPhrase documentation for installation and usage.

## Requirements

We will take Ubuntu for example.

* python 2.7
```
$ sudo apt-get install python
```
* other python packages
```
$ sudo pip install -r requirements.txt
```

## Build
Build AutoPhrase by Makefile in the terminal.
```
$ cd AutoPhrase
$ make
```

## Run
First, to fit our model to a corpus, run
```
$ bash ./train.sh
```
and specify the input/output by changing the following variables at the beginning of the script
* ```TEXT```: the input text file

Then, query a specific set of documents, run
```
$ bash ./test.sh
```
and specify the input/output by changing the following variables at the beginning of the script
* ```TEXT```: the input text file
* ```CATEGORY_SEEDCONCEPTS```: the input query file, specify one or more set of concepts to query

You can change the value of ```TEXT``` and ```CATEGORY_SEEDCONCEPTS``` by editing the script, or exporting environmental variables with the same names.

## Helper function
run
```
$ bash ./helper.sh
```
To use the helper function to select seed concepts. By entering a lower case concept, e.g., machine learning, you will be able to get a list of concepts that contain the word, which can then be used as seed concepts

## Input Format
* The input files specified by ```TEXT``` for both ```train.sh``` and ```test.sh``` should be one document per line.
* The input file ```CATEGORY_SEEDCONCEPTS``` should have each line following the format ```[category name]\t[concept1],[concept2],[concept3]...```, and can contain one or more lines.

## Output Format
The query relevance output, as specified by the `SEGGED_TEXT_categorized` in the beginning of the ```test.sh```, is in the format of [relevance to concept set1], [relevance to concept set2]...


## Hyper-Parameters
The running parameters are located in `conf.d` folder, including `autoPhrase.conf` and `pyConfig.conf`.

`autoPhrase.conf` contains the parameters for concept extraction and segmentation.

`pyConfig.conf` contains the parameters for all other training steps.

### autoPhrase.conf

```
MODEL='ARXIV_CS'
```

The name of model to store the processed output.

```
MIN_SUP=10
```

A hard threshold of raw frequency is specified for frequent phrase mining, which
will generate a candidate set.

```
HIGHLIGHT_MULTI=0.5
```

The threshold for multi-word phrases to be recognized as quality phrases.


```
HIGHLIGHT_SINGLE=0.9
```

The threshold for single-word phrases to be recognized as quality phrases.

### pyConfig.conf


```
MIN_NEIGHBOR_SIMILARITY=.6
```
the minimum threshold for concept pairs to be considered neighbors in the concept graph

```
MIN_CATEGORY_NEIGHBOR=3
```
minimum number of neighbors that each concept in the query concept set should have

```
MAX_NEIGHBORS=100
```
maximum number of neighbors a concept in the concept will have

## Evaluation
We provide an example data which is a subset of arxiv computer science paper abstract. To use the provided script for evaluating the example data, run the following for evaluating the retrieval results
```
$ bash ./evaluate.sh
```
and specify the input/output by changing the following variables at the beginning of the script
* ```LABELS_FILE```: the ground truth label file, each line contains an integer indicating the index of category (as in the ```CATEGORY_SEEDCONCEPTS``` file in ```test.sh```)
* ```FINAL_RELEVANCE```: the final relevance score (same as in ```CATEGORY_SEEDCONCEPTS``` file)
