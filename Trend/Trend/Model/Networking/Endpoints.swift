//
//  Endpoints.swift
//  Trend
//
//  Created by Karen Karapetyan on 5/28/19.
//  Copyright © 2019 Karen Karapetyan. All rights reserved.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]?
}

extension Endpoint {
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "api.trend-dev.ru"
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}

extension Endpoint {
    
    static func search(count: Int, sort: String, priceFrom: String? = nil, priceTo: String? = nil) -> Endpoint {
        var queryItems = [URLQueryItem(name: "show_type", value: "list"),
                          URLQueryItem(name: "count", value: String(count)),
                          URLQueryItem(name: "sort", value: sort)]
        
        if let priceFrom = priceFrom {
            queryItems.append(URLQueryItem(name: "price_from", value: priceFrom))
        }
        
        if let priceTo = priceTo {
            queryItems.append(URLQueryItem(name: "price_to", value: priceTo))
        }
        
        return Endpoint(path: "/v3_1/blocks/search/", queryItems: queryItems)
    }
}
