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
	
	func presentAlert(title: String, message: String) { // currency 's alert
		let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
		present(alertVC, animated: true, completion: nil)
	}
//	func alertEmptyTextField() { // translation's alert
//		let alertVC = UIAlertController(title: "Favorites", message: "The recipe has been added to your favorites", preferredStyle: .alert )
//		alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
//		present(alertVC, animated: true, completion : nil)
//	}
}
