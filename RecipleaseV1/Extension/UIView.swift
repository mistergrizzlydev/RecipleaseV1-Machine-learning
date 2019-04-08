//
//  UIView.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 08/04/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import UIKit
//============================================================
// MARK: - Extension UIView - gradient Colors -> Currency App
//============================================================
extension UIView {
	func gradientColorBackground(colorOne: UIColor, colorTwo: UIColor) {
		let gradient = CAGradientLayer()
		gradient.frame = bounds
		gradient.colors = [colorOne.cgColor, colorTwo.cgColor]
		gradient.locations = [0.0, 1.0]
		gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
		gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
		layer.insertSublayer(gradient, at: 0)
	}
}
