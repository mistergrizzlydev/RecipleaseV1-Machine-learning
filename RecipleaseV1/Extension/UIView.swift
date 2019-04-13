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
	func convertToImage() -> UIImage? {
		//Creates a bitmap-based graphics context with the specified options.
		UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
		//Renders a snapshot of the complete view hierarchy as visible onscreen into the current context.
		drawHierarchy(in: bounds, afterScreenUpdates: true)
		//Removes the current bitmap-based graphics context from the top of the stack.
		guard let image = UIGraphicsGetImageFromCurrentImageContext() else  {return nil}
		UIGraphicsEndImageContext()
		return image
	}
}
