import numpy as np
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
  

def moving_average(data, moving_avg_range=5):
  avg_prices = (data["<HIGH>"]+data["<LOW>"])/2
  moving_avg = [np.mean(avg_prices[(item-moving_avg_range):item]) 
                for item in range(moving_avg_range, len(avg_prices))]
  return moving_avg



def find_rising_trend_lines(data, moving_avg_range=5, trend_lenth = 10):
  moving_avg = moving_average(data, moving_avg_range)
  trends, current_trend, result = [], [], []
  for avg in moving_avg:
    if len(current_trend) == 0:
      current_trend.append(moving_avg.index(avg)+moving_avg_range)
    else:
      if moving_avg[current_trend[-1]-moving_avg_range]*0.999<avg:
        current_trend.append(moving_avg.index(avg)+moving_avg_range)
      else:
        trends.append(current_trend)
        current_trend = []
  # Checking trand lenth
  for trend in trends:
    if len(trend)>=trend_lenth:
      result.append(trend)
  return result



def find_decreasing_trend_lines(data, moving_avg_range=5, trend_lenth = 10):
  moving_avg = moving_average(data, moving_avg_range)
  trends, current_trend, result = [], [], []
  for avg in moving_avg:
    if len(current_trend) == 0:
      current_trend.append(moving_avg.index(avg)+moving_avg_range)
    else:
      if moving_avg[current_trend[-1]-moving_avg_range]*1.001>avg:
        current_trend.append(moving_avg.index(avg)+moving_avg_range)
      else:
        trends.append(current_trend)
        current_trend = []
  # Checking trand lenth
  for trend in trends:
    if len(trend)>=trend_lenth:
      result.append(trend)
  return result


def draw_trends(data, trends):
    for trend in trends:
      draw_plot(data, trend[0], trend[-1])
