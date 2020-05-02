//
//  EditHeroPowerViewController.swift
//  AvengersApp
//
//  Created by Javier Laguna on 02/05/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class EditHeroPowerViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var powerImage: UIImageView!
    @IBOutlet private weak var powerSlider: UISlider!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var saveButton: UIButton!
    
    // MARK: Constants
    private let powerIconPath = "ic_stars_"
    private let viewModel: EditHeroPowerViewModel
    
    // MARK: Lifecycle
    init(viewModel: EditHeroPowerViewModel) {
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
        let blurEffect = UIBlurEffect(style: .light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = view.bounds
        view.addSubview(blurredEffectView)
        view.sendSubviewToBack(blurredEffectView)
        
        powerSlider.minimumValue = 1
        powerSlider.maximumValue = 5
    }
    
    private func loadViewModelData() {
        powerSlider.value = Float(viewModel.power)
        setPowerImage(for: viewModel.power)
        
        titleLabel.textColor = viewModel.tintColor
        powerImage.tintColor = viewModel.tintColor
        powerSlider.tintColor = viewModel.tintColor
        saveButton.backgroundColor = viewModel.tintColor
    }
    
    private func setPowerImage(for power: Int) {
        let powerValue = power <= 5 ? power : 5
        let image = UIImage(imageLiteralResourceName: "\(powerIconPath)\(powerValue)")
        powerImage.image = image
    }
    
    // MARK: IBActions
    @IBAction private func sliderDidChanged(_ sender: Any) {
        setPowerImage(for: Int(powerSlider.value))
    }
    
    @IBAction private func tapOnCancelButton(_ sender: Any) {
        viewModel.viewDidFinish()
    }
    
    @IBAction private func tapOnSaveButton(_ sender: Any) {
        viewModel.savePower(Int(powerSlider.value))
    }
}
