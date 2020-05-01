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
    @IBOutlet private weak var avengerBorderView: UIView!
    @IBOutlet private weak var villainImage: UIImageView!
    @IBOutlet private weak var villainBorderView: UIView!
    
    // MARK: Variables
    var viewModel: BattleCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            // TODO
        }
    }
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
       
        configureUI()
    }
    
    // MARK: Private functions
    private func configureUI() {
        avengerBorderView.layer.cornerRadius = 4
        villainBorderView.layer.cornerRadius = 4
    }
}
