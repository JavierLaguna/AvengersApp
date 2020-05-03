//
//  CoreDataRepository.swift
//  AvengersApp
//
//  Created by Javier Laguna on 27/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

protocol CoreDataRepository {
    var database: CoreDataDatabase { get }
    var entityName: String { get }
}
