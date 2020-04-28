//
//  Hero.swift
//  AvengersApp
//
//  Created by Javier Laguna on 28/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

/**
    Helper class to load Avengers and Villains from JSON files
 */
class Hero: Decodable {
    let name: String
    let image: String
    let power: Int
    let biography: String
    
    enum CodingKeys: String, CodingKey {
        case name = "hero_name"
        case image = "hero_image"
        case power = "hero_power"
        case biography = "hero_biography"
    }
}
