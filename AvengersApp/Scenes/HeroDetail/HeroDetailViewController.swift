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
    @IBOutlet private weak var battlesCollectionView: UICollectionView!
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
        
        configureBattlesCollection()
        loadHeroDetails()
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.viewDidFinish()
    }
    
    // MARK: Private Functions
    private func configureBattlesCollection() {
        battlesCollectionView.register(UINib(nibName: BattleSmallCell.nibName, bundle: nil), forCellWithReuseIdentifier: BattleSmallCell.defaultReuseIdentifier)
        
        battlesCollectionView.dataSource = self
        battlesCollectionView.delegate = self
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
        
        if viewModel.battles.isEmpty {
            battlesCollectionView.removeFromSuperview()
        } else {
            battlesCollectionView.reloadData()
        }
    }
    
    private func setPowerImage(for power: Int) {
        let powerValue = power <= 5 ? power : 5
        let image = UIImage(imageLiteralResourceName: "\(powerIconPath)\(powerValue)")
        powerImage.image = image
    }
    
    // MARK: IBActions
    @IBAction private func onTapEditPowerButton(_ sender: Any) {
        viewModel.editPower()
    }
}

// MARK: UICollectionViewDataSource
extension HeroDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = battlesCollectionView.dequeueReusableCell(withReuseIdentifier: BattleSmallCell.defaultReuseIdentifier, for: indexPath) as? BattleSmallCell,
            let cellViewModel = viewModel.viewModelCell(at: indexPath) else {
                return UICollectionViewCell()
        }
        
        cell.viewModel = cellViewModel
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension HeroDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

// MARK: AvengerDetailViewDelegate
extension HeroDetailViewController: AvengerDetailViewDelegate {
    
    func avengerFetched() {
        loadHeroDetails()
    }
}

// MARK: VillainDetailViewDelegate
extension HeroDetailViewController: VillainDetailViewDelegate {
    
    func villainFetched() {
        loadHeroDetails()
    }
}
