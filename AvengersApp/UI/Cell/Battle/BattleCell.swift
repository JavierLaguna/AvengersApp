//
//  BattleCell.swift
//  AvengersApp
//
//  Created by Javier Laguna on 29/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class BattleCell: UITableViewCell, NibLoadableView, ReusableView {
    
    // MARK: IBOutlets
    @IBOutlet private weak var battleLabel: UILabel!
    @IBOutlet private weak var avengerImage: UIImageView!
    @IBOutlet private weak var avengerWinImage: UIImageView!
    @IBOutlet private weak var avengerBorderView: UIView!
    @IBOutlet private weak var villainImage: UIImageView!
    @IBOutlet private weak var villainWinImage: UIImageView!
    @IBOutlet private weak var villainBorderView: UIView!
    
    // MARK: Constants
    private let loserAlpha: CGFloat = 0.5
    
    // MARK: Variables
    var viewModel: BattleCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            battleLabel.text = viewModel.battleTitle
            avengerImage.image = viewModel.avengerImage
            villainImage.image = viewModel.villainImage
            
            switch viewModel.battleWinner {
            case .avengerWins:
                villainImage.alpha = loserAlpha
                villainWinImage.isHidden = true
            case.villainWins:
                avengerImage.alpha = loserAlpha
                avengerWinImage.isHidden = true
            case .none:
                avengerWinImage.isHidden = true
                villainWinImage.isHidden = true
            }
        }
    }
        
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    override func prepareForReuse() {
        viewModel = nil
        
        avengerWinImage.isHidden = false
        villainWinImage.isHidden = false

        avengerImage.alpha = 1.0
        villainImage.alpha = 1.0
    }
    
    // MARK: Private functions
    private func configureUI() {
        avengerBorderView.layer.cornerRadius = 4
        villainBorderView.layer.cornerRadius = 4
    }
}
