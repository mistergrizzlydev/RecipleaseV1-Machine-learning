//
//  FixerService.swift
//  RecipleaseV1Tests
//
//  Created by VINCENT BOULANGER on 26/03/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation
class UrlService {
	private var urlSession: UrlSession
//	var recipeDetailAPIResult = RecipeDetailAPIResult!
	init(urlSession: UrlSession = UrlSession()) {
		self.urlSession = urlSession
	}
	//========================================
	// MARK : - construct URL list of recipes
	//========================================
	func requestListRecipes(recipeList: [String], completionHandler: @escaping(Bool, RecipeListAPIResult?) -> Void) {
		//let url = urlConstructRecipeList(recipeList: recipeList)
		guard let urlString = URL(string: urlSession.urlStringApiList) else {return} // changer avec la methode de creation
		urlSession.requestList(url: urlString) { response in
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
	//========================================
	// MARK : - construct URL recipe detail
	//========================================
	func requestRecipeDetail(recipeID: String, completionHandler: @escaping(Bool, RecipeDetailAPIResult?) -> Void) {
		let url = URL(string: urlSession.urlStringApiDetail)!
		print(url)
		//guard let urlString = URL(string: url) else {return} // changer avec la methode de creation
		urlSession.requestDetail(url: url) { response in
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
}

