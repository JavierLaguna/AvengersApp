//
//  HeroDetailViewModel.swift
//  AvengersApp
//
//  Created by Javier Laguna on 29/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation
import UIKit

protocol HeroDetailViewModel {
    
    // MARK: Variables
    var name: String? { get }
    var image: UIImage? { get }
    var power: Int { get }
    var biography: String? { get }
    var tintColor: UIColor { get }
    var battles: [BattleSmallCellViewModel] { get }
    
    // MARK: Public Functions
    func numberOfRows(in section: Int) -> Int
    func viewModelCell(at indexPath: IndexPath) -> BattleSmallCellViewModel?
    func didSelectRow(at indexPath: IndexPath)
    func editPower()
    func refreshHero()
}

// MARK: Default Implementation
extension HeroDetailViewModel {
    
    func numberOfRows(in section: Int) -> Int {
        return battles.count
    }
    
    func viewModelCell(at indexPath: IndexPath) -> BattleSmallCellViewModel? {
        guard indexPath.row < battles.count else { return nil }
        
        return battles[indexPath.row]
    }
}
