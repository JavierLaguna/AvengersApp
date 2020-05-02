//
//  AvengersRepository.swift
//  AvengersApp
//
//  Created by Javier Laguna on 27/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

protocol AvengersRepository {
    // MARK: Creates
    func createAvenger() -> Avenger?
    
    // MARK: Fetchs
    func fetchAllAvengers() -> [Avenger]
    func fetchAvengerBy(name: String) -> Avenger?
    
    // MARK: Saves
    func saveAvenger(_ avenger: Avenger)
    func saveAvengers(_ avengers: [Avenger])
    
    // MARK: Deletes
    func deleteAvenger(_ avenger: Avenger)
    func deleteAllAvengers(_ avengers: [Avenger])
}
