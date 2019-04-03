//
//  IngredientDataModel.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 20/01/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation

struct RecipeListAPIResult: Decodable {
	let matches: [Match]
	let totalMatchCount: Int
}

struct Match: Decodable {
	let id: String
	let recipeName: String
	let smallImageUrls: [String]?
	let totalTimeInSeconds: Int
	let sourceDisplayName: String
	let ingredients: [String]
	let rating: Int
}
struct ImageUrlsBySize: Decodable {
	let the90: String
}
