//
//  BattleSmallCell.swift
//  AvengersApp
//
//  Created by Javier Laguna on 02/05/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class BattleSmallCell: UICollectionViewCell, NibLoadableView, ReusableView  {
    
    // MARK: IBOutlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: Variables
    var viewModel: BattleSmallCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            titleLabel.text = viewModel.battleTitle
            switch viewModel.winner {
            case .avengerWins:
                containerView.backgroundColor = .blueMain
            case .villainWins:
                containerView.backgroundColor = .redMain
            case .none:
                break
            }
        }
    }
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    // MARK: Private Functions
    private func configureUI() {
        containerView.layer.cornerRadius = 10
    }
}
