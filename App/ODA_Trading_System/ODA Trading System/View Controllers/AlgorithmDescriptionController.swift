//
//  AlgorithmController.swift
//  ODA Trading System
//
//  Created by Nikita Oltyan on 27.05.2021.
//

import UIKit

class AlgorithmDescriptionController: UIViewController {

    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
            .with(autolayout: false)
        scroll.contentSize = CGSize(width: MainConstants.screenWidth, height: 990)
        scroll.bounces = true
        scroll.isUserInteractionEnabled = true
        scroll.showsVerticalScrollIndicator = true
        scroll.isScrollEnabled = true
        scroll.delegate = self
        return scroll
    }()
    
    lazy var header: SettingsHeaderView = {
        let view = SettingsHeaderView()
            .with(autolayout: false)
        view.backgroundColor = Colors.backgraund
        view.label.text = "Как работает алгоритм?"
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
        text.text = "Алгоритм основан на двух индикаторах: полосы Боллинджера и Стохастик \n\nСделка на покупку совершается, когда цена пересекает нижнюю полосу Боллинджера, а быстрая линия Стохастик пересекает верхнюю снизу вверх."
        return text
    }()
    
    let text_2: UITextView = {
        let text = UITextView()
            .with(autolayout: false)
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.textColor = Colors.light
        text.isUserInteractionEnabled = false
        text.font = UIFont(name: "Helvetica-Bold", size: 20)
        text.text = "Пример на графике:"
        return text
    }()
    
    let image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth+200, height: 249))
            .with(autolayout: false)
        image.image = UIImage(named: "chart_strategy")
        return image
    }()
    
    let text_3: UITextView = {
        let text = UITextView()
            .with(autolayout: false)
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.textColor = Colors.light
        text.isUserInteractionEnabled = false
        text.font = UIFont(name: "Helvetica", size: 18)
        text.text = "Выход из сделки осуществляется по достижения цены Stop Loss или Take Profit. Эти значения определяются системой на основе исторических данных используемого тикера (на промежутке 5 лет. Дневной датафрейм.) \n\nДля робота установлен дневной таймфрэйм. Ингода робот не совершает сделки несколько дней."
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgraund
        setSubviews()
        activateLayouts()
    }

}





extension AlgorithmDescriptionController: SettingsHeaderDelegate {
    func backTap() {
        Vibration.soft()
        dismiss(animated: true, completion: nil)
    }
}



extension AlgorithmDescriptionController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Did scroll")
    }
}




extension AlgorithmDescriptionController {
    func setSubviews(){
        view.addSubview(scrollView)
        scrollView.addSubview(header)
        scrollView.addSubview(text)
        scrollView.addSubview(image)
        scrollView.addSubview(text_3)
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
            text.heightAnchor.constraint(equalToConstant: 215),
            
            image.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 8),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: image.frame.height),
            image.widthAnchor.constraint(equalToConstant: image.frame.width),
            
            text_3.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            text_3.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            text_3.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            text_3.heightAnchor.constraint(equalToConstant: 270),
        ])
    }
}
