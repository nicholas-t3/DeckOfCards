//
//  UIViewControllerExtension.swift
//  DeckOfCards
//
//  Created by Nicholas Towery on 11/17/20.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentErrorToUser(localizedError: LocalizedError) {
        
        let alertController = UIAlertController(title: "Error", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Ok bro", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}
