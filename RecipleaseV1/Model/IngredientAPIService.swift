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
class IngredientAPIService {

	var ingredientsUser:String = ""

	
	func getUrlRequest(ingredients: [IngredientsSearch]) -> String {
		
//		let ingredientsParameters = ingredients.map({String($0.rawValue)}).joined(separator: "+")
		let urlYummly = "https://api.yummly.com/v1/api/recipes?_app_id=654bf699&_app_key=7c4b6ee18b43f40b31fbd410264f2376&q="
		
		let requiredPhoto:String = "&requirePictures=true"

		let requestRecipe:String = urlYummly + ingredientsUser + requiredPhoto

		print("var ingredient12:String = \(requestRecipe)")
		return requestRecipe
	}

	
	func requestRecipes(ingredients: [IngredientsSearch], callback: @escaping(Bool, String?) -> Void) {
		Alamofire.request(getUrlRequest as! URLRequestConvertible).responseJSON { response in
			guard response.response?.statusCode == 200 else {
				callback(false, nil)
				return
			}
			guard let data = response.data else {
				callback(false, nil)
				return
			}
//			guard let recipes = try? JSONDecoder().decode(IngredientResult.self, from: data), let usdRates  )
//				else {
//					callback(false, nil)
//					return
//			}
//			callback(true, usdRates)
		}
	}
}
