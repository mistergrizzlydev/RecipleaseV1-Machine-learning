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
	var currentIngredient = [String]()
	var requestRecipe = [String]()
	var ingredientsUser:String = ""

	func getUrlRequest() -> String {
		let urlYummly = "https://api.yummly.com/v1/api/recipes?_app_id=654bf699&_app_key=7c4b6ee18b43f40b31fbd410264f2376&q="
		let requiredPhoto:String = "&requirePictures=true"
		let requestRecipe:String = urlYummly + ingredientsUser + requiredPhoto
		print("getUrlRequest() : = \(requestRecipe)")
		return requestRecipe
	}

	
	func requestRecipes( callback: @escaping(Bool, String?) -> Void) {
		Alamofire.request(getUrlRequest as! URLRequestConvertible).responseJSON { response in
			guard response.response?.statusCode == 200 else {
				callback(false, nil)
				return
			}
			guard let data = response.data, response.error == nil else {
				callback(false, nil)
				return
			}
			guard let recipes = try? JSONDecoder().decode(IngredientResult.self, from: data) else {
				
				callback(false, nil)
				return
				
			}
			for i in recipes.matches {
				print("i.recipeName : \(i.recipeName)")
				callback(true, i.recipeName)
			}
			
			
		}
	}
}
