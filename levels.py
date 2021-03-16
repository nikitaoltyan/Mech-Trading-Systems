import numpy as np

 def find_support(self, data):
   """
   finds support levels
   returns: support - tuple(index, price)
   """
   support = []
   supp_points = []
   supp_close = []

   for i in range(1, data.shape[0]-1):
     if data['<LOW>'][i] < data['<LOW>'][i-1] and data['<LOW>'][i] < data['<LOW>'][i+1] and data['<LOW>'][i+1] < data['<LOW>'][i+2] and data['<LOW>'][i-1] < data['<LOW>'][i-2]:
       supp_points.append(i)
       supp_close.append(data['<LOW>'][i])
    
   support = [(i,j) for i,j in zip(supp_points, supp_close)]

   return support

 def find_resistance(self, data):
   """
   finds resistance levels
   returns: resistance - tuple(index,price)
   """
   resistance = []
   res_points = []
   res_close = []

   for i in range(1, data.shape[0]-1):
     if data['<HIGH>'][i] > data['<HIGH>'][i-1] and data['<HIGH>'][i] > data['<HIGH>'][i+1] and data['<HIGH>'][i+1] > data['<HIGH>'][i+2] and data['<HIGH>'][i-1] > data['<HIGH>'][i-2]:
       res_points.append(i)
       res_close.append(data['<HIGH>'][i])

   resistance = [(i,j) for i,j in zip(res_points, res_close)]

   return resistance

 def key_levels(self, data):
   """
   finds key levels 
   returns: support_levels, resistance_levels
   """
   support = self.find_support(data)
   resistance = self.find_resistance(data)

   support_levels = []
   resistance_levels = []

   for i in range(len(support)):
     l = support[i][1]
     if np.sum([abs(l-x) < np.mean(data['<HIGH>'] - data['<LOW>']) for x in support_levels]) == 0:
       support_levels.append((i,l))
    
   for i in range(len(resistance)):
     l = resistance[i][1]
     if np.sum([abs(l-x) < np.mean(data['<HIGH>'] - data['<LOW>']) for x in resistance_levels]) == 0:
       resistance_levels.append((i,l))

   return support_levels, resistance_levels
