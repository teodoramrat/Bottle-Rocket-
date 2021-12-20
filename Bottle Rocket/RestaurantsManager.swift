//
//  RestaurantsManager.swift
//  Bottle Rocket
//
//  Created by Teodora Mratinkovic on 12/9/21.
//

import Foundation


let restaurantUrlString: String = "https://s3.amazonaws.com/br-codingexams/restaurants.json"

struct RestaurantsManager {
    
    static func getRestaruants(_ completion: @escaping ([Restaurant]) -> Void) {
        if let data = Cache.cachedDataFrom(urlString: restaurantUrlString) {
            do {
                let result = try JSONDecoder().decode(Restaurants.self, from: data)
                Cache.cacheData(data: data, from: restaurantUrlString)
                completion(result.restaurants)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        } else {
            NetworkManager.load(with: restaurantUrlString) { response in
                switch response {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(Restaurants.self, from: data)
                        Cache.cacheData(data: data, from: restaurantUrlString)
                        completion(result.restaurants)
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
