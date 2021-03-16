import numpy as np
import plotly.graph_objects as go


class head_with_shoulders:
  
  def draw_plot(self, data, start=0, end=1):
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
  

  def find_highs(self, data, rang):
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
  
  
  def find_lows(self, data, rang):
    """
    That function finds local price lows on the given range: (prise-rang, price+rang)
    Returns array with that lows.
    """
    lenth = len(data["<OPEN>"])
    result = []
    for day in range(rang, lenth-rang):
      if data["<LOW>"][day] == min(data["<LOW>"][day-rang:day+rang]):
        result.append(day)
    return result
  
  
  def find_head_with_shoulders(self, data, rang):
    """
    That function finds simplier Head With Shoulders pattern.
    Returns array with Heads and array of turples with "left" and "right" shoulder respectively.
    """
    highs = data["<HIGH>"]
    highs_indexes = self.find_highs(data=data, rang=rang)
    lows = self.find_lows(data=data, rang=rang)
    result = []
    shoulders = []
    for item in range(1, len(highs_indexes)-1):
      head = highs[highs_indexes[item]]
      leftShoulder = highs[highs_indexes[item-1]]
      rightShoulder = highs[highs_indexes[item+1]]
      # Head is upper then shoulders
      meanE = 0
      if leftShoulder<head>rightShoulder:
        meanE = (leftShoulder + rightShoulder)/2
      # Shoulders restriction
      if meanE != 0:
        if max([abs(leftShoulder-meanE), abs(rightShoulder-meanE)]) <= meanE*0.02:
          result.append(highs_indexes[item])
          shoulders.append((highs_indexes[item-1], highs_indexes[item+1]))
    return result, shoulders

  
  def draw_heads_with_shoulders(self, data, shoulders):
    for shoulder in shoulders:
      self.draw_plot(data, shoulder[0]-10, shoulder[1]+10)
