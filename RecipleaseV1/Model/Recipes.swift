//
//  Recipes.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 23/01/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation
struct Recipes {
	let id: String
	let recipeName: String
	let smallImageUrls: [String]
	let totalTimeInSeconds: Int // transformer en string
	let ingredients: [String]
	let rating: Int
}
