//
//  Allergies.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 23/01/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation

//struct Allergies {
//	var nameAllergy = ""
//	var allergy = false
//
//	static let list = [
//		Allergies(nameAllergy: "Gluten", allergy: true),
//		Allergies(nameAllergy: "Lactose", allergy: true),
//		Allergies(nameAllergy: "Latex", allergy: true),
//		Allergies(nameAllergy: "Egg", allergy: true),
//		Allergies(nameAllergy: "Arachide", allergy: true),
//	]
//}
struct Allergies {
	var allergy = [String: Bool]()
	static let list = [
		Allergies(allergy: ["Gluten": false]),
		Allergies(allergy: ["Lactose": false]),
		Allergies(allergy: ["Latex": false]),
		Allergies(allergy: ["Egg": false]),
		Allergies(allergy: ["Arachide": false])
	]
}








//enum Allergies: String {
//	case gluten = "gluten"
//	case lactose = "lactose"
//	case latex = "latex"
//	case egg = "egg"
//	case arachide = "arachide"
//
//}
