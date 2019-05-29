//
//  HousesTableFooterView.swift
//  Trend
//
//  Created by Karen Karapetyan on 5/28/19.
//  Copyright © 2019 Karen Karapetyan. All rights reserved.
//

import UIKit

class HousesTableFooterView: UIView {
    
    @IBOutlet weak var loadButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        loadButton.layer.borderColor = UIColor.RGBA(153, 153, 153, 1).cgColor
        loadButton.layer.borderWidth = 1.0
        loadButton.layer.cornerRadius = 2
    }
    
}
