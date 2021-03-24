import numpy as np
from levels import levels

class TradingBot:

    def __init__(self, data):
        self.data = data
        self.low = data["<LOW>"]
        self.close = data["<CLOSE>"]
        self.high = data["<HIGH>"]
        self.levels = levels()
        self.sup_arr = [index[0] for index in self.levels.find_support(data)]
        self.res_arr = [index[0] for index in self.levels.find_resistance(data)]

        trendsBuy = find_rising_trend_lines(data, 4, 5)
        indexesBuy = self.findOpenBuyPositionIndexes(trendsBuy)
        buyDict = {i:"Buy" for i in indexesBuy}
        trendsSell = find_decreasing_trend_lines(data, 4, 5)
        indexesSell = self.findOpenSellPositionIndexes(trendsSell)
        sellDict = {i:"Sell" for i in indexesSell}

        self.useDictinary = {**buyDict, **sellDict}


    def useTradingSystem(self, money, alphaSell, betaSell, alphaBuy, betaBuy):
        money = money
        startMoney = money
        currentIndex = 0
        for index in sorted(self.useDictinary):
            currentMoney, _, closeIndex = self.openRightPosition(index, self.useDictinary[index], money, currentIndex,
                                                                        alphaSell, betaSell, alphaBuy, betaBuy)
            money = currentMoney
            currentIndex = closeIndex
        return (money, money-startMoney)


    def findLastSellIndex(self, trendIndex):
        index = 0
        while (self.sup_arr[index] < trendIndex) and (index+1 < len(self.sup_arr)):
            index += 1
        return index-1

    
    def findLastBuyIndex(self, trendIndex):
        index = 0
        while (self.res_arr[index] < trendIndex) and (index+1 < len(self.res_arr)):
            index += 1
        return index-1


    def findOpenSellPositionIndexes(self, trends):
        openPositionIndexes = []
        for trend in trends:
            trendStart = trend[2]
            lastSupport = self.findLastSellIndex(trendStart)
            supLow = self.low[self.sup_arr[lastSupport]]
            if supLow > self.low[trendStart]:
                pass
            else:
                for index in range (trendStart, trendStart+10):
                    if supLow > self.low[index]:
                        if len(openPositionIndexes) == 0:
                            openPositionIndexes.append(index)
                            break
                        if index > openPositionIndexes[-1]:
                            openPositionIndexes.append(index)
                            break
        return openPositionIndexes

    
    def findOpenBuyPositionIndexes(self, trends):
        openPositionIndexes = []
        for trend in trends:
            trendStart = trend[2]
            lastResistance = self.findLastBuyIndex(trendStart)
            resHigh = self.high[self.res_arr[lastResistance]]
            if resHigh < self.high[trendStart]:
                pass
            else:
                for index in range (trendStart, trendStart+10):
                    if resHigh < self.high[index]:
                        # Пробитие сопротивления
                        if len(openPositionIndexes) == 0:
                            openPositionIndexes.append(index)
                            break
                        if index > openPositionIndexes[-1]:
                            openPositionIndexes.append(index)
                            break
        return openPositionIndexes
    

    def findCloseSellPosition(self, openIndex, money, boughtIndex, alpha, beta, lenth):
        # Проверка на возможность продать акции (что предыдущая сделка закрыта)
        if boughtIndex > openIndex:
            return (money, 0, boughtIndex)
        index = openIndex
        openPrice = self.close[openIndex]
        sharesBought = money // openPrice
        rest = money - (openPrice * sharesBought)
        while (openPrice/self.close[index] < (1+alpha)) and (openPrice/self.close[index] > (1-beta)):
            if lenth-1 > index:
                index += 1
            else:
                break
        profit = round(sharesBought*openPrice - sharesBought*self.close[index], 2)
        money = profit + money + rest
        return (money, profit, index)


    def findCloseBuyPosition(self, openIndex, money, boughtIndex, alpha, beta, lenth):
        # Проверка на возможность приобрести акции (что предыдущая сделка закрыта)
        if boughtIndex > openIndex:
            return (money, 0, boughtIndex)
        index = openIndex
        openPrice = self.close[openIndex]
        sharesBought = money // openPrice
        rest = money - (openPrice * sharesBought)
        while (openPrice/self.close[index] > (1-alpha)) and (openPrice/self.close[index] < (1+beta)):
            if lenth-1 > index:
                index += 1
            else:
                break
        profit = round(sharesBought*self.close[index] - sharesBought*openPrice, 2)
        money = profit + money + rest
        return (money, profit, index)


    def openRightPosition(self, index, position, money, curIndex, aS, bS, aB, bB):
        if position == "Sell":
            money, profit, closeIndex = self.findCloseSellPosition(index, money, curIndex, aS, bS, data.shape[0])
            return (money, profit, closeIndex)
        else:
            money, profit, closeIndex = self.findCloseBuyPosition(index, money, curIndex, aB, bB, data.shape[0])
            return (money, profit, closeIndex)

    
    def findBestHyperparams(self, iterations, showProcess=False):
        alphasSell = [0, 0.1]
        betasSell = [0, 0.1]
        alphasBuy = [0, 0.1]
        betasBuy = [0, 0.1]
        results = {}

        for iter in range (iterations):
            alphaSell = np.random.uniform(alphasSell[0], alphasSell[1])
            betaSell = np.random.uniform(betasSell[0], betasSell[1])
            alphaBuy = np.random.uniform(alphasBuy[0], alphasBuy[1])
            betaBuy = np.random.uniform(betasBuy[0], betasBuy[1])

            money = 100000
            startMoney = money
            currentIndex = 0
            for index in sorted(self.useDictinary):
                currentMoney, _, closeIndex = self.openRightPosition(index, self.useDictinary[index], money, currentIndex,
                                                                            alphaSell, betaSell, alphaBuy, betaBuy)
                money = currentMoney
                currentIndex = closeIndex
            results[money-startMoney] = (alphaSell, betaSell, alphaBuy, betaBuy)

            if (showProcess):
                print(f"Iter: {iter}, profit: {money-startMoney}, coefs: {alphaSell, betaSell, alphaBuy, betaBuy}")
        if (showProcess):
            print(f"Max profit: {max(results)} was received by alphas and betas: {results[max(results)]}")
        # Return alphaSell, betaSell, alphaBuy, betaBuy
        return results[max(results)]
