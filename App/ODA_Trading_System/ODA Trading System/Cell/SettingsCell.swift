//
//  SettingsCell.swift
//  ODA Trading System
//
//  Created by Никита Олтян on 27.05.2021.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    let label: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
        label.textColor = Colors.light
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica", size: 19.0)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Colors.backgraund
        setSubviews()
        activateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}





extension SettingsCell {
    func setSubviews(){
        self.addSubview(label)
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
}
