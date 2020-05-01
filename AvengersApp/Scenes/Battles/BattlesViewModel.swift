//
//  BattlesViewModel.swift
//  AvengersApp
//
//  Created by Javier Laguna on 30/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

protocol BattlesCoordinatorDelegate: class {
    func addBattleButtonTapped()
    func didSelect(battle: Battle)
}

protocol BattlesViewDelegate: class {
    func battlesFetched()
    func errorFetchingBattles()
}

class BattlesViewModel {
    weak var coordinatorDelegate: BattlesCoordinatorDelegate?
    weak var viewDelegate: BattlesViewDelegate?
    let repository: BattlesRepository
    var battleCellViewModels: [BattleCellViewModel] = []
    var battles = [Battle]() {
        didSet {
            battleCellViewModels = battles.map { BattleCellViewModel($0) }
        }
    }
    
    init(repository: BattlesRepository) {
        self.repository = repository
    }
    
    func viewWasLoaded() {
        fetchBattles()
    }
    
    func numberOfRows(in section: Int) -> Int {
        return battleCellViewModels.count
    }
    
    func viewModelCell(at indexPath: IndexPath) -> BattleCellViewModel? {
        guard indexPath.row < battleCellViewModels.count else { return nil }
        return battleCellViewModels[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < battleCellViewModels.count else { return }
        coordinatorDelegate?.didSelect(battle: battles[indexPath.row])
    }
    
    private func fetchBattles() {
        battles = repository.fetchAllBattles()
        viewDelegate?.battlesFetched()
    }
    
    func addBattle() {
        coordinatorDelegate?.addBattleButtonTapped()
    }
}
