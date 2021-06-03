//
//  SettingsController.swift
//  ODA Trading System
//
//  Created by Никита Олтян on 27.05.2021.
//

import UIKit

class SettingsController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgraund
        tableView.separatorColor = Colors.light
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SettingsHeaderView()
        view.label.font = UIFont(name: "Helvetica-Bold", size: 35)
        view.delegate = self
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        switch indexPath.row {
        case 0:
            cell.label.text = "О работе ODA"
        case 1:
            cell.label.text = "Как работает алгоритм?"
        default:
            cell.label.text = "Приобрети подписку"
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let newVC = ODADescriptionController()
            newVC.modalPresentationStyle = .fullScreen
            present(newVC, animated: true, completion: nil)
        case 1:
            let newVC = AlgorithmDescriptionController()
            newVC.modalPresentationStyle = .fullScreen
            present(newVC, animated: true, completion: nil)
        default:
            let newVC = SubscriptionController()
            newVC.modalPresentationStyle = .fullScreen
            present(newVC, animated: true, completion: nil)
        }
        
    }

}




extension SettingsController: SettingsHeaderDelegate {
    func backTap() {
        print("Back was tapped")
        Vibration.soft()
        dismiss(animated: true, completion: nil)
    }
}
