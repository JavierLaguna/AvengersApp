//
//  Log.swift
//  AvengersApp
//
//  Created by Javier Laguna on 28/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

final class Log {
    static func error(_ text: Any?, file: String = #file, line: Int = #line) {
        guard let text = text else { return }
        print("ERROR: \(text) \nat \(line): \(file)")
    }
}
