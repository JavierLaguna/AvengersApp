//
//  VillainDetailViewModel.swift
//  AvengersApp
//
//  Created by Javier Laguna on 29/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation
import UIKit

protocol VillainDetailCoordinatorDelegate: class {
    func editPower(for villain: Villain)
    func viewDidFinish()
}

protocol VillainDetailViewDelegate: class {
    func villainFetched()
}

class VillainDetailViewModel: HeroDetailViewModel {

    // MARK: Constants
    let repository: VillainsRepository
    
    // MARK: Variables
    private var villain: Villain
    weak var coordinatorDelegate: VillainDetailCoordinatorDelegate?
    weak var viewDelegate: VillainDetailViewDelegate?
    
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
    var heroModified: Bool = false
    
    func didSelectRow(at indexPath: IndexPath) {
        // TODO
    }
    
    func editPower() {
        coordinatorDelegate?.editPower(for: villain)
    }
    
    func refreshHero() {
        guard let name = villain.name,
              let villain = repository.fetchVillainBy(name: name) else {
                  return Log.error("Can not fetch avenger from repo")
          }
          
          self.villain = villain
          self.heroModified = true
          viewDelegate?.villainFetched()
    }
    
    func viewDidFinish() {
        coordinatorDelegate?.viewDidFinish()
    }
}
