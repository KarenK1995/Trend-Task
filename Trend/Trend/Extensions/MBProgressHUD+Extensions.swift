//
//  MBProgressHUD+Extensions.swift
//  Trend
//
//  Created by Karen Karapetyan on 5/28/19.
//  Copyright © 2019 Karen Karapetyan. All rights reserved.
//

import UIKit
import MBProgressHUD

extension MBProgressHUD {
    
    class func showProgress() {
        let appWindow = (UIApplication.shared.delegate?.window)!!
        let alert = MBProgressHUD.showAdded(to: appWindow, animated: true)
        alert.mode = .indeterminate
        alert.animationType = .zoom
        alert.label.text = NSLocalizedString("Загрузка", comment: "")
    }
}
