//
//  AvengerDetailViewModel.swift
//  AvengersApp
//
//  Created by Javier Laguna on 29/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation
import UIKit

protocol AvengerDetailCoordinatorDelegate: class {
    func editPower(for avenger: Avenger)
}

protocol AvengerDetailViewDelegate: class {
    func avengerFetched()
}

class AvengerDetailViewModel: HeroDetailViewModel {
    
    // MARK: Constants
    private let repository: AvengersRepository
    
    // MARK: Variables
    private var avenger: Avenger
    weak var coordinatorDelegate: AvengerDetailCoordinatorDelegate?
    weak var viewDelegate: AvengerDetailViewDelegate?
    
    // MARK: Lifecycle
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
    var battles: [BattleSmallCellViewModel] {
        return avenger.battles?.compactMap { battle in
            guard let battle = battle as? Battle else { return nil }
            return BattleSmallCellViewModel(battle)
            } ?? []
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        // TODO
    }
    
    func editPower() {
        coordinatorDelegate?.editPower(for: avenger)
    }
    
    func refreshHero() {
        guard let name = avenger.name,
            let avenger = repository.fetchAvengerBy(name: name) else {
                return Log.error("Can not fetch avenger from repo")
        }
        
        self.avenger = avenger
        viewDelegate?.avengerFetched()
    }
}
