//
//  EditVillainPowerViewModel.swift
//  AvengersApp
//
//  Created by Javier Laguna on 02/05/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class EditVillainPowerViewModel: EditHeroPowerViewModel {
    
    // MARK: Constants
    private let villain: Villain
    private let repository: VillainsRepository
    
    // MARK: Variables
    weak var coordinatorDelegate: EditHeroPowerCoordinatorDelegate?
    
    // MARK: Lifecycle
    init(_ villain: Villain, repository: VillainsRepository) {
        self.villain = villain
        self.repository = repository
    }
    
    // MARK: EditHeroPowerViewModel
    var power: Int { Int(villain.power) }
    var tintColor: UIColor { .redMain }
    
    // MARK: Public Functions
    func savePower(_ newPower: Int) {
        let powerDidChange = newPower != power
        if powerDidChange {
            villain.power = Int16(newPower)
            repository.saveVillain(villain)
        }
        
        coordinatorDelegate?.viewDidFinish(powerDidChange: powerDidChange)
    }
    
    func viewDidFinish() {
        coordinatorDelegate?.viewDidFinish(powerDidChange: false)
    }
}
