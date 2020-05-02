//
//  VillainsViewModel.swift
//  AvengersApp
//
//  Created by Javier Laguna on 28/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

protocol VillainsCoordinatorDelegate: class {
    func didSelect(villain: Villain)
}

protocol VillainsViewDelegate: class {
    func villainsFetched()
    func errorFetchingVillains()
}

class VillainsViewModel {
    weak var coordinatorDelegate: VillainsCoordinatorDelegate?
    weak var viewDelegate: VillainsViewDelegate?
    let repository: VillainsRepository
    var villainCellViewModels: [HeroCellViewModel] = []
    var villains = [Villain]() {
        didSet {
            villainCellViewModels = villains.map { HeroCellViewModel($0) }
        }
    }
    
    init(repository: VillainsRepository) {
        self.repository = repository
    }
    
    func viewWasLoaded() {
        fetchVillains()
    }
    
    func refreshVillains() {
        fetchVillains()
    }
    
    func numberOfRows(in section: Int) -> Int {
        return villainCellViewModels.count
    }
    
    func viewModelCell(at indexPath: IndexPath) -> HeroCellViewModel? {
        guard indexPath.row < villainCellViewModels.count else { return nil }
        return villainCellViewModels[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < villainCellViewModels.count else { return }
        coordinatorDelegate?.didSelect(villain: villains[indexPath.row])
    }
    
    private func fetchVillains() {
        villains = repository.fetchAllVillains()
        viewDelegate?.villainsFetched()
    }
}
