//
//  Product.swift
//  YogaProducts
//
//  Created by Haroon Ur Rasheed on 03/10/2020.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let name: String
    let description: String
    let cost: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, description = "description_html", cost = "subscription_cycle_length"
    }
}
