//
//  Server.swift
//  ODA Trading System
//
//  Created by Никита Олтян on 25.05.2021.
//

import Foundation
import UIKit

class Server {
    
    func fetchData(forTicker ticker: String, completion: @escaping ([String:Any]?, Error?) -> Void) {
        let url = URL(string: "https://oda-tool.herokuapp.com/\(ticker)")!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                if let array = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] {
                    completion(array, nil)
                }
            } catch {
                print(error)
                completion(nil, error)
            }
        }
        task.resume()
    }
    
}
