//
//  BalanceView.swift
//  ODA Trading System
//
//  Created by Никита Олтян on 19.05.2021.
//

import UIKit

class BalanceView: UIView {
    
    let title: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
        label.textColor = Colors.light
        label.textAlignment = .center
        label.text = "доступный баланс"
        label.font = UIFont(name: "Helvetica-Light", size: 18.0)
        return label
    }()
    
    let balance: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
        label.textColor = Colors.light
        label.textAlignment = .center
        label.text = "45,678$"
        label.font = UIFont(name: "Helvetica-Light", size: 45.0)
        return label
    }()
    
    let sharesAvailableLabel: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
        label.textColor = Colors.light
        label.textAlignment = .left
        label.text = "доступно 0 акций"
        label.font = UIFont(name: "Helvetica-Light", size: 14.0)
        return label
    }()
    
    let moneyAvailableLable: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
        label.textColor = Colors.light
        label.textAlignment = .right
        label.text = "доступно 45,678$"
        label.font = UIFont(name: "Helvetica-Light", size: 14.0)
        return label
    }()
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = [Colors.backgraund.cgColor,
                           Colors.light.cgColor]
        gradient.startPoint = CGPoint(x: 0.69, y: 0.3)
        gradient.endPoint = CGPoint(x: 1.0, y: 2.0)
        return gradient
    }()

    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth*0.86, height: 140)
        super.init(frame: useFrame)
        self.layer.cornerRadius = 25
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}






extension BalanceView {
    func setSubviews(){
        self.layer.addSublayer(gradient)
        self.addSubview(title)
        self.addSubview(balance)
        self.addSubview(sharesAvailableLabel)
        self.addSubview(moneyAvailableLable)
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            balance.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 6),
            balance.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            sharesAvailableLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -9),
            sharesAvailableLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18),
            
            moneyAvailableLable.bottomAnchor.constraint(equalTo: sharesAvailableLabel.bottomAnchor),
            moneyAvailableLable.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18)
        ])
    }
}
