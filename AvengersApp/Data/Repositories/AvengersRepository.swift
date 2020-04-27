//
//  AvengersRepository.swift
//  AvengersApp
//
//  Created by Javier Laguna on 27/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

protocol AvengersRepository {
    func fetchAllAvengers() -> [Avenger]
    func createAvenger() -> Avenger?
    func saveAvenger(_ avenger: Avenger)
    func deleteAvenger(_ avenger: Avenger)
    func deleteAllAvengers(_ avengers: [Avenger])
}
