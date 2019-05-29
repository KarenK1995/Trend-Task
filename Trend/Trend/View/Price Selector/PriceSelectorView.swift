//
//  PriceSelectorView.swift
//  Trend
//
//  Created by Karen Karapetyan on 5/29/19.
//  Copyright © 2019 Karen Karapetyan. All rights reserved.
//

import UIKit

class PricesSelectorView: UIView {

    
    let cellID = "Cell"
    var collectionView: UICollectionView!
    var isDefaultItemSelected = false
    
    static let filters = [Filter(name: "по цене", value: "price"),
                          Filter(name: "по району", value: "region"),
                          Filter(name: "по метро", value: "subway")]
    
    weak var delegate: FiltersSelectorViewDelegate?
    
    var animatedIndexPaths = [IndexPath]()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }
    
    private func setup() {
        backgroundColor = .clear
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        
        collectionView.backgroundColor = .clear
        addSubview(collectionView)
        
        let selctedIndexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selctedIndexPath, animated: true, scrollPosition: .left)
        self.collectionView = collectionView
    }

}
