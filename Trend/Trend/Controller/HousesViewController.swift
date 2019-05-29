//
//  HousesViewController.swift
//  Trend
//
//  Created by Karen Karapetyan on 5/28/19.
//  Copyright © 2019 Karen Karapetyan. All rights reserved.
//

import UIKit

class HousesViewController: UIViewController {
    
    @IBOutlet weak var filtersSelectorView: FiltersSelectorView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var objectsCountLabel: UILabel!
    
    @IBOutlet weak var priceFromContainerView: UIView!
    @IBOutlet weak var priceFromContainerHeight: NSLayoutConstraint!
    var priceFromView: PricesSelectorView!
    
    @IBOutlet weak var priceToContainerView: UIView!
    @IBOutlet weak var priceToContainerHeight: NSLayoutConstraint!
    var priceToView: PricesSelectorView!
    
    let cellID = "HouseCellID"
    let dataController = HousesDataController()
    
    lazy var tableFooterView = { () -> HousesTableFooterView in
        let footerView = Bundle.main.loadNibNamed("HousesTableFooterView", owner: self, options: nil)![0] as! HousesTableFooterView
        footerView.loadButton.addTarget(self, action: #selector(loadButtonAction(_:)), for: .touchUpInside)
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 75)
        return footerView
    }()
    
    var houses: Houses? {
        didSet {
            tableView.tableFooterView = tableFooterView
            tableView.reloadData()
        }
    }
    
    var selectedFilter = FiltersSelectorView.filters[0]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initialSetup()
    }
    
    //MARK: Methods
    private func initialSetup() {
        filtersSelectorView.delegate = self
        tableView.register(UINib(nibName: "HouseTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        dataController.delegate = self
        dataController.loadNext(sortBy: selectedFilter.value, increaseCount: true)
        
        
        let priceFromView = Bundle.main.loadNibNamed("PricesSelectorView", owner: self, options: nil)![0] as! PricesSelectorView
        priceFromView.delegate = self
        priceFromView.selectorType = .priceFrom
        priceFromView.setPricesFromNumber(1_000_000)
        priceFromView.button.addTarget(self, action: #selector(priceFromButtonAction(_:)), for: .touchUpInside)
        self.priceFromView = priceFromView
        addPriceView(priceFromView, toContainerView: priceFromContainerView)
        
        let priceToView = Bundle.main.loadNibNamed("PricesSelectorView", owner: self, options: nil)![0] as! PricesSelectorView
        priceToView.delegate = self
        priceToView.selectorType = .priceTo
        priceToView.setPricesFromNumber(6_000_000)
        priceToView.button.addTarget(self, action: #selector(priceToButtonAction(_:)), for: .touchUpInside)
        self.priceToView = priceToView
        addPriceView(priceToView, toContainerView: priceToContainerView)
    }
    
    private func addPriceView(_ priceView: PricesSelectorView, toContainerView container: UIView) {
        container.addSubview(priceView)
        priceView.translatesAutoresizingMaskIntoConstraints = false
        let top = NSLayoutConstraint(item: priceView, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: priceView, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: priceView, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: priceView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        view.addConstraints([height, top, leading, trailing])
    }
    
    private func animatePriceSelectorView(_ selectorView: PricesSelectorView) {
        var containerHeight: NSLayoutConstraint!
        if selectorView.selectorType == .priceFrom {
            containerHeight = priceFromContainerHeight
        }
        else {
            containerHeight = priceToContainerHeight
        }
        
        if !selectorView.isExpanded {
            containerHeight.constant = 300
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        else {
            containerHeight.constant = 50
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        selectorView.animateArrowIcon(top: !selectorView.isExpanded)
        selectorView.isExpanded = !selectorView.isExpanded
    }
    
    //MARK: Actions
    @objc func loadButtonAction(_ sender: UIButton) {
        dataController.loadNext(sortBy: selectedFilter.value, increaseCount: true, priceFrom: priceFromView.selectedPrice, priceTo: priceToView.selectedPrice)
    }
    
    @objc func priceFromButtonAction(_ sender: UIButton) {
        animatePriceSelectorView(priceFromView)
    }
    
    @objc func priceToButtonAction(_ sender: UIButton) {
        animatePriceSelectorView(priceToView)
    }
    
}

extension HousesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houses?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! HouseTableViewCell
        cell.house = houses?.results[indexPath.row]
        return cell
    }
}

extension HousesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
}

extension HousesViewController: HousesDataControllerDelegate {
    
    func didRecieveData(houses: Houses) {
        self.houses = houses
        objectsCountLabel.text = "\(houses.blocksCount) объектов:"
    }
    
    func didFailToRecieveData(error: Error) {
        UIAlertController.showBasicOn(controller: self, withTitle: "Ошибка", message: error.localizedDescription)
    }
}

extension HousesViewController: FiltersSelectorViewDelegate {
    
    func didSelectFilter(filter: Filter) {
        selectedFilter = filter        
        dataController.loadNext(sortBy: selectedFilter.value, increaseCount: false, priceFrom: priceFromView.selectedPrice, priceTo: priceToView.selectedPrice)
    }
}

extension HousesViewController: PricesSelectorViewDelegate {
    
    func priceSelectorView(selectorView: PricesSelectorView, didSelectPrice price: String) {
        animatePriceSelectorView(selectorView)
        
        dataController.loadNext(sortBy: selectedFilter.value, increaseCount: false, priceFrom: priceFromView.selectedPrice, priceTo: priceToView.selectedPrice)
        
        if selectorView == priceFromView {
            priceToView.setPricesFromNumber(Int(price)! + 500_000)
        }
    }
}
