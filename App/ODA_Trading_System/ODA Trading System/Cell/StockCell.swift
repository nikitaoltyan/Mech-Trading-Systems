//
//  StockCell.swift
//  ODA Trading System
//
//  Created by Никита Олтян on 19.05.2021.
//

import UIKit

class StockCell: UICollectionViewCell {
    
    let mainView: UIView = {
        let view = UIView()
            .with(autolayout: false)
        view.backgroundColor = Colors.choosedCell
        view.layer.cornerRadius = 19
        return view
    }()
    
    let logo: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 56, height: 56))
            .with(autolayout: false)
        image.clipsToBounds = true
        image.image = UIImage(named: "apple_logo")
        image.layer.cornerRadius = 56/2
        return image
    }()
    
    let title: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
        label.textColor = Colors.light
        label.textAlignment = .center
        label.text = "AAPL"
        label.font = UIFont(name: "Helvetica-Bold", size: 18.0)
        return label
    }()
    
    var ticker: String = "AAPL"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func select(){
        mainView.layer.borderWidth = 2
        mainView.layer.borderColor = Colors.orangeGradientTop.cgColor
    }
    
    func unselect(){
        mainView.layer.borderWidth = 0
    }
}






extension StockCell {
    func setSubviews(){
        self.addSubview(mainView)
        mainView.addSubview(logo)
        mainView.addSubview(title)
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.leftAnchor.constraint(equalTo: self.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: self.rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            logo.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 13),
            logo.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            logo.heightAnchor.constraint(equalToConstant: logo.frame.height),
            logo.widthAnchor.constraint(equalToConstant: logo.frame.width),
            
            title.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 15),
            title.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        ])
    }
}
