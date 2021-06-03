//
//  ButtonView.swift
//  ODA Trading System
//
//  Created by Никита Олтян on 19.05.2021.
//

import UIKit

class ButtonView: UIView {
    
    let label: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
        label.textColor = Colors.backgraund
        label.textAlignment = .center
        label.text = "ТОРГОВАТЬ"
        label.font = UIFont(name: "Helvetica-Bold", size: 25.0)
        return label
    }()
    
    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth*0.86, height: 60)
        super.init(frame: useFrame)
        backgroundColor = Colors.orangeGradientTop
        self.layer.cornerRadius = 60/2
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}






extension ButtonView {
    func setSubviews(){
        self.addSubview(label)
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
