//
//  ODADescriptionController.swift
//  ODA Trading System
//
//  Created by Никита Олтян on 27.05.2021.
//

import UIKit

class ODADescriptionController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
            .with(autolayout: false)
        scroll.contentSize = CGSize(width: MainConstants.screenWidth, height: 1050)
        scroll.bounces = true
        scroll.isUserInteractionEnabled = true
        scroll.showsVerticalScrollIndicator = true
        scroll.isScrollEnabled = true
        return scroll
    }()

    lazy var header: SettingsHeaderView = {
        let view = SettingsHeaderView()
            .with(autolayout: false)
        view.backgroundColor = Colors.backgraund
        view.label.text = "О работе ODA"
        view.delegate = self
        return view
    }()
    
    let text: UITextView = {
        let text = UITextView()
            .with(autolayout: false)
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.textColor = Colors.light
        text.isUserInteractionEnabled = false
        text.font = UIFont(name: "Helvetica", size: 18)
        text.text = "Наш сервис использует API архитектуру для взаимодействия с устройствами, что даем нам возможность расширять варианты доступа к ODA."
        return text
    }()
    
    let image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth-50, height: MainConstants.screenWidth-50))
            .with(autolayout: false)
        image.image = UIImage(named: "server")
        return image
    }()
    
    let text_2: UITextView = {
        let text = UITextView()
            .with(autolayout: false)
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.textColor = Colors.light
        text.isUserInteractionEnabled = false
        text.font = UIFont(name: "Helvetica", size: 18)
        text.text = "Бот живет на севере, где  мониторит катировки ценных бумаг и регулярно принимает решения об их покупке и продаже. Для этого он использует сложные математические алгоритмы, реализованные нашими разработчиками. \n\nПользователь может подключиться к нему через приложение или любую возможную точку доступа к системе API, чтобы понаблюдать за его работой. "
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgraund
        setSubviews()
        activateLayouts()
    }
}






extension ODADescriptionController: SettingsHeaderDelegate {
    func backTap() {
        Vibration.soft()
        dismiss(animated: true, completion: nil)
    }
}



extension ODADescriptionController {
    func setSubviews(){
        view.addSubview(scrollView)
        scrollView.addSubview(header)
        scrollView.addSubview(text)
        scrollView.addSubview(image)
        scrollView.addSubview(text_2)
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                        
            header.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            header.heightAnchor.constraint(equalToConstant: header.frame.height),
            header.widthAnchor.constraint(equalToConstant: header.frame.width),
            
            text.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 0),
            text.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            text.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            text.heightAnchor.constraint(equalToConstant: 150),
            
            image.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 8),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: image.frame.height),
            image.widthAnchor.constraint(equalToConstant: image.frame.width),
            
            text_2.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            text_2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            text_2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            text_2.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
}

