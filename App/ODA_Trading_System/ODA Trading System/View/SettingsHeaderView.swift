//
//  SettingsHeaderView.swift
//  ODA Trading System
//
//  Created by Никита Олтян on 28.05.2021.
//

import UIKit

protocol SettingsHeaderDelegate {
    func backTap()
}

class SettingsHeaderView: UIView {
    
    let backButton: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 27))
            .with(autolayout: false)
        image.image = UIImage(systemName: "chevron.left")
        image.tintColor = Colors.light
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let label: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
        label.textColor = Colors.light
        label.textAlignment = .left
        label.text = "Меню"
        label.font = UIFont(name: "Helvetica-Bold", size: 28.0)
        return label
    }()
    
    var delegate: SettingsHeaderDelegate?

    
    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 120)
        super.init(frame: useFrame)
        backgroundColor = Colors.choosedCell
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    
    @objc
    func backTap(){
        delegate?.backTap()
    }
}




extension SettingsHeaderView {
    func setSubviews(){
        self.addSubview(backButton)
        self.addSubview(label)
        
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backTap)))
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            backButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: backButton.frame.height),
            backButton.widthAnchor.constraint(equalToConstant: backButton.frame.width),
            
            label.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            label.leftAnchor.constraint(equalTo: backButton.leftAnchor),
//            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
}
