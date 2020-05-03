//
//  MainTabBarViewModel.swift
//  AvengersApp
//
//  Created by Javier Laguna on 03/05/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

protocol MainTabBarViewDelegate: class {
    func settingsFetched()
}

class MainTabBarViewModel {
    
    // MARK: Constants
    private let repository: SettingsRepository
    let tabs: [UINavigationController]
    
    // MARK: Variables
    weak var viewDelegate: MainTabBarViewDelegate?
    var selectedTab: Tabs
    
    // MARK: Lifecycle
    init(tabs: [UINavigationController], repository: SettingsRepository) {
        self.tabs = tabs
        self.repository = repository
        self.selectedTab = .avengers
    }
    
    // MARK: Public Functions
    func viewWasLoaded() {
        guard let settingSelectedTab = repository.getSelectedTab() else {
            return
        }
         
        self.selectedTab = Tabs(rawValue: settingSelectedTab) ?? .avengers
        viewDelegate?.settingsFetched()
     }
    
    func updateSelectedTab(with tag: Int) {
        guard let newTab = Tabs(rawValue: tag) else {
            return
        }
        
        repository.setSelectedTab(tag: newTab.rawValue)
    }
}
