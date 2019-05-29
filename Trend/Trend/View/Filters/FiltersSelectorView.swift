//
//  FiltersSelectorView.swift
//  Trend
//
//  Created by Karen Karapetyan on 5/28/19.
//  Copyright © 2019 Karen Karapetyan. All rights reserved.
//

import UIKit

protocol FiltersSelectorViewDelegate: NSObjectProtocol {
    func didSelectFilter(filter: Filter)
}

class FiltersSelectorView: UIView {
    
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

extension FiltersSelectorView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FiltersSelectorView.filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! FilterCollectionViewCell
        cell.filter = FiltersSelectorView.filters[indexPath.row]
        return cell
    }
}

extension FiltersSelectorView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedFilter = FiltersSelectorView.filters[indexPath.row]
        delegate?.didSelectFilter(filter: selectedFilter)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension FiltersSelectorView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = collectionView.frame.height
        let width = FiltersSelectorView.filters[indexPath.row].name.width(withConstraintedHeight: height, font: UIFont.systemFont(ofSize: 18, weight: .bold))
        return CGSize(width: width, height: height)
    }
}
