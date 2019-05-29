//
//  PricesSelectorView.swift
//  Trend
//
//  Created by Karen Karapetyan on 5/29/19.
//  Copyright © 2019 Karen Karapetyan. All rights reserved.
//

import UIKit

protocol PricesSelectorViewDelegate: NSObjectProtocol {
    
    func priceSelectorView(selectorView: PricesSelectorView, didSelectPrice price: String)
}

enum PriceSelectorViewType {
    case priceFrom
    case priceTo
}

class PricesSelectorView: UIView {

    weak var delegate: PricesSelectorViewDelegate?
    
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let cellID = "Cell"
    
    var prices = [String]()
    var selectedPrice: String?
    
    var selectorType: PriceSelectorViewType! = .priceFrom
    var isExpanded = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    //MARK: Methods
    private func initialSetup() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    private func setPriceToTitleLabel(price: String?) {
        if let price = price {
            switch selectorType! {
            case .priceFrom:
                titleLabel.text = "от " + price + " руб"
            case .priceTo:
                titleLabel.text = "до " + price + " руб"
            }
        }
    }
    
    private func setDefaultTitleText() {
        switch selectorType! {
        case .priceFrom:
            titleLabel.text = "Цена от, руб"
        case .priceTo:
            titleLabel.text = "Цена до, руб"
        }
    }
    
    public func setPricesFromNumber(_ number: Int) {
        setDefaultTitleText()
        prices.removeAll()
        (0..<10).forEach { (i) in
            prices.append(String(number + 500_000 * i))
        }
        tableView.reloadData()
    }
    
    public func animateArrowIcon(top: Bool) {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(top ? Double.pi : 0))
        }, completion: nil)
    }
}

extension PricesSelectorView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)!
        cell.textLabel?.text = String(prices[indexPath.row]) + " руб"
        cell.textLabel?.textAlignment = .center
        return cell
    }
}

extension PricesSelectorView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let price = prices[indexPath.row]
        selectedPrice = price
        setPriceToTitleLabel(price: price)
        delegate?.priceSelectorView(selectorView: self, didSelectPrice: price)
    }
}
