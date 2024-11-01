from gensim.models import Word2Vec # type: ignore
from sklearn.metrics.pairwise import cosine_similarity # type: ignore
import numpy as np # type: ignore
import matplotlib.pyplot as plt # type: ignore
from sklearn.feature_extraction.text import TfidfVectorizer # type: ignore
tokenized_sentences =[]
with open("./dataset/HumanML3D/train.txt","r") as filenames:
    for filename in filenames:
        filename = filename.strip()
        with open(f"./dataset/HumanML3D/texts/{filename}.txt","r") as promt_file:
            promt = promt_file.readlines()
            clean_promt = []
            for line in promt:
                line = line.split('#')[0]
                clean_promt.append(line)
            for sentence in clean_promt:
                tokenized_sentences.append(sentence.lower().split())
            # tokenized_sentences = tokenized_sentences.append[sentence.lower().split() for sentence in clean_promt]
model = Word2Vec(tokenized_sentences, vector_size=300, window=10, min_count=1, sg=1,epochs=10)
target_word1 = "swimming"
target_word2 = "skating"

corpus = [' '.join(sentence) for sentence in tokenized_sentences]
vectorizer = TfidfVectorizer()
tfidf_matrix = vectorizer.fit_transform(corpus)
tfidf_dict = dict(zip(vectorizer.get_feature_names_out(), vectorizer.idf_))

def get_weighted_sentence_vector(sentence, model, tfidf_dict):
    weighted_vectors = [
        model.wv[word] * tfidf_dict.get(word, 1.0) for word in sentence if word in model.wv
    ]
    return np.mean(weighted_vectors, axis=0) if weighted_vectors else np.zeros(model.vector_size)


with open("./preprocess/output.txt", "w") as output_file:
    with open("./dataset/HumanML3D/train.txt","r") as filenames:
      for filename in filenames:
          filename = filename.strip()
          with open(f"./dataset/HumanML3D/texts/{filename}.txt","r") as promt_file:
              promt = promt_file.readlines()
              clean_promt = []
              for line in promt:
                  line = line.split('#')[0]
                  clean_promt.append(line)
              sentence_vectors=[]
              for sentence in clean_promt:
                  sentence = sentence.lower().split()
                  sentence_vector = get_weighted_sentence_vector(sentence, model, tfidf_dict)
                  sentence_vectors.append(sentence_vector)
              # mean_vector = np.mean(sentence_vectors, axis=0)
              #     for word in sentence:
              #         sentence_vectors.append(model.wv[word])
              similarity1 = cosine_similarity(np.mean(sentence_vectors, axis=0).reshape(1,-1), model.wv[target_word1].reshape(1, -1))[0][0]
              similarity2 = cosine_similarity(np.mean(sentence_vectors, axis=0).reshape(1,-1), model.wv[target_word2].reshape(1, -1))[0][0]
              output_file.write(f"{filename} {max(similarity1,similarity2)}\n")