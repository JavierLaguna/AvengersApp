//
//  UIViewController.swift
//  AvengersApp
//
//  Created by Javier Laguna on 01/05/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(_ alertMessage: String,
                   _ alertTitle: String = "Error",
                   _ alertActionTitle: String = "OK", completion: ((UIAlertAction) -> Void)? = nil) {
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: alertActionTitle, style: .default, handler: completion))
        present(alertController, animated: true, completion: nil)
    }
    
    func showDeleteAlert(title: String, onAccept: @escaping () -> Void) {
        let yesAction = UIAlertAction(title: "Borrar", style: .destructive, handler: { _ in
            onAccept()
        })
        let noAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let alert = UIAlertController(title: title, message: "La acción no podrá deshacerse", preferredStyle: .alert)
        alert.addAction(noAction)
        alert.addAction(yesAction)
        
        self.present(alert, animated: true)
    }
}
