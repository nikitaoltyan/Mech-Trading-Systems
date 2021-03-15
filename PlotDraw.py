import plotly.graph_objects as go

def draw_plot(data, start=0, end=1):
  """
  Function draws candle chart for given data: OPEN, HIGH, LOW, CLOSE is required.
  Start and end are Int number for wanted data range chart.
  """
  plot=[go.Candlestick(x=[i for i in range (0, len(data))][start:end],
          open=data['<OPEN>'][start:end],
          high=data['<HIGH>'][start:end],
          low=data['<LOW>'][start:end],
          close=data['<CLOSE>'][start:end])]
  figSignal = go.Figure(data=plot)
  figSignal.show()
