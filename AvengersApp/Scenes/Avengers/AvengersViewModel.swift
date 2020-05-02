//
//  AvengersViewModel.swift
//  AvengersApp
//
//  Created by Javier Laguna on 27/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

protocol AvengersCoordinatorDelegate: class {
    func didSelect(avenger: Avenger)
}

protocol AvengersViewDelegate: class {
    func avengersFetched()
    func errorFetchingAvengers()
}

class AvengersViewModel {
    weak var coordinatorDelegate: AvengersCoordinatorDelegate?
    weak var viewDelegate: AvengersViewDelegate?
    let repository: AvengersRepository
    var avengerCellViewModels: [HeroCellViewModel] = []
    var avengers = [Avenger]() {
        didSet {
            avengerCellViewModels = avengers.map { HeroCellViewModel($0) }
        }
    }
    
    init(repository: AvengersRepository) {
        self.repository = repository
    }
    
    func viewWasLoaded() {
        fetchAvengers()
    }
    
    func refreshAvengers() {
        fetchAvengers()
    }
    
    func numberOfRows(in section: Int) -> Int {
        return avengerCellViewModels.count
    }
    
    func viewModelCell(at indexPath: IndexPath) -> HeroCellViewModel? {
        guard indexPath.row < avengerCellViewModels.count else { return nil }
        return avengerCellViewModels[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < avengerCellViewModels.count else { return }
        coordinatorDelegate?.didSelect(avenger: avengers[indexPath.row])
    }
    
    private func fetchAvengers() {
        avengers = repository.fetchAllAvengers()
        viewDelegate?.avengersFetched()
    }
}
