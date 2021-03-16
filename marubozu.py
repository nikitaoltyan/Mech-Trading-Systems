def find_marubozu(data):
      """
      finds marubozu candlesticks

      returns:
      bearish - bearish marubozu candlesticks
      bullish - bullish marubozu candlesticks
      """
      # finding bearish candlesticks 
      # (full: open = high, close = low; open: open = high; close: close = low)
      bearish = []
      
      bearish_full = []
      bearish_open = []
      bearish_close = []

      for i in range(data.shape[0]):
        if (data['<OPEN>'][i] == data['<HIGH>'][i]) & (data['<CLOSE>'][i] == data['<LOW>'][i]):
          bearish_full.append(i)
        if (data['<OPEN>'][i] == data['<HIGH>'][i]):
          bearish_open.append(i)
        if (data['<CLOSE>'][i] == data['<LOW>'][i]):
          bearish_close.append(i)

      bearish.append(bearish_full)
      bearish.append(bearish_open)
      bearish.append(bearish_close)
      
          
      # finding bullish candlesticks 
      # (full: open = low, close = high; open: open = low; close: close = high)
      bullish = []

      bullish_full = []
      bullish_open = []
      bullish_close = []

      for i in range(data.shape[0]):
        if (data['<OPEN>'][i] == data['<LOW>'][i]) & (data['<CLOSE>'][i] == data['<HIGH>'][i]):
          bullish_full.append(i)
        if (data['<OPEN>'][i] == data['<LOW>'][i]):
          bullish_open.append(i)
        if (data['<CLOSE>'][i] == data['<HIGH>'][i]):
          bullish_close.append(i)
        
      bullish.append(bullish_full)
      bullish.append(bullish_open)
      bullish.append(bullish_close)

      return bearish, bullish
