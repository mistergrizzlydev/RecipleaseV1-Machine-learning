//
//  Recipe.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 22/02/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation

struct RecipeDetailAPIResult: Decodable {
	let yield: String
	//let nutritionEstimates: [NutritionEstimate]
	let prepTimeInSeconds: Int
	let totalTime: String
	let images: [Image]
	let name: String
	let source: Source
	let prepTime, id: String
	let ingredientLines: [String]
	let cookTime: String
	let attribution: Attribution
	let numberOfServings, totalTimeInSeconds: Int
	let attributes: Attributes
	let cookTimeInSeconds: Int
	//let flavors: Flavors
	let rating: Int
}

struct Attributes: Decodable {
	let course, cuisine: [String]
}

struct Attribution: Decodable {
	let html: String
	let url: String
	let text: String
	let logo: String
}

//struct Flavors: Decodable {
//}

struct Image: Decodable {
	let hostedSmallURL, hostedMediumURL, hostedLargeURL: String
	let imageUrlsBySize: [String: String]
}

//struct NutritionEstimate: Decodable {
//	let attribute: String
//	let description: String?
//	let value: Double
//	let unit: Unit
//}

struct Unit: Decodable {
	let id: String
	//let name: Name
	//let abbreviation: Abbreviation
	//let plural: Plural
	//let pluralAbbreviation: Abbreviation
	let decimal: Bool
}

//enum Abbreviation: Decodable {
//	case g
//	case grams
//	case iu
//	case kcal
//	case mcgDFE
//	case mcgRAE
//}
//
//enum Name: Decodable {
//	case calorie
//	case gram
//	case iu
//	case mcgDFE
//	case mcgRAE
//}

//enum Plural {
//	case calories
//	case grams
//	case iu
//	case mcgDFE
//	case mcgRAE
//}

struct Source: Decodable {
	let sourceDisplayName: String
	let sourceSiteURL: String
	let sourceRecipeURL: String
}
