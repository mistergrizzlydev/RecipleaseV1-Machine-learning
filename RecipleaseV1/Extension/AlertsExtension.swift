//
//  Alerts.swift
//  BaluchonV1
//
//  Created by VINCENT BOULANGER on 04/12/2018.
//  Copyright © 2018 VBoulanger. All rights reserved.
//

import Foundation

import UIKit
//============================================================
// MARK: - Extension UIViewController - Alerts Management
//============================================================
extension UIViewController {
	func presentAlert() { // currency 's alert
		let alertVC = UIAlertController(title: "Erreur", message: "The request failed", preferredStyle: .alert)
		alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
		present(alertVC, animated: true, completion: nil)
	}
	func alertEmptyTextField() {
		let alertVC = UIAlertController(title: "Erreur", message: "The textfield can't to be empty", preferredStyle: .alert)
		alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
		present(alertVC, animated: true, completion : nil)
	}
}
