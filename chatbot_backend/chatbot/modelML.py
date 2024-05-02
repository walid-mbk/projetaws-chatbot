import json
import pickle
import numpy as np
import re
import random
import torch
import torch.nn as nn
from transformers import  DistilBertModel


class BERT_Arch(nn.Module):
    def __init__(self, bert):      
        super(BERT_Arch, self).__init__()
        self.bert = bert 

       # dropout layer
        self.dropout = nn.Dropout(0.2)

       # relu activation function
        self.relu =  nn.ReLU()
       # dense layer
        self.fc1 = nn.Linear(768,512)
        self.fc2 = nn.Linear(512,256)
        self.fc3 = nn.Linear(256,19)
       #softmax activation function
        self.softmax = nn.LogSoftmax(dim=1)
       #define the forward pass
    def forward(self, sent_id, mask):
        #pass the inputs to the model 
        cls_hs = self.bert(sent_id, attention_mask=mask)[0][:,0]

        x = self.fc1(cls_hs)
        x = self.relu(x)
        x = self.dropout(x)

        x = self.fc2(x)
        x = self.relu(x)
        x = self.dropout(x)
        # output layer
        x = self.fc3(x)

        # apply softmax activation
        x = self.softmax(x)
        return x
    
class ChatBot:
    def __init__(self):
        bert = DistilBertModel.from_pretrained('distilbert-base-uncased')
        self.model = BERT_Arch(bert)
        
        self.max_sequence_length = 20  # Adjust this value based on your model's input shape

        # Load BERT model and tokenizer
        self.device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
        self.model.load_state_dict(torch.load('chat_model/chat_model.pth', map_location=self.device))
        with open('chat_model/tokenizer.pickle', 'rb') as handle:
            self.tokenizer = pickle.load(handle)
        with open("chat_model/data.json") as file:
            self.data = json.load(file)
        with open('chat_model/label_encoder.pickle', 'rb') as enc:
            self.lbl_encoder = pickle.load(enc)

    def generate_response(self, user_message):
        user_message = re.sub(r'[^a-zA-Z ]+', '', user_message)
        test_text = [user_message]

        # self.model.eval()
        tokens_test_data = self.tokenizer(test_text,
                                          max_length=self.max_sequence_length,
                                          pad_to_max_length=True,
                                          truncation=True,
                                          return_token_type_ids=False)

        test_seq = torch.tensor(tokens_test_data['input_ids'])
        test_mask = torch.tensor(tokens_test_data['attention_mask'])
        preds = None

        with torch.no_grad():
            preds = self.model(test_seq.to(self.device), test_mask.to(self.device))
            

        preds = preds.detach().cpu().numpy()
        preds = np.argmax(preds, axis=1)
        tag = self.lbl_encoder.inverse_transform(preds)[0]

        for i in self.data["intents"]:
            if i["tag"] == tag:
                response = np.random.choice(i["responses"])
                return response

        return "I'm sorry, but I didn't understand your message."