//
//  AvengerDetailViewModel.swift
//  AvengersApp
//
//  Created by Javier Laguna on 29/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation
import UIKit

class AvengerDetailViewModel: HeroDetailViewModel {
    
    // MARK: Constants
    let avenger: Avenger
    let repository: AvengersRepository
    
    init(avenger: Avenger, repository: AvengersRepository) {
        self.avenger = avenger
        self.repository = repository
    }
    
    // MARK: HeroDetailViewModel
    var name: String? { avenger.name }
    var image: UIImage? { UIImage(imageLiteralResourceName: avenger.image ?? "") }
    var power: Int { Int(avenger.power) }
    var biography: String? { avenger.biography }
    var tintColor: UIColor { .blueMain }
}
