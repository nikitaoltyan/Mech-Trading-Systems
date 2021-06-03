//
//  ViewController.swift
//  ODA Trading System
//
//  Created by Nikita Oltyan  on 19.05.2021.
//

import UIKit
import Foundation
import Charts

class ViewController: UIViewController {
    
    let server = Server()
    let defaults = Defaults()
    
    let balanceView: BalanceView = {
        let view = BalanceView()
            .with(autolayout: false)
        view.clipsToBounds = true
        return view
    }()
    
    let settingsButton: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 27, height: 27))
            .with(autolayout: false)
        image.image = UIImage(systemName: "gearshape.fill")
        image.tintColor = Colors.orangeGradientTop
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let chartView: CandleStickChartView = {
        let view = CandleStickChartView()
            .with(autolayout: false)
        view.drawBordersEnabled = false
        return view
    }()
    
    lazy var stockChooseView: StockChooseView = {
        let view = StockChooseView()
            .with(autolayout: false)
        view.delegate = self
        return view
    }()
    
    let button: ButtonView = {
        let view = ButtonView()
            .with(autolayout: false)
        view.clipsToBounds = true
        return view
    }()

    let explanationLabel: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
        label.textColor = Colors.light
        label.textAlignment = .left
        label.text = "Сейчас бот торгует. Что это значит?"
        label.font = UIFont(name: "Helvetica", size: 14)
        label.isUserInteractionEnabled = true
        label.isHidden = true
        return label
    }()
    
    
    var isTradeButtonTapped: Bool = false
    var candleChartEntry = [CandleChartDataEntry]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgraund
        setSubviews()
        activateLayouts()
        fetchData(forTicker: "AAPL")
    }
    
    private
    func fetchData(forTicker ticker: String){
        print("Fetch data for ticker: \(ticker)")
        DispatchQueue.main.async {
            self.server.fetchData(forTicker: ticker, completion: { (data, error) in
                guard let data = data else { return }
                self.prepareData(data: data)
            })
        }
    }
    
    
    private
    func prepareData(data: [String:Any]) {
        GraphData.close.removeAll()
        GraphData.open.removeAll()
        GraphData.high.removeAll()
        GraphData.low.removeAll()
        
        let close = data["Close"] as! Dictionary<String, Any>
        let open = data["Open"] as! Dictionary<String, Any>
        let high = data["High"] as! Dictionary<String, Any>
        let low = data["Low"] as! Dictionary<String, Any>
        let closeSorted = close.keys.sorted()
        
        for key in closeSorted {
            GraphData.close.append(close[key] as! Double)
            GraphData.open.append(open[key] as! Double)
            GraphData.high.append(high[key] as! Double)
            GraphData.low.append(low[key] as! Double)
        }
        
        drawChart()
    }
    
    private
    func drawChart(){
        candleChartEntry.removeAll()
        var useData: Int = 0
        if GraphData.open.count < 50 {
            useData = GraphData.open.count
        } else {
            useData = 50
        }
        for i in GraphData.open.count-useData...GraphData.open.count-1 {
            let value = CandleChartDataEntry(x: Double(i),
                                             shadowH: GraphData.high[i],
                                             shadowL: GraphData.low[i],
                                             open: GraphData.open[i],
                                             close: GraphData.close[i])
            candleChartEntry.append(value)
        }
        
        setUpChart()
    }
    
    @objc
    func settingsButtonTap() {
        print("Settings button tapped")
        Vibration.soft()
        let newVC = SettingsController()
        newVC.modalPresentationStyle = .fullScreen
        present(newVC, animated: true, completion: nil)
    }
    
    
    @objc
    func tradeButtonTap() {
        print("Trade button was tapped")
        tapAnimate()
        if defaults.getAlertShown() {
            switch isTradeButtonTapped {
            case true:
                button.label.text = "ТОРГОВАТЬ"
                explanationLabel.isHidden = true
                isTradeButtonTapped = false
            default:
                button.label.text = "ОСТАНОВИТЬ"
                explanationLabel.isHidden = false
                isTradeButtonTapped = true
            }
        } else {
            showAlert()
        }
    }
    
    private
    func tapAnimate() {
        UIView.animate(withDuration: 0.1, animations: {
            self.button.backgroundColor = self.button.backgroundColor?.withAlphaComponent(0.5)
        }, completion: { (_) in
            UIView.animate(withDuration: 0.1, animations: {
                self.button.backgroundColor = self.button.backgroundColor?.withAlphaComponent(1)
            })
        })
    }
    
    @objc
    func explanationTap() {
        Vibration.soft()
        let newVC = AlgorithmDescriptionController()
        newVC.modalPresentationStyle = .fullScreen
        present(newVC, animated: true, completion: nil)
    }
    
    
    private
    func showAlert() {
        let alert = UIAlertController(title: "Приветствуем!",
                                      message: "Данное приложение дает доступ к торговому роботу ODA, который выполняет за вас все действия на бирже на основе своей торговой стратегии. Для подключения брокерского счета оплатите подписку.",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Приобрести подписку", style: .default , handler:{ (UIAlertAction) in
            Vibration.soft()
            let newVC = SubscriptionController()
            newVC.modalPresentationStyle = .fullScreen
            self.present(newVC, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "О алгоритме", style: .default , handler:{ (UIAlertAction) in
            Vibration.soft()
            let newVC = AlgorithmDescriptionController()
            newVC.modalPresentationStyle = .fullScreen
            self.present(newVC, animated: true, completion: nil)
        }))
            
        alert.addAction(UIAlertAction(title: "Торговать в демо-версии", style: .cancel, handler:{ (UIAlertAction) in
            print("Close")
            Vibration.soft()
            self.defaults.setAlertShown(true)
        }))
        present(alert, animated: true, completion: nil)
    }
}





extension ViewController: StockChooseDelegate {
    func chooseStock(ticker: String) {
        print("Choose Stock")
        fetchData(forTicker: ticker)
    }
}





extension ViewController {
    private func setSubviews(){
        view.addSubview(balanceView)
        view.addSubview(settingsButton)
        view.addSubview(button)
        view.addSubview(explanationLabel)
        view.addSubview(stockChooseView)
        view.addSubview(chartView)
        
        settingsButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(settingsButtonTap)))
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tradeButtonTap)))
        explanationLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(explanationTap)))
    }
    
    private func activateLayouts() {
        NSLayoutConstraint.activate([
            balanceView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            balanceView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            balanceView.heightAnchor.constraint(equalToConstant: balanceView.frame.height),
            balanceView.widthAnchor.constraint(equalToConstant: balanceView.frame.width),
            
            settingsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            settingsButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -22),
            settingsButton.heightAnchor.constraint(equalToConstant: settingsButton.frame.height),
            settingsButton.widthAnchor.constraint(equalToConstant: settingsButton.frame.width),
            
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: button.frame.height),
            button.widthAnchor.constraint(equalToConstant: button.frame.width),
            
            explanationLabel.leftAnchor.constraint(equalTo: button.leftAnchor),
            explanationLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10),
            
            stockChooseView.bottomAnchor.constraint(equalTo: explanationLabel.topAnchor, constant: -14),
            stockChooseView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stockChooseView.heightAnchor.constraint(equalToConstant: stockChooseView.frame.height),
            stockChooseView.widthAnchor.constraint(equalToConstant: stockChooseView.frame.width),
            
            chartView.bottomAnchor.constraint(equalTo: stockChooseView.topAnchor, constant: -20),
            chartView.leftAnchor.constraint(equalTo: view.leftAnchor),
            chartView.rightAnchor.constraint(equalTo: view.rightAnchor),
            chartView.heightAnchor.constraint(equalToConstant: 260)
        ])
    }
    
    private func setUpChart(){
        let line = CandleChartDataSet(entries: candleChartEntry, label: "")
        line.drawValuesEnabled = false
        line.colors = [Colors.orangeGradientTop]
        
        let data = CandleChartData()
        data.addDataSet(line)
        
        chartView.data = data
        chartView.chartDescription?.enabled = false
        chartView.rightAxis.enabled = false
        chartView.rightAxis.drawAxisLineEnabled = false
        chartView.drawBordersEnabled = false
        chartView.legend.form = .none
            
        let xAxis = chartView.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.drawAxisLineEnabled = false
        xAxis.labelPosition = .top
        xAxis.labelTextColor = .clear
        

        let leftAxis = chartView.leftAxis
        leftAxis.drawAxisLineEnabled = false
        leftAxis.labelTextColor = .clear
        leftAxis.drawGridLinesEnabled = false
        
        DispatchQueue.main.async {
            self.chartView.notifyDataSetChanged()
            self.chartView.setNeedsDisplay()
        }
    }
}


struct GraphData {
    static var close: Array<Double> = [133.17, 133.33, 133.11, 132.73, 132.8, 132.66, 132.34, 132.2]
    static var open: Array<Double> = [133.53, 133.13, 133.32, 133.05, 132.75, 132.84, 132.58, 132.31]
    static var high: Array<Double> = [133.60, 133.43, 133.43, 133.05, 132.83, 132.87, 132.58, 132.35]
    static var low: Array<Double> = [132.96, 133.08, 132.99, 132.72, 132.39, 132.63, 132.28, 132.13]
}
