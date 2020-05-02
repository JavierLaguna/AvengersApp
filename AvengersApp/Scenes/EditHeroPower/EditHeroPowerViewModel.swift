//
//  EditHeroPowerViewModel.swift
//  AvengersApp
//
//  Created by Javier Laguna on 02/05/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

protocol EditHeroPowerCoordinatorDelegate: class {
    func viewDidFinish(powerDidChange: Bool)
}

protocol EditHeroPowerViewModel {
    
    // MARK: Variables
    var power: Int { get }
    var tintColor: UIColor { get }

    // MARK: Public Functions
    func savePower(_ newPower: Int)
    func viewDidFinish()
}
