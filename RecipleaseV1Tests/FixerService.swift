//
//  FixerService.swift
//  RecipleaseV1Tests
//
//  Created by VINCENT BOULANGER on 26/03/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation
class FixerService {
	private var fixerSession: FixerSession
	//var recipe : RecipeDetailAPIResult?
	init(fixerSession: FixerSession = FixerSession()) {
		self.fixerSession = fixerSession
	}
	func requestRecipeDetail(recipeID: String, completionHandler: @escaping(Bool, RecipeDetailAPIResult?) -> Void) {
		let url = URL(string: fixerSession.urlStringApiDetail)!
		print(url)
		//guard let urlString = URL(string: url) else {return} // changer avec la methode de creation
		fixerSession.request(url: url) { response in
			guard response.response?.statusCode == 200 else {
				completionHandler(false, nil)
				return
			}
			guard let data = response.data, response.error == nil else {
				completionHandler(false, nil)
				return
			}
			guard let recipes = try? JSONDecoder().decode(RecipeDetailAPIResult.self, from: data) else {
				completionHandler(false, nil)
				return
			}
			print("recipes.name: \(recipes)")
			completionHandler(true, recipes)
		}
	}
	//========================================
	// MARK : - construct URL list of recipes
	//========================================
	
	func requestListRecipes(recipeList: [String], completionHandler: @escaping(Bool, RecipeListAPIResult?) -> Void) {
		//let url = urlConstructRecipeList(recipeList: recipeList)
		guard let urlString = URL(string: fixerSession.urlStringApiDetail) else {return} // changer avec la methode de creation
		fixerSession.request(url: urlString) { response in
			guard response.response?.statusCode == 200 else {
				completionHandler(false, nil)
				return
			}
			guard let data = response.data, response.error == nil else {
				completionHandler(false, nil)
				return
			}
			guard let recipes = try? JSONDecoder().decode(RecipeListAPIResult.self, from: data) else {
				completionHandler(false, nil)
				return
			}
			completionHandler(true, recipes)
		}
	}
}

