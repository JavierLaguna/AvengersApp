//
//  SettingsRepositoryUserDefaults.swift
//  AvengersApp
//
//  Created by Javier Laguna on 28/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

struct SettingsRepositoryUserDefaults: SettingsRepository {
    
    // MARK: UserDefaults keys
    private let firstAppLaunchKey = "UD_FirstAppLaunchKey"
    
    // MARK: SettingsRepository
    func isFirstAppLaunch() -> Bool {
        guard let isFirstAppLaunch = UserDefaults.standard.value(forKey: firstAppLaunchKey) as? Bool else {
            return true
        }
        
        return isFirstAppLaunch
    }
    
    func setFirstAppLaunch(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: firstAppLaunchKey)
    }
}
