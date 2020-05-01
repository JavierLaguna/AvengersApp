//
//  BattlesRepository.swift
//  AvengersApp
//
//  Created by Javier Laguna on 01/05/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

protocol BattlesRepository {
    func fetchAllBattles() -> [Battle]
    func createBattle() -> Battle?
    func saveBattle(_ battle: Battle)
    func saveBattles(_ battles: [Battle])
    func deleteBattle(_ battle: Battle)
    func deleteAllBattles(_ battles: [Battle])
}
