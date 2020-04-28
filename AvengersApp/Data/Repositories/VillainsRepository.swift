//
//  VillainsRepository.swift
//  AvengersApp
//
//  Created by Javier Laguna on 28/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

protocol VillainsRepository {
    func fetchAllVillains() -> [Villain]
    func createVillain() -> Villain?
    func saveVillain(_ villain: Villain)
    func saveVillains(_ villains: [Villain])
    func deleteVillain(_ villain: Villain)
    func deleteAllVillains(_ villains: [Villain])
}
