//
//  IngredientAPIResult.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 20/01/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation
import Alamofire
//import CoreData


//		let addIngredient = "&allowedIngredient[]="
//		let addAllergy = "&allowedAllergy[]="
//onion+soup&requirePictures = true


class RecipeAPIService{
	
	private var recipesSession:RecipesSession
	
	init(recipeSession: RecipesSession = RecipesSession()) {
		self.recipesSession = recipeSession
	}
	
	func urlConstructRecipeList(recipeList: [String]) -> String {
		var ingredient = ""
		for i in recipeList {
			ingredient += "&allowedIngredient[]=\(i.firstLowerCased)"
		}
		return "\(recipesSession.urlStringApi)_app_id=\(recipesSession.appId)&_app_key=\(recipesSession.appKey)\(ingredient)"
	}
	
	func requestRecipes(recipeList: [String], completionHandler: @escaping(Bool, RecipeAPIResult?) -> Void) {
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
			guard let recipes = try? JSONDecoder().decode(RecipeAPIResult.self, from: data) else {
				completionHandler(false, nil)
				return
			}
			completionHandler(true, recipes)
		}
	}
}
