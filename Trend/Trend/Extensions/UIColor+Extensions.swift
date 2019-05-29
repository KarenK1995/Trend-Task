//
//  UIColor+Extensions.swift
//  Trend
//
//  Created by Karen Karapetyan on 5/28/19.
//  Copyright © 2019 Karen Karapetyan. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func RGBA(_ r:CGFloat, _ g:CGFloat, _ b:CGFloat, _ a:CGFloat) -> UIColor {
        let color = UIColor(red:r/255.0, green:g/255.0, blue:b/255.0, alpha:a)
        return color
    }
}

