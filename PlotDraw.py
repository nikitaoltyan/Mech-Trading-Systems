import plotly.graph_objects as go

def draw_plot(data, start=0, end=len(data)):
  plot=[go.Candlestick(x=[i for i in range (0, len(data))][start:end],
          open=data['<OPEN>'][start:end],
          high=data['<HIGH>'][start:end],
          low=data['<LOW>'][start:end],
          close=data['<CLOSE>'][start:end])]
  figSignal = go.Figure(data=plot)
  figSignal.show()
