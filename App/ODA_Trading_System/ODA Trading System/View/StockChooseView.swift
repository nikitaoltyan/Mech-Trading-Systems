//
//  StockChooseView.swift
//  ODA Trading System
//
//  Created by Никита Олтян on 19.05.2021.
//

import UIKit



protocol StockChooseDelegate {
    func chooseStock(ticker: String)
}



class StockChooseView: UIView {
    
    let title: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
        label.textColor = Colors.light
        label.textAlignment = .left
        label.text = "Попробуй эти акции"
        label.font = UIFont(name: "Helvetica", size: 20.0)
        return label
    }()
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 150)
        let collection = UICollectionView(frame: useFrame, collectionViewLayout: layout)
            .with(autolayout: false)
        collection.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30);
        collection.backgroundColor = .clear
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 1
        
        collection.showsHorizontalScrollIndicator = false
        collection.isScrollEnabled = true
        collection.delegate = self
        collection.dataSource = self
        collection.register(StockCell.self, forCellWithReuseIdentifier: "StockCell")
        return collection
    }()
    
    var delegate: StockChooseDelegate?
    
    var currentSelectedIndexPath: IndexPath?
    let stockTickers: [String] = ["AAPL", "T", "C", "LGH"]
    let stockNames: [String] = ["Apple", "AT&T", "Citi", "Lufthansa"]
    let images: [UIImage?] = [UIImage(named: "apple_logo"),
                             UIImage(named: "T"),
                             UIImage(named: "CITI"),
                             UIImage(named: "LTH")]
    
    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 190)
        super.init(frame: useFrame)
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}





extension StockChooseView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "StockCell", for: indexPath) as! StockCell
        cell.logo.image = images[indexPath.row]
        cell.title.text = stockNames[indexPath.row]
        cell.ticker = stockTickers[indexPath.row]
        if indexPath.row == 0 {
            cell.select()
            currentSelectedIndexPath = indexPath
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Vibration.soft()
        guard (currentSelectedIndexPath != indexPath) else { return }
        if let cell = collection.cellForItem(at: currentSelectedIndexPath ?? indexPath) as? StockCell {
            cell.unselect()
        }
        
        if let cell = collection.cellForItem(at: indexPath) as? StockCell {
            cell.select()
            delegate?.chooseStock(ticker: cell.ticker)
            currentSelectedIndexPath = indexPath
        }
    }
}







extension StockChooseView {
    func setSubviews(){
        self.addSubview(title)
        self.addSubview(collection)
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor),
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            
            collection.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            collection.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            collection.heightAnchor.constraint(equalToConstant: collection.frame.height),
            collection.widthAnchor.constraint(equalToConstant: collection.frame.width)
        ])
    }
}
