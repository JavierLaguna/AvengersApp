//
//  VillainDetailViewModel.swift
//  AvengersApp
//
//  Created by Javier Laguna on 29/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation
import UIKit

class VillainDetailViewModel: HeroDetailViewModel {
    
    // MARK: Constants
    let villain: Villain
    let repository: VillainsRepository
    
    init(villain: Villain, repository: VillainsRepository) {
        self.villain = villain
        self.repository = repository
    }
    
    // MARK: HeroDetailViewModel
    var name: String? { villain.name }
    var image: UIImage? { UIImage(imageLiteralResourceName: villain.image ?? "") }
    var power: Int { Int(villain.power) }
    var biography: String? { villain.biography }
    var tintColor: UIColor { .redMain }
}
