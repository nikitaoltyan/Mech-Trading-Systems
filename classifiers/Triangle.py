import pandas as pd
from HeadWithShoulders import head_with_shoulders


class triangle:
  
  __init__(self):
    self.hws = head_with_shoulders()
  
  def find_triangle(self, data, rang):
    start_highs = self.hws.find_highs(data, rang)
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
