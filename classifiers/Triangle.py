import pandas as pd
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
  
  

def find_highs(data, rang):
  """
  That function finds local price highs on the given range: (prise-rang, price+rang)
  Returns array with that highs.
  """
  lenth = len(data["<OPEN>"])
  result = []
  for day in range(rang, lenth-rang):
    if data["<HIGH>"][day] == max(data["<HIGH>"][day-rang:day+rang]):
      result.append(day)
  return result
  
  
def find_triangle(data, rang):
  """
  That function finds simplier triangle pattern. There's condition: after the highest started
  peak and the next the lowest peak is a middle peak – its between the last two, but the highest
  in the nearest area.
  Returns array with turples - that three peaks accordingly.
  """
  start_highs = find_highs(data, rang)
  highs = list(data["<HIGH>"])
  lows = list(data["<LOW>"])
  result = []
  for item in start_highs:
    if item<(len(highs)-rang):
      ind_min = lows.index(min(lows[item+2:item+rang+2]))
      next_high = max(highs[ind_min+2:ind_min+rang+2])
      ind_high = highs.index(next_high)
      if (lows[ind_min]<highs[item]>highs[ind_high]) and (lows[ind_min]<highs[ind_high]):
        result.append((item, ind_min, ind_high))
  return result


def draw_triangles(data, triangles):
  for triangle in triangles:
    draw_plot(data, triangle[0], triangle[-1])
