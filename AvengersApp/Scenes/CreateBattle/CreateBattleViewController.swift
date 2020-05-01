//
//  CreateBattleViewController.swift
//  AvengersApp
//
//  Created by Javier Laguna on 30/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class CreateBattleViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var battleTitleLabel: UILabel!
    @IBOutlet private weak var avengerBackgroundView: UIView!
    @IBOutlet private weak var avengerImage: UIImageView!
    @IBOutlet private weak var avengerButtonImage: UIImageView!
    @IBOutlet private weak var battleIconImage: UIImageView!
    @IBOutlet private weak var villainBackgroundView: UIView!
    @IBOutlet private weak var villainImage: UIImageView!
    @IBOutlet private weak var villainButtonImage: UIImageView!
    @IBOutlet private weak var okButton: UIButton!
    
    // MARK: Constants
    private let unselectedAlpha: CGFloat = 0.3
    private let selectedAlpha: CGFloat = 1
    let viewModel: CreateBattleViewModel
    
    
    // MARK: Lifecycle
    init(viewModel: CreateBattleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        addGestures()
    }
    
    // MARK: Private Functions
    private func configureUI() {
        avengerBackgroundView.layer.borderColor = UIColor.blueMain.cgColor
        avengerBackgroundView.layer.borderWidth = 2
        avengerBackgroundView.layer.cornerRadius = 10
        
        avengerImage.alpha = unselectedAlpha
        
        battleIconImage.bringSubviewToFront(self.view) // TODO
        
        villainBackgroundView.layer.borderColor = UIColor.redMain.cgColor
        villainBackgroundView.layer.borderWidth = 2
        villainBackgroundView.layer.cornerRadius = 10
        
        villainImage.alpha = unselectedAlpha
        
        okButton.layer.borderColor = UIColor.blueMain.cgColor
        okButton.layer.borderWidth = 4
        okButton.layer.cornerRadius = okButton.frame.height / 2
    }
    
    private func addGestures() {
        avengerButtonImage.isUserInteractionEnabled = true
        avengerButtonImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addAvenger)))
        
        villainButtonImage.isUserInteractionEnabled = true
        villainButtonImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addVillain)))
    }
    
    @objc private func addAvenger() {
        viewModel.addAvenger()
    }
    
    @objc private func addVillain() {
        viewModel.addVillain()
    }
    
    // MARK: IBActions
    @IBAction private func onTapOkButton(_ sender: Any) {
        print("OK - TODO")
    }
}

// MARK: CreateBattleViewDelegate
extension CreateBattleViewController: CreateBattleViewDelegate {
    
    func avengerDidAdded(_ avenger: Avenger) {
        guard let avengerImg = avenger.image else {
            return Log.error("Fail loading avenger image")
        }
        
        avengerImage.image = UIImage(imageLiteralResourceName: avengerImg)
        avengerImage.alpha = selectedAlpha
        avengerButtonImage.isHidden = true
    }
    
    func villainDidAdded(_ villain: Villain) {
        guard let villainImg = villain.image else {
            return Log.error("Fail loading villain image")
        }
        
        villainImage.image = UIImage(imageLiteralResourceName: villainImg)
        villainImage.alpha = selectedAlpha
        villainButtonImage.isHidden = true
    }
}
