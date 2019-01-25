//
//  Ingredients.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 24/01/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation

struct Recipes {
	static var shared = Recipes()
	init(){}

	var ingredientsUserToUrl:String = ""
	var currentIngredient = [String]()
}


//class SpendingService {
//	static var shared = SpendingService()
//	private init() {}
//
//	private(set) var spendings = [Spending]()
//
//	func add(spending: Spending) {
//		spendings.append(spending)
//	}
//}
