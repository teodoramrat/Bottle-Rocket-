//
//  RestaurantModel.swift
//  Bottle Rocket
//
//  Created by Teodora Mratinkovic on 11/24/21.
//

import Foundation

struct Restaurants: Codable, Hashable {
    let restaurants: [Restaurant]
}

struct Restaurant: Codable, Hashable {
    let name: String
    let backgroundImageURL: String?
    let category: String
    let contact: RestaurantContact?
    let location: RestaurantLocation
}

struct RestaurantContact: Codable, Hashable {
    let phone: String
    let formattedPhone: String
    let twitter: String?
    let facebook: String?
    let facebookUsername: String?
    let facebookName: String?
}

struct RestaurantLocation: Codable, Hashable {
    let address: String
    let crossStreet: String?
    let lat: Double
    let lng: Double
    let postalCode: String?
    let cc: String
    let city: String
    let state: String
    let country: String
    let formattedAddress: [String]
}
