//
//  SettingsRepository.swift
//  AvengersApp
//
//  Created by Javier Laguna on 28/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

protocol SettingsRepository {
    func isFirstAppLaunch() -> Bool
    func setFirstAppLaunch(_ value: Bool)
}
