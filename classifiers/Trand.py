import numpy as np
import pandas as pd


def moving_average(data, moving_avg_range=5):
  avg_prices = (data["<HIGH>"]+data["<LOW>"])/2
  moving_avg = [np.mean(avg_prices[(item-moving_avg_range):item]) 
                for item in range(moving_avg_range, len(avg_prices))]
  return moving_avg



def find_rising_trand_lines(data, moving_avg_range=5, trend_lenth = 10):
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



def find_decreasing_trand_lines(data, moving_avg_range=5, trend_lenth = 10):
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
