//
//  HouseTableViewCell.swift
//  Trend
//
//  Created by Karen Karapetyan on 5/28/19.
//  Copyright © 2019 Karen Karapetyan. All rights reserved.
//

import UIKit
import Alamofire

class HouseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var houseImageView: UIImageView!
    
    @IBOutlet var roomLabels: [UILabel]!
    @IBOutlet var priceLabels: [UILabel]!
    
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var subwayLabel: UILabel!
    
    var house: House? {
        didSet {
            guard let house = house else { return }
            nameLabel.text = house.name
            
            houseImageView.image = nil
            Alamofire.request(house.image, method: .get).response { (response) in
                if let imageData = response.data {
                    self.houseImageView.image = UIImage(data: imageData)
                }
            }

            for (index, housePrice) in house.min_prices.prefix(4).enumerated() {
                let roomsLabel = roomLabels[index]
                roomsLabel.text = housePrice.rooms
                roomsLabel.isHidden = false
                
                let priceLabel = priceLabels[index]
                priceLabel.text = "от \(housePrice.price) руб."
                priceLabel.isHidden = false
            }
            
            regionLabel.text = house.region.name
            subwayLabel.text = house.subways.first?.name ?? ""
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
