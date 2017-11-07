import sys
import numpy as np
from sklearn.metrics import average_precision_score
from sklearn.metrics import precision_score


file_relevance = '../output/ARXIV_CS/relevance.txt'
if len(sys.argv) > 1:
    file_relevance = sys.argv[1]

file_label = '../input/arxiv_cs_small_labels_num.txt'
if len(sys.argv) > 2:
    file_label = sys.argv[2]

# read relevance

sims_documents = []
for l in open(file_relevance):
    sims_documents.append([float(d) for d in l.split(' ')])

sims_documents = np.array(sims_documents)

labels = []
for l in open(file_label):
    labels.append(int(l))
labels_choices = list(set(labels))

labels = np.array(labels)

for label_choice in labels_choices:
    sims_documents_label_choice = sims_documents[:, label_choice]
    labels_label_choice = (labels == label_choice).astype(int)
    indexes_sorted = np.argsort(-sims_documents_label_choice)

    print '=' * 25
    print 'for label ', label_choice
    for K in [10, 100, 1000]:
        print 'for K=', K
        y_scores = sims_documents_label_choice[indexes_sorted[:K]]
        y_true = labels_label_choice[indexes_sorted[:K]]
        print 'precision: ',  sum(y_true)/float(K)
        print 'average_precision_score:', average_precision_score(y_true, y_scores)
