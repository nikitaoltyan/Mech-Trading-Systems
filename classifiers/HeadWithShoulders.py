import numpy as np

class head_with_shoulders:

  def find_highs(data, rang):
    lenth = len(data["<OPEN>"])
    result = []
    for day in range(rang, lenth-rang):
      if data["<HIGH>"][day] == max(data["<HIGH>"][day-rang:day+rang]):
        result.append(day)
    return result
  
  def find_lows(data, rang):
    lenth = len(data["<OPEN>"])
    result = []
    for day in range(rang, lenth-rang):
      if data["<LOW>"][day] == min(data["<LOW>"][day-rang:day+rang]):
        result.append(day)
    return result
  
  def head_with_shoulders(data, rang):
    highs = data["<HIGH>"]
    highs_indexes = find_highs(data=data, rang=rang)
    lows = find_lows(data=data, rang=rang)
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
