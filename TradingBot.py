import numpy as np
import matplotlib.pyplot as plt
from levels import levels
from Trend import find_rising_trend_lines, find_decreasing_trend_lines

class TradingBot:

    def __init__(self, data):
        self.data = data
        self.low = data["<LOW>"]
        self.close = data["<CLOSE>"]
        self.high = data["<HIGH>"]
        self.levels = levels()
        self.sup_arr = [index[0] for index in self.levels.find_support(data)]
        self.res_arr = [index[0] for index in self.levels.find_resistance(data)]
        self.commission = 0.003 #in %

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
        commission = round(sharesBought * openPrice * self.commission, 5)
        rest = money - (openPrice * sharesBought)
        while (openPrice/self.close[index] < (1+alpha)) and (openPrice/self.close[index] > (1-beta)):
            if lenth-1 > index:
                index += 1
            else:
                break
        commission += round(sharesBought * self.close[index] * self.commission, 5)
        profit = round(sharesBought*openPrice - sharesBought*self.close[index] - commission, 2)
        returnMoney = profit + sharesBought*self.close[index] + rest
        print(f"Commision: {commission}")
        print(f"Shares bought: {sharesBought}")
        print(f"Open Sell index {openIndex} and price {openPrice}, close index {index} and price {self.close[index]}")
        print(f"Current money {returnMoney}, with the profit for the deal: {profit}")
        return (returnMoney, profit, index)


    def findCloseBuyPosition(self, openIndex, money, boughtIndex, alpha, beta, lenth):
        # Проверка на возможность приобрести акции (что предыдущая сделка закрыта)
        if boughtIndex > openIndex:
            return (money, 0, boughtIndex)
        index = openIndex
        openPrice = self.close[openIndex]
        sharesBought = money // openPrice
        commission = round(sharesBought * openPrice * self.commission, 5)
        rest = money - (openPrice * sharesBought)
        while (openPrice/self.close[index] > (1-alpha)) and (openPrice/self.close[index] < (1+beta)):
            if lenth-1 > index:
                index += 1
            else:
                break

        commission += round(sharesBought * self.close[index] * self.commission, 5)
        profit = round(sharesBought*self.close[index] - sharesBought*openPrice - commission, 2)
        returnMoney = profit + sharesBought*self.close[index] + rest
        print(f"Commision: {commission}")
        print(f"Shares bought: {sharesBought}")
        print(f"Open Buy index {openIndex} and price {openPrice}, rest {rest}, close index {index} and price {self.close[index]}")
        print(f"Current money {returnMoney}, with the profit for the deal: {profit}")
        return (returnMoney, profit, index)


    def openRightPosition(self, index, position, money, curIndex, aS, bS, aB, bB):
        if position == "Sell":
            money, profit, closeIndex = self.findCloseSellPosition(index, money, curIndex, aS, bS, self.data.shape[0])
            return (money, profit, closeIndex)
        else:
            money, profit, closeIndex = self.findCloseBuyPosition(index, money, curIndex, aB, bB, self.data.shape[0])
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
            print(f"Max profit: {max(results)} for $100k start money was received by alphas and betas: {results[max(results)]}")
        # Return alphaSell, betaSell, alphaBuy, betaBuy
        return results[max(results)]
    
    
    def visualizeHyperparamsDistribution(self):
        alphasSell = [0, 0.1]
        betasSell = [0, 0.1]
        alphasBuy = [0, 0.1]
        betasBuy = [0, 0.1]
        results = {}

        for iter in range (1500):
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
            results[(money-startMoney)/money] = (alphaSell, betaSell, alphaBuy, betaBuy)
            
        print(f"Max profit %: {max(results)*100} was received by alphas and betas: {results[max(results)]}")
        
        aS_scatter = [results[i][0] for i in results]
        bS_scatter = [results[i][1] for i in results]
        aB_scatter = [results[i][2] for i in results]
        bB_scatter = [results[i][3] for i in results]

        marker_size = 100
        
        colors = [x for x in results]
        plt.scatter(aS_scatter, bS_scatter, marker_size, c=colors, cmap=plt.cm.coolwarm)
        plt.colorbar()
        plt.xlabel('Alpha Sell')
        plt.ylabel('Beta Sell')
        plt.title('Profit (%) distribution')
        plt.show()

        colors = [x for x in results]
        plt.scatter(aB_scatter, bB_scatter, marker_size, c=colors, cmap=plt.cm.coolwarm)
        plt.colorbar()
        plt.xlabel('Alpha Buy')
        plt.ylabel('Beta Buy')
        plt.title('Profit (%) distribution')
        plt.show()
        
        colors = [x for x in results]
        plt.tight_layout(pad=3)
        plt.scatter(aS_scatter, aB_scatter, marker_size, c=colors, cmap=plt.cm.coolwarm)
        plt.colorbar()
        plt.xlabel('Alpha Sell')
        plt.ylabel('Alpha Buy')
        plt.title('Profit (%) distribution')
        plt.show()

        colors = [x for x in results]
        plt.scatter(bS_scatter, bB_scatter, marker_size, c=colors, cmap=plt.cm.coolwarm)
        plt.colorbar()
        plt.xlabel('Beta Sell')
        plt.ylabel('Beta Buy')
        plt.title('Profit (%) distribution')
        plt.show()
        
        colors = [x for x in results]
        plt.tight_layout(pad=3)
        plt.scatter(aS_scatter, bB_scatter, marker_size, c=colors, cmap=plt.cm.coolwarm)
        plt.colorbar()
        plt.xlabel('Alpha Sell')
        plt.ylabel('Beta Buy')
        plt.title('Profit (%) distribution')
        plt.show()

        colors = [x for x in results]
        plt.scatter(aB_scatter, bS_scatter, marker_size, c=colors, cmap=plt.cm.coolwarm)
        plt.colorbar()
        plt.xlabel('Alpha Buy')
        plt.ylabel('Beta Sell')
        plt.title('Profit (%) distribution')
        plt.show()
