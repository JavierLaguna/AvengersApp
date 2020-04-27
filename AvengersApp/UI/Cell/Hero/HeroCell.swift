//
//  HeroCell.swift
//  AvengersApp
//
//  Created by Javier Laguna on 23/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class HeroCell: UITableViewCell, NibLoadableView, ReusableView {
    
    // MARK: IBOutlets
    @IBOutlet private weak var heroImage: UIImageView!
    @IBOutlet private weak var heroLabel: UILabel!
    @IBOutlet private weak var powerImage: UIImageView!
    
    // MARK: Constants
    let powerIconPath = "ic_stars_"
    
    // MARK: Variables
    var viewModel: HeroCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            heroImage.image = viewModel.image
            heroLabel.text = viewModel.nameTitle
            
            heroLabel.textColor = viewModel.tintColor
            powerImage.tintColor = viewModel.tintColor
            
            setPowerImage(for: viewModel.power)
        }
    }
    
    // MARK: Private functions
    private func setPowerImage(for power: Int) {
        let powerValue = power <= 5 ? power : 5
        let image = UIImage(imageLiteralResourceName: "\(powerIconPath)\(powerValue)")
        powerImage.image = image
    }
}
