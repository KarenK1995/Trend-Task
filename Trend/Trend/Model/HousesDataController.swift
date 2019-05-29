//
//  HousesDataController.swift
//  Trend
//
//  Created by Karen Karapetyan on 5/28/19.
//  Copyright © 2019 Karen Karapetyan. All rights reserved.
//

import Foundation
import MBProgressHUD

protocol HousesDataControllerDelegate: NSObjectProtocol {
    func didRecieveData(houses: Houses)
    func didFailToRecieveData(error: Error)
}

class HousesDataController {
    weak var delegate: HousesDataControllerDelegate?
    
    var isFetchingData = false
    
    var count = 0
    
    public func loadNext(sortBy: String, increaseCount: Bool, priceFrom: String? = nil, priceTo: String? = nil) {
        if isFetchingData { return }
        MBProgressHUD.showProgress()
        isFetchingData = true
        
        if increaseCount {
            self.count += 10
        }
            
        Networking.getHouses(count: count, sort: sortBy, priceFrom: priceFrom, priceTo: priceTo) { (result) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: window, animated: true)
                self.isFetchingData = false
                switch result {
                case .failure(let error):
                    self.delegate?.didFailToRecieveData(error: error)
                case .success(let response):
                    self.delegate?.didRecieveData(houses: response)
                }
            }
        }
    }

}
