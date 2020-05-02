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
    
    // MARK: Constants
    let repository: BattlesRepository
    
    // MARK: Variables
    weak var coordinatorDelegate: BattlesCoordinatorDelegate?
    weak var viewDelegate: BattlesViewDelegate?
    var battleCellViewModels: [BattleCellViewModel] = []
    var battles = [Battle]() {
        didSet {
            battleCellViewModels = battles.map { BattleCellViewModel($0) }
        }
    }
    
    // MARK: Lifecycle
    init(repository: BattlesRepository) {
        self.repository = repository
    }
    
    // MARK: Public Functions
    func viewWasLoaded() {
        fetchBattles()
    }
    
    func refreshData() {
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
        guard indexPath.row < battles.count else { return }
        
        coordinatorDelegate?.didSelect(battle: battles[indexPath.row])
    }
    
    func deleteRow(at indexPath: IndexPath) {
        guard indexPath.row < battles.count else { return }
        
        let battle = battles[indexPath.row]
        repository.deleteBattle(battle)
        
        refreshData()
    }
    
    func addBattle() {
        coordinatorDelegate?.addBattleButtonTapped()
    }
    
    // MARK: Private Functions
    private func fetchBattles() {
        battles = repository.fetchAllBattles()
        viewDelegate?.battlesFetched()
    }
}
