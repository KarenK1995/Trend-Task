//
//  HousesModel.swift
//  Trend
//
//  Created by Karen Karapetyan on 5/28/19.
//  Copyright © 2019 Karen Karapetyan. All rights reserved.
//

import Foundation

struct HousesResponse: Codable {
    let error: String?
    let data: Houses
}

struct Houses: Codable {
    let apartmentsCount: Int
    let blocksCount: Int
    let results: [House]
}

struct House: Codable {
    let name: String
    let image: String
    let min_prices: [HousePrice]
    let region: HouseRegion
    let subways: [Subway]
}

struct HousePrice: Codable {
    let rooms: String
    let price: Int
}

struct HouseRegion: Codable {
    let name: String
}

struct Subway: Codable {
    let name: String
}
