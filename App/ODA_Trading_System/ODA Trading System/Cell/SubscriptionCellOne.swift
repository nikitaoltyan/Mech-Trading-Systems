//
//  SubscriptionCell.swift
//  ODA Trading System
//
//  Created by Никита Олтян on 01.06.2021.
//

import UIKit

class SubscriptionCellOne: UICollectionViewCell {
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = [UIColor(red: 252/255, green: 249/255, blue: 254/255, alpha: 1).cgColor,
                           UIColor(red: 214/255, green: 147/255, blue: 245/255, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        return gradient
    }()
    
    let title: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
        label.textColor = Colors.backgraund
        label.textAlignment = .left
        label.text = "Platinum"
        label.font = UIFont(name: "Helvetica-Light", size: 21)
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
        label.textColor = .gray
        label.textAlignment = .left
        label.text = "Раскройте весь потенциал"
        label.font = UIFont(name: "Helvetica-Light", size: 16)
        return label
    }()
    
    let price: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
        label.textColor = Colors.backgraund
        label.textAlignment = .left
        label.text = "1250 ₽/мес."
        label.font = UIFont(name: "Helvetica-Bold", size: 21.0)
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
        text.text = "• Неограниченное число сделок в месяц. \n\n• Гарантированная доходность 20% годовых.\n\n• Возможность выбирать ценные бумаги для нализа."
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 25
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}




extension SubscriptionCellOne {
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
