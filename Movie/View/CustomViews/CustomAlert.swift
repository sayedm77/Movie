//
//  CustomAlert.swift
//  Movie
//
//  Created by sayed mansour on 28/09/2024.
//


import UIKit

extension UIViewController{
    func presentErrorAlert(message: String) {
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
}
