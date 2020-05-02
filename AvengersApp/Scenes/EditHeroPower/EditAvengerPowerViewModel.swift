//
//  EditAvengerPowerViewModel.swift
//  AvengersApp
//
//  Created by Javier Laguna on 02/05/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class EditAvengerPowerViewModel: EditHeroPowerViewModel {
    
    // MARK: Constants
    private let avenger: Avenger
    private let repository: AvengersRepository
    
    // MARK: Variables
    weak var coordinatorDelegate: EditHeroPowerCoordinatorDelegate?
    
    // MARK: Lifecycle
    init(_ avenger: Avenger, repository: AvengersRepository) {
        self.avenger = avenger
        self.repository = repository
    }
    
    // MARK: EditHeroPowerViewModel
    var power: Int { Int(avenger.power) }
    var tintColor: UIColor { .blueMain }
    
    // MARK: Public Functions
    func savePower(_ newPower: Int) {
        let powerDidChange = newPower != power
        if powerDidChange {
            avenger.power = Int16(newPower)
            repository.saveAvenger(avenger)
        }
        
        coordinatorDelegate?.viewDidFinish(powerDidChange: powerDidChange)
    }
    
    func viewDidFinish() {
        coordinatorDelegate?.viewDidFinish(powerDidChange: false)
    }
}
