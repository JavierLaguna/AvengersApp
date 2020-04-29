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
    @IBOutlet private weak var editPowerButton: UIButton!
    @IBOutlet private weak var biographyTitleLabel: UILabel!
    @IBOutlet private weak var biographyContentLabel: UILabel!
    
    // MARK: Constants
    let powerIconPath = "ic_stars_"
    let viewModel: HeroDetailViewModel
    
    // MARK: Lifecycle
    init(viewModel: HeroDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        configureUI()
        loadHeroDetails()
    }
    
    // MARK: Private Functions
    private func configureUI() {
        // TODO FIX
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
    
    private func loadHeroDetails() {
        title = viewModel.name
        heroImage.image = viewModel.image
        setPowerImage(for: viewModel.power)
        biographyContentLabel.text = viewModel.biography
        
        powerImage.tintColor = viewModel.tintColor
        powerLabel.textColor = viewModel.tintColor
        editPowerButton.tintColor = viewModel.tintColor
        biographyTitleLabel.textColor = viewModel.tintColor
        biographyContentLabel.textColor = viewModel.tintColor
    }
    
    private func setPowerImage(for power: Int) {
        let powerValue = power <= 5 ? power : 5
        let image = UIImage(imageLiteralResourceName: "\(powerIconPath)\(powerValue)")
        powerImage.image = image
    }
    
    // MARK: IBActions
    @IBAction private func onTapEditPowerButton(_ sender: Any) {
        print("EDIT")
    }
}
