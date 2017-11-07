from gensim.models import word2vec
import sys


file_wordvec = sys.argv[1]


def reverseDict(dict):
    return {v: k for k, v in dict.items()}

model_concepts = word2vec.Word2Vec.load(file_wordvec)

ind2label_concepts = model_concepts.wv.index2word
label2ind_concepts = reverseDict({k: v for k, v in enumerate(ind2label_concepts)})

import ipdb; ipdb.set_trace()