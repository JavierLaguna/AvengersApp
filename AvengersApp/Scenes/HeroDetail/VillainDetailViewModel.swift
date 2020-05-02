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
    
    // MARK: Lifecycle
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
    var battles: [BattleSmallCellViewModel] {
        return villain.battles?.compactMap { battle in
            guard let battle = battle as? Battle else { return nil }
            return BattleSmallCellViewModel(battle)
        } ?? []
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        // TODO
    }
    
    func editPower() {
        // TODO
    }
    
    func refreshHero() {
        // TODO
    }
}
