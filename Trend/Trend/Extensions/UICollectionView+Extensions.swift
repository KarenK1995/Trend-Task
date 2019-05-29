//
//  UICollectionView+Extensions.swift
//  Trend
//
//  Created by Karen Karapetyan on 5/28/19.
//  Copyright © 2019 Karen Karapetyan. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func scrollRightForIndexPath(_ indexPath: IndexPath) {
        let itemsCount = numberOfItems(inSection: 0)
        let newCellIndex = indexPath.row + 1
        if newCellIndex <= itemsCount - 1 {
            let rows = self.indexPathsForVisibleItems.map { (indexPath) -> Int in
                return indexPath.row
            }
            if indexPath.row >= rows.max()! - 1 {
                self.scrollToItem(at: IndexPath(row: newCellIndex, section: 0), at: .right, animated: true)
            }
        }
    }
    
}
