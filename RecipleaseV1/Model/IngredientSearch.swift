//
//  IngredientSearch.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 22/01/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation

import Foundation
//import Alamofire
//import CoreData

enum IngredientsSearch: String {
	case ingredient1 = "onion"
	case ingredient2 = "soup"
	
	var test: [String] {
		switch self {
		case .ingredient1:
			return [""]
		case .ingredient2:
			return [""]
		}
	}
}
