//
//  VillainsRepository.swift
//  AvengersApp
//
//  Created by Javier Laguna on 28/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

protocol VillainsRepository {
    // MARK: Creates
    func createVillain() -> Villain?

    // MARK: Fetchs
    func fetchAllVillains() -> [Villain]
    func fetchVillainBy(name: String) -> Villain?

    // MARK: Saves
    func saveVillain(_ villain: Villain)
    func saveVillains(_ villains: [Villain])
    
    // MARK: Deletes
    func deleteVillain(_ villain: Villain)
    func deleteAllVillains(_ villains: [Villain])
}
