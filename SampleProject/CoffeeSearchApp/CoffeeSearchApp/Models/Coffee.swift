//
//  Coffee.swift
//  CoffeeSearchApp
//
//  Created by 석기권 on 6/14/24.
//

import Foundation

struct CoffeeList: Decodable {
    let list: [Coffee]
}

struct Coffee: Decodable {
    let _id: String
    let id: Int
    let name: String
    let description: String
    let price: Double
    let region: String
    let weight: Int
    let roast_level: Int
    let flavor_profile: [String]
    let grind_option: [String]
    let image_url: String
}
