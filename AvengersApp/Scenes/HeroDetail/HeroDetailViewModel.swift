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
    var name: String? { get }
    var image: UIImage? { get }
    var power: Int { get }
    var biography: String? { get }
    var tintColor: UIColor { get }
}
