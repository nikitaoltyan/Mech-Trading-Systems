//
//  UIView+Extension.swift
//  ODA Trading System
//
//  Created by Никита Олтян on 19.05.2021.
//

import UIKit

extension UIView {
    func with(autolayout: Bool) -> Self {
        translatesAutoresizingMaskIntoConstraints = autolayout
        return self
    }
}
