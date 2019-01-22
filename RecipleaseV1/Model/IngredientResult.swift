//
//  IngredientDataModel.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 20/01/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation

struct IngredientResult: Decodable {
	let criteria: Criteria
	let matches: [Match]
	let facetCounts: FacetCounts
	let totalMatchCount: Int
	let attribution: Attribution
}

struct Attribution: Decodable {
	let html: String
	let url: String
	let text: String
	let logo: String
}

struct Criteria: Decodable {
	let q: String
	let requirePictures: Bool
	//let allowedIngredient, excludedIngredient: NSNull
}

struct FacetCounts: Decodable {
}

struct Match: Decodable {
	let imageUrlsBySize: ImageUrlsBySize
	let sourceDisplayName: String
	let ingredients: [String]
	let id: String
	let smallImageUrls: [String]
	let recipeName: String
	let totalTimeInSeconds: Int
	//let attributes: Attributes
	let flavors: Flavors
	let rating: Int
}

struct Attributes {
	let course: [Course]
	let cuisine: [Cuisine]
}

enum Course {
	case soups
}

enum Cuisine {
	case french
}

struct Flavors: Decodable {
	let piquant, meaty, bitter, sweet: Double
	let sour, salty: Double
}

struct ImageUrlsBySize: Decodable {
	let the90: String
}
