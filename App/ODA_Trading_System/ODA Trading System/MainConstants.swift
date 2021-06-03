//
//  MainConstants.swift
//  ODA Trading System
//
//  Created by Никита Олтян on 19.05.2021.
//

import UIKit

struct Colors {
    static let backgraund = UIColor(named: "backgraund") ?? .purple
    static let light = UIColor(named: "light") ?? .lightGray
    static let choosedCell = UIColor(named: "choosedCell") ?? .gray
    static let orangeGradientTop = UIColor(named: "orangeGradientTop") ?? .yellow
    static let orangeGradientBottom = UIColor(named: "orangeGradientBottom") ?? .orange
}




struct MainConstants {
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
}



struct Vibration {

    static func soft() -> Void{
        let soft = UIImpactFeedbackGenerator(style: .soft)
        soft.impactOccurred()
    }
    
    
    static func medium() -> Void{
        let medium = UIImpactFeedbackGenerator(style: .medium)
        medium.impactOccurred()
    }
}
