import pandas as pd
from HeadWithShoulders import head_with_shoulders


class triangle:

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
  
  
  def find_triangle(self, data, rang):
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
