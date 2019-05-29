//
//  FilterCollectionViewCell.swift
//  Trend
//
//  Created by Karen Karapetyan on 5/28/19.
//  Copyright © 2019 Karen Karapetyan. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var underlineView: UIView!
    
    var filter: Filter! {
        didSet {
            nameLabel.text = filter.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                nameLabel.textColor = .black
                underlineView.isHidden = false
                UIView.animate(withDuration: 0.2) {
                    self.nameLabel.transform = CGAffineTransform.identity.scaledBy(x: 1.15, y: 1.15)
                }
            }
            else {
                nameLabel.textColor = .darkGray
                nameLabel.transform = CGAffineTransform.identity
                underlineView.isHidden = true
            }
        }
    }
}
