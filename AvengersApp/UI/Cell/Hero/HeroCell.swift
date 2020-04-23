//
//  HeroCell.swift
//  AvengersApp
//
//  Created by Javier Laguna on 23/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class HeroCell: UITableViewCell, NibLoadableView, ReusableView {
    
    //MARK: IBOutlets
    @IBOutlet private weak var heroImage: UIImageView!
    @IBOutlet private weak var heroLabel: UILabel!
    @IBOutlet private weak var powerImage: UIImageView!
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()

    }
}
