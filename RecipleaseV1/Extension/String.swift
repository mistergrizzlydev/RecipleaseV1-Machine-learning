//
//  String.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 04/02/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation

extension String {
	var changeToArray: [String] { // transform a string to string array
		get {
			return self.components(separatedBy: .punctuationCharacters).joined().components(separatedBy: " ").filter {!$0.isEmpty }
		}
	}
	var firstUppercased:String { // replace the first letter of a string with capital letter to display
		guard let first = first else {return ""}
		return String (first).uppercased() + dropFirst()
	}
	var firstLowerCased:String { // replace the first letter of a string with lower letter to url
		guard let first = first else {return ""}
		return String (first).lowercased() + dropFirst()
	}
	var updateSizeUrlImageString: String { // chnage url size : 90 px to 360px
		return self.dropLast(2) + "360"
	}
}
