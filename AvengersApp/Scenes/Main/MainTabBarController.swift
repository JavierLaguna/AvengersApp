//
//  MainTabBarController.swift
//  AvengersApp
//
//  Created by Javier Laguna on 03/05/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: Constants
    let viewModel: MainTabBarViewModel
    
    // MARK: LifeCycle
    init(viewModel: MainTabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTabBar()
        loadTabs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.viewWasLoaded()
    }
    
    // MARK: Private functions
    private func configureUI() {
        UINavigationBar.appearance().tintColor = .blueMain
        
        tabBar.tintColor = UIColor.blueMain
    }
    
    private func configureTabBar() {
        delegate = self
    }
    
    private func loadTabs() {
        viewControllers = viewModel.tabs
    }
}

// MARK: UITabBarControllerDelegate
extension MainTabBarController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        viewModel.updateSelectedTab(with: item.tag)
    }
}

// MARK: MainTabBarViewDelegate
extension MainTabBarController: MainTabBarViewDelegate {
    
    func settingsFetched() {
        selectedIndex = viewModel.selectedTab.rawValue
    }
}
