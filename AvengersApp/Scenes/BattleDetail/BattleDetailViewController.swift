//
//  BattleDetailViewController.swift
//  AvengersApp
//
//  Created by Javier Laguna on 02/05/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class BattleDetailViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak private var battleTitleLabel: UILabel!
    @IBOutlet weak private var avengerResultLabel: UILabel!
    @IBOutlet weak private var avengerBackgroundView: UIView!
    @IBOutlet weak private var avengerImage: UIImageView!
    @IBOutlet weak private var avengerWinImage: UIImageView!
    @IBOutlet weak private var battleIconImage: UIImageView!
    @IBOutlet weak private var villainBackgroundView: UIView!
    @IBOutlet weak private var villainImage: UIImageView!
    @IBOutlet weak private var villainWinImage: UIImageView!
    @IBOutlet weak private var villainResultLabel: UILabel!
    @IBOutlet weak private var deleteButton: UIButton!
    
    // MARK: Constants
    private let loserAlpha: CGFloat = 0.5
    private let viewModel: BattleDetailViewModel
    
    // MARK: Lifecycle
    init(viewModel: BattleDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        loadViewModelData()
    }
    
    // MARK: Private Functions
    private func configureUI() {
        avengerWinImage.isHidden = true
        villainWinImage.isHidden = true
        
        avengerBackgroundView.layer.borderColor = UIColor.blueMain.cgColor
        avengerBackgroundView.layer.borderWidth = 2
        avengerBackgroundView.layer.cornerRadius = 10
        
        battleIconImage.layer.zPosition = villainImage.layer.zPosition + 1

        villainBackgroundView.layer.borderColor = UIColor.redMain.cgColor
        villainBackgroundView.layer.borderWidth = 2
        villainBackgroundView.layer.cornerRadius = 10
            
        deleteButton.layer.borderColor = UIColor.blueMain.cgColor
        deleteButton.layer.borderWidth = 4
        deleteButton.layer.cornerRadius = deleteButton.frame.height / 2
    }
    
    private func loadViewModelData() {
        battleTitleLabel.text = viewModel.battleTitle
        
        avengerImage.image = viewModel.avengerImage
        villainImage.image = viewModel.villainImage
        
        switch viewModel.battleResult {
        case .avengerWins:
            avengerWinImage.isHidden = false
            avengerResultLabel.text = "Victoria"
            villainResultLabel.text = "Derrota"
            villainImage.alpha = loserAlpha
        case .villainWins:
            villainWinImage.isHidden = false
            villainResultLabel.text = "Victoria"
            avengerResultLabel.text = "Derrota"
            avengerImage.alpha = loserAlpha
        case .none:
            break
        }
    }
    
    @IBAction private func onTapDeleteButton(_ sender: Any) {
        showDeleteAlert(title: "¿Seguro que quieres borrar esta Batalla?") { [weak self] in
            self?.viewModel.deleteBattle()
        }
    }
}
