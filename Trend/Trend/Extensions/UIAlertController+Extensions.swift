//
//  UIAlertController+Extensions.swift
//  Trend
//
//  Created by Karen Karapetyan on 5/28/19.
//  Copyright © 2019 Karen Karapetyan. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    class func showBasicOn(controller: UIViewController, withTitle title: String?, message : String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        controller.present(alert, animated: true, completion: nil)
    }
}
