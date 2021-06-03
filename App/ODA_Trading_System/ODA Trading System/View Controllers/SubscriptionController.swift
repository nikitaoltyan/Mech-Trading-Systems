//
//  SubscriptionController.swift
//  ODA Trading System
//
//  Created by Никита Олтян on 27.05.2021.
//

import UIKit

class SubscriptionController: UIViewController {

    lazy var header: SettingsHeaderView = {
        let view = SettingsHeaderView()
            .with(autolayout: false)
        view.backgroundColor = Colors.backgraund
        view.label.text = "Приобрети подписку"
        view.delegate = self
        return view
    }()
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 460)
        let collection = UICollectionView(frame: useFrame, collectionViewLayout: layout)
            .with(autolayout: false)
        collection.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30);
        collection.backgroundColor = .clear
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 50
        layout.minimumInteritemSpacing = 1
        
        collection.showsHorizontalScrollIndicator = false
        collection.isScrollEnabled = true
        collection.isPagingEnabled = true
        collection.delegate = self
        collection.dataSource = self
        collection.register(SubscriptionCellOne.self, forCellWithReuseIdentifier: "SubscriptionCellOne")
        collection.register(SubscriptionCellTwo.self, forCellWithReuseIdentifier: "SubscriptionCellTwo")
        return collection
    }()
    
    let button: ButtonView = {
        let view = ButtonView()
            .with(autolayout: false)
        view.clipsToBounds = true
        view.label.text = "КУПИТЬ ПОДПИСКУ"
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgraund
        setSubviews()
        activateLayouts()
    }

    
    @objc
    func buttonTap() {
        let alert = UIAlertController(title: "Приносим извинения!",
                                      message: "Это учебное приложение и приобрести подписку еще нельзя. Данный экран разработан для примера монетизации алгоритма. Данная работа была выполнена для получения зачета, спасибо!",
                                      preferredStyle: .actionSheet)
            
        alert.addAction(UIAlertAction(title: "Поставить зачет", style: .cancel, handler:{ (UIAlertAction) in
            print("Close")
        }))
        present(alert, animated: true, completion: nil)
    }

}


extension SubscriptionController: SettingsHeaderDelegate {
    func backTap() {
        Vibration.soft()
        dismiss(animated: true, completion: nil)
    }
}





extension SubscriptionController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: MainConstants.screenWidth-65, height: 460)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "SubscriptionCellOne", for: indexPath) as! SubscriptionCellOne
            cell.clipsToBounds = true
            return cell
        default:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "SubscriptionCellTwo", for: indexPath) as! SubscriptionCellTwo
            cell.clipsToBounds = true
            return cell
        }
    }
}





extension SubscriptionController {
    func setSubviews(){
        view.addSubview(header)
        view.addSubview(collection)
        view.addSubview(button)
        
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTap)))
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            header.heightAnchor.constraint(equalToConstant: header.frame.height),
            header.widthAnchor.constraint(equalToConstant: header.frame.width),
            
            collection.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 30),
            collection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collection.widthAnchor.constraint(equalToConstant: collection.frame.width),
            collection.heightAnchor.constraint(equalToConstant: collection.frame.height),
            
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: button.frame.height),
            button.widthAnchor.constraint(equalToConstant: button.frame.width),
        ])
    }
}
