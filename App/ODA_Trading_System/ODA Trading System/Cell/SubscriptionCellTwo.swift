//
//  CollectionViewCell.swift
//  ODA Trading System
//
//  Created by Никита Олтян on 01.06.2021.
//

import UIKit

class SubscriptionCellTwo: UICollectionViewCell {
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = [UIColor(red: 255/255, green: 245/255, blue: 0/255, alpha: 1).cgColor,
                           UIColor(red: 212/255, green: 100/255, blue: 231/255, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        return gradient
    }()
    
    let title: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
        label.textColor = Colors.backgraund
        label.textAlignment = .left
        label.text = "Gold"
        label.font = UIFont(name: "Helvetica-Light", size: 21)
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
        label.textColor = .gray
        label.textAlignment = .left
        label.text = "Стартуй и повышай доход"
        label.font = UIFont(name: "Helvetica-Light", size: 16.0)
        return label
    }()
    
    let price: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
        label.textColor = Colors.backgraund
        label.textAlignment = .left
        label.text = "550 ₽/мес."
        label.font = UIFont(name: "Helvetica-Bold", size: 21)
        return label
    }()
    
    let text: UITextView = {
        let text = UITextView()
            .with(autolayout: false)
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.textColor = Colors.backgraund
        text.isUserInteractionEnabled = false
        text.font = UIFont(name: "Helvetica-Light", size: 18)
        text.text = "• 30 сделок в месяц. \n\n• Ожидаемая доходность больше 10% годовых.\n\n• Аналитика 5 компаний."
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 25
        self.backgroundColor = UIColor(red: 214/255, green: 147/255, blue: 245/255, alpha: 1)
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}





extension SubscriptionCellTwo {
    func setSubviews(){
        self.layer.addSublayer(gradient)
        self.addSubview(title)
        self.addSubview(subtitle)
        self.addSubview(price)
        self.addSubview(text)
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 34),
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 37),
            
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 2),
            subtitle.leftAnchor.constraint(equalTo: title.leftAnchor),
            
            price.leftAnchor.constraint(equalTo: title.leftAnchor),
            price.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 40),
            
            text.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 60),
            text.leftAnchor.constraint(equalTo: title.leftAnchor),
            text.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -37),
            text.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
