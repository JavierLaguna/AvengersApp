//
//  HeroCellViewModel.swift
//  AvengersApp
//
//  Created by Javier Laguna on 27/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation
import UIKit

struct HeroCellViewModel {
    
    let nameTitle: String
    let image: UIImage?
    let power: Int
    let tintColor: UIColor
    
    init(_ avenger: Avenger) {
        self.nameTitle = avenger.name ?? ""
        self.image = UIImage(imageLiteralResourceName: avenger.image ?? "")
        self.power = Int(avenger.power)
        self.tintColor = .blueMain
    }
}
