//
//  IngredientAPIResult.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 20/01/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation
import Alamofire

class RecipeAPIService{
	
	private var recipesSession:RecipesSession
	init(recipeSession: RecipesSession = RecipesSession()) {
		self.recipesSession = recipeSession
	}
	//========================================
	// MARK : - construct URL one recipe
	//========================================
	func urlConstructRecipeDetail(recipeID: String) -> String {
		return "\(recipesSession.urlStringApiDetail)\(recipeID)?_app_id=\(recipesSession.appId)&_app_key=\(recipesSession.appKey)"
	}
	
	func requestRecipeDetail(recipeID: String, completionHandler: @escaping(Bool, RecipeDetailAPIResult?) -> Void) {
		let url = urlConstructRecipeDetail(recipeID: recipeID)
		print(url)
		guard let urlString = URL(string: url) else {return} // changer avec la methode de creation
		recipesSession.request(url: urlString) { response in
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
	func urlConstructRecipeList(recipeList: [String]) -> String {
		var ingredient = ""
		for i in recipeList {
			ingredient += "&allowedIngredient[]=\(i.firstLowerCased)"
		}
		return "\(recipesSession.urlStringApi)_app_id=\(recipesSession.appId)&_app_key=\(recipesSession.appKey)\(ingredient)"
	}
	
	func requestListRecipes(recipeList: [String], completionHandler: @escaping(Bool, RecipeListAPIResult?) -> Void) {
		 let url = urlConstructRecipeList(recipeList: recipeList)
		guard let urlString = URL(string: url) else {return} // changer avec la methode de creation
		recipesSession.request(url: urlString) { response in
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
