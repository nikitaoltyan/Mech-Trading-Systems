//
//  UserDefaults.swift
//  ODA Trading System
//
//  Created by Никита Олтян on 01.06.2021.
//

import Foundation
import UIKit

class Defaults {
    
    let defaults = UserDefaults.standard
    
    func setAlertShown(_ set: Bool) {
        defaults.setValue(set, forKey: "alertShown")
    }
    
    func getAlertShown() -> Bool {
        return defaults.bool(forKey: "alertShown")
    }
}
