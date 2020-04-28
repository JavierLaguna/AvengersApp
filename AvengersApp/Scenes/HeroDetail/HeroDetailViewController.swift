//
//  HeroDetailViewController.swift
//  AvengersApp
//
//  Created by Javier Laguna on 28/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class HeroDetailViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var heroImage: UIImageView!
    @IBOutlet private weak var powerImage: UIImageView!
    @IBOutlet private weak var powerLabel: UILabel!
    @IBOutlet private weak var biographyTitleLabel: UILabel!
    @IBOutlet private weak var biographyContentLabel: UILabel!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: Private Functions
    private func configureUI() {
        // TODO FIX
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
    
}
