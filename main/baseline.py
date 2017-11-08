import sys
import cPickle
from gensim import corpora, models, similarities
import csv
import numpy as np


file_tfidf = '.tfidf'
if len(sys.argv) > 1:
    file_tfidf = sys.argv[1]

category_seedConcepts_file = '../input/query_arxiv_cs_small.txt'
if len(sys.argv) > 2:
    category_seedConcepts_file = sys.argv[2]

file_label = '../input/arxiv_cs_small_labels_num.txt'
if len(sys.argv) > 3:
    file_label = sys.argv[3]

categorization_file = file_tfidf + '.relevance'

labels = []
for l in open(file_label):
    labels.append(int(l))
labels_choices = list(set(labels))


tsvin = csv.reader(open(category_seedConcepts_file), delimiter='\t')
category_name_list = []
seed_concepts_list = []
for row in tsvin:
    category_name_list.append(row[0].strip())
    seed_concepts_list.append([w.strip().replace(' ', '_') for w in row[1].split(',')])


def main():
    try:
        corpus = corpora.MmCorpus(file_tfidf+'.corpus')
        dictionary = corpora.Dictionary.load(file_tfidf + '.dict')
        modelTfidf = models.TfidfModel.load(file_tfidf+'.modelTfidf')
    except Exception:
        print 'TFIDF not found. please run buildindex.py first'

    try:
        index = cPickle.load(open(file_tfidf+'.index', 'rb'))
    except Exception:
        print 'using new index'
        modelTfidfCorpus = modelTfidf[corpus]
        index = similarities.Similarity(file_tfidf+'.modelTfidfindex', modelTfidfCorpus, num_features=modelTfidfCorpus.corpus.num_terms)
        index.num_best = None
        cPickle.dump(index, open(file_tfidf+'.index', 'wb'))

    # evaluate for each query
    scores = []
    for i in range(len(labels_choices)):
        print 'for label ', i
        query_vector = modelTfidf[dictionary.doc2bow(['<phrase>%s</phrase>' % w.lower() for w in seed_concepts_list[i]])]
        scores.append(index[query_vector])

    scores = np.array(scores).T
    with open(categorization_file, 'w') as f:
        for i in range(scores.shape[0]):
            f.write('%s\n' % (' '.join(['%s' % d for d in scores[i]])))


if __name__ == '__main__':
    main()