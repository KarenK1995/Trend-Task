//
//  Networking.swift
//  Trend
//
//  Created by Karen Karapetyan on 5/28/19.
//  Copyright © 2019 Karen Karapetyan. All rights reserved.
//

import Foundation

enum DataResponseError: Error {
    case network
    case decoding
}

class Networking {
    
    class func getHouses(count: Int, sort: String, priceFrom: String? = nil, priceTo: String? = nil, completion: @escaping (Result<Houses, DataResponseError>) -> Void) {
        
        let url = Endpoint.search(count: count, sort: sort, priceFrom: priceFrom, priceTo: priceTo).url
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let _ = response as? HTTPURLResponse, let data = data
                else {
                    completion(Result.failure(.network))
                    return
            }

            guard let decodedResponse = try? JSONDecoder().decode(HousesResponse.self, from: data) else {
                completion(Result.failure(.decoding))
                return
            }
            
            completion(Result.success(decodedResponse.data))
        }
        task.resume()
    }
}
