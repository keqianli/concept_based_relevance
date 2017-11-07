from gensim.models import word2vec
import sys


file_wordvec = sys.argv[1]


def reverseDict(dict):
    return {v: k for k, v in dict.items()}

model_concepts = word2vec.Word2Vec.load(file_wordvec)

ind2label_concepts = model_concepts.wv.index2word
label2ind_concepts = reverseDict({k: v for k, v in enumerate(ind2label_concepts)})


def searchConcept(query):
    return [w for w in ind2label_concepts if query in w]


name = 'default'
while name:
    query = raw_input("Input your query word. No input to terminate:\n")
    print '\n'.join(searchConcept(query))

