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
    private let selectedTabKey = "UD_SelectedTabKey"
    
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
    
    func getSelectedTab() -> Int? {
        UserDefaults.standard.value(forKey: selectedTabKey) as? Int
    }
    
    func setSelectedTab(tag: Int) {
        UserDefaults.standard.set(tag, forKey: selectedTabKey)
    }
}
