//
//  IngredientAPIResult.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 20/01/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation
import Alamofire
import CoreData


//		let addIngredient = "&allowedIngredient[]="
//		let addAllergy = "&allowedAllergy[]="
//onion+soup&requirePictures = true
class RecipeAPIService{
	
	private var recipesSession:RecipesSession
	
	init(recipeSession: RecipesSession = RecipesSession()) {
		self.recipesSession = recipeSession
	}
	
	//var requestRecipe = [String]()
	
	func requestRecipes( completionHandler: @escaping(Bool, RecipeAPIResult?) -> Void) {
		guard let url = URL(string: recipesSession.urlStringApi) else {return}
		recipesSession.request(url: url) { response in
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
